//by Pegmode 
#define _CRT_SECURE_NO_WARNINGS
#define LIB_MODE 0//flag to disable main/ enable library call

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <math.h>
#include <stdarg.h>
#include "patchrom.h"
//CONSTANTS
//===========================================================
#define DEFLEMASK_DATA_START 0xC0
#define VGM_SAMPLE_RATE 44100//this is rate that a vgm file samples the registers
#define GB_BANK_SIZE 0x3FFF//~16kb per bank
#define TMA_RATE0 4096//TMA rate in hz
#define TMA_RATE1 262144//TMA rate in hz
#define TMA_RATE2 65536//TMA rate in hz
#define TMA_RATE3 16384
//vgm commands
#define WRITEVGMCOMMAND 0xB3
#define WAITSTDVGMCOMMAND 0x62 //wait for a single engine frame (1/60s)
#define WAITVGMCOMMAND 0x61 //wait for xy vgm frames (1/VGM_SAMPLE_RATE)
#define ENDVGMCOMMAND 0x66
#define DATABLOCKVGMCOMMAND 0x67
#define WAITPALCOMMAND 0x63//wait for a PAL engine frame (legal in Deflemask)
//custom GB engine commands
#define WRITECUSCOMMAND 0x80//7th bit 
#define WAITCUSCOMMAND 0x40
#define NEXTBANKCUSCOMMAND 0x20
#define LOOPCUSCOMMAND 0x10
#define ENDSONGCUSCOMMAND 0x08
//ENGINE VARS
//===========================================================
#define DATA_START_BANK 0x01
#define DEFAULT_SYNC_HIGH_ADDRESS 0x80//change this to change where the sync signal writes to 
#define MAX_DATABANKS 0xFF//must be less than or equal to what the asm engine is designed to handle and never greater than 0xFF


struct VgmBuffer{//contains vgm info and file buffer for Deflemask generated GB Vgm
    uint8_t* buffer;
    int size;
    uint8_t rate;
};
typedef struct VgmBuffer VgmBuffer;

struct LoopInfo{//contains address and bank info for looping 
    int gbLoopAddress;
    int gbLoopBank;
};
typedef struct LoopInfo LoopInfo;

//Globals
//===========================================================
int EXPORTMODE = 0;//0 = patch .gb
int ENGINE_RATE = 50;//default rate to 60hz
char OUTPATH[0xFF] = "output";
char* PATCHROM_PATH = "patchROM.gb";
int TMA_OFFSET = 0;//value to add to TMA for fine control
int LOOPVGMADDR = 0;//loop address in .vgm file 0 = no loop

char* HELPSTRING = "\nHelp:\n DeflemaskGBGMConverter <input vgm> [args...]\n\
\nargs:\n\
-r <rate> set engine rate\n\
-o <outpath> set the output path\n\
-bin export as .bin file instead of patching .gb\n\
-ti <offset> increase tma offset timing (speed up song if using custom engine speed)\n\
-td <offset> decrease tma offset timing (slow down song if using custom engine speed)\n";


//CODE
//===========================================================

uint8_t vgmToGBTL(uint8_t value){//translate vgm write command destination address to actual FFxy value
    return value + 0x10;
}

void printfLibless(char* format,...){//printf only when LIB_MODE = 0 for Deflemask support requested by Delek
#if LIB_MODE
    return;
#else
    va_list args;
    va_start(args, format);
    printf(format,args);
    return;
#endif
}

void sprintfLibless(char* format,...){//sprintf only when LIB_MODE = 0 for Deflemask support requested by Delek
#if LIB_MODE
    return;
#else
    va_list args;
    va_start(args, format);
    sprintf(format,args);
    return;
#endif
}

void openFile(char* path,VgmBuffer* vgmBuffer){
    FILE *f;
    f = fopen(path,"rb");
    fseek(f,0,SEEK_END);
    int fileSize = ftell(f);
    vgmBuffer->buffer = malloc(fileSize);
    fseek(f,0,SEEK_SET);
    fread(vgmBuffer->buffer,1,fileSize,f);
    fclose(f);
    vgmBuffer->size = fileSize;
}

void checkHeader(VgmBuffer vgmBuffer){
    //test Header

    if (memcmp(vgmBuffer.buffer,"Vgm",3) != 0){
        printfLibless(".vgm header fail\n");
        exit(0);
    }
    //check gb
    int gbEmptyVal = 0;
    if (memcmp(&vgmBuffer.buffer[0x80],&gbEmptyVal,4) == 0){
        printfLibless(".vgm does not use Game Boy\n");
        exit(0);
    }
    //copy loop value
    int loopVal = 0;
    int loopSamples;//use for detecting legacy
    memcpy(&loopSamples,&vgmBuffer.buffer[0x20],4);
    if (loopSamples != 0){//check for legacy Deflemask .vgm bug
        memcpy(&loopVal,&vgmBuffer.buffer[0x1C],4);
    }
    if(loopVal > 0x1C){
        loopVal += 0x1C;//calculate offset val
    }
    LOOPVGMADDR = loopVal;
}

int checkIfBankEnd(int currentOutputPos,int distance){//check if a given write operation to the output buffer will fall outside a Game Boy ROM bank
    if((currentOutputPos + distance + 1) > GB_BANK_SIZE){//add 1 so we make sure we have room for bank
        return 1;
    }
    else{
        return 0;
    }
}

int samplesToFrames(int engineRate,int samples){//calculate the number of frames based on number of samples
    float frameCount = ((float)samples / (float)VGM_SAMPLE_RATE) / (1 / (float)engineRate);
    //printf("frameCount: %u\nengineRate: %u\nsamples: %u\n",frameCount,engineRate,samples);
    if (frameCount != (int)frameCount){
        double whole;
        float fractional = modf(frameCount, &whole);
        if (fractional < 0.99){
            printfLibless("ERROR: Frame calculation failure. Engine tick rate of %uhz is likely incorrect. Use -r argumment to change engine rate\n",ENGINE_RATE);
            exit(1);
        }
        whole++;
        frameCount = whole;
    }
    return (int)frameCount;
}

int calculateTMAModulo(int tmaRate){//calculate the modulo value to use
    float floatDistance = (float)tmaRate/(float)ENGINE_RATE;
    double whole;
    float fract;
    fract = modf(floatDistance,&whole);
    if (fract >= 0.5){
        whole++;
    }
    return 0xFF-(int)whole;
}


void checkVgmIsDeflemask(VgmBuffer vgmBuffer){
    uint8_t deflemaskFooter[] = {0x44, 0x00, 0x65, 0x00, 0x66, 0x00, 0x6C, 0x00, 0x65, 0x00, 0x4D, 0x00, 0x61, 0x00, 0x73, 0x00, 0x6B, 0x00, 0x20, 0x00, 0x54, 0x00, 0x72, 0x00, 0x61, 0x00, 0x63, 0x00, 0x6B, 0x00, 0x65, 0x00, 0x72, 0x00, 0x00, 0x00, 0x00, 0x00,};
    uint8_t footerBuffer[0x26];
    memcpy(footerBuffer,&vgmBuffer.buffer[vgmBuffer.size-0x26],0x26);
    if(memcmp(deflemaskFooter,footerBuffer,0x26) != 0){
        printfLibless("vgm was not Generated by Deflemask. Only Deflemask .vgms are supported.");
        exit(1);
    }
}

void writeAllBanks(uint8_t** banks,int numBanks){
    char outputName[0xFF];
    for(int i = 0; i <= numBanks; i++){
        sprintf(outputName,"%s%u.bin",OUTPATH,i);
        FILE *f = fopen(outputName,"wb");
        fwrite(banks[i],1,GB_BANK_SIZE,f);
        fclose(f);
    }
}

void patchROM(uint8_t** banks,int numBanks, LoopInfo loopInfo){
    //load patch ROM into buffer
    uint8_t* patchBuffer = malloc(gb_patch_rom_length + (numBanks + 1) * 0x4000);
    memcpy(patchBuffer, gb_patch_rom, gb_patch_rom_length);
    //copy bank buffer 
    for (int i = 0; i < numBanks+1; i++){
        memcpy(&patchBuffer[0x4000+i*0x4000],banks[i],0x3FFF);
    }
    // write TMA 
    int tmaDistance = 0;
    if (ENGINE_RATE != 60){
        tmaDistance = calculateTMAModulo(TMA_RATE0);
        patchBuffer[0x02] = 4;
    }
    else{
        patchBuffer[0x02] = 0;
    }
    //write loop data
    if (LOOPVGMADDR != 0){
        memcpy(&patchBuffer[0x03],&loopInfo.gbLoopAddress,2);
        memcpy(&patchBuffer[0x05],&loopInfo.gbLoopBank,2);
    }

    patchBuffer[0x01] = tmaDistance + TMA_OFFSET;

    char outROMPath[0xFF];
    sprintf(outROMPath,"%s.gb",OUTPATH);
    if(OUTPATH[strlen(OUTPATH)-3]!='.'){
        sprintf(outROMPath,"%s.gb",OUTPATH);
    }
    else{//deflemask call compatibility  
        sprintf(outROMPath,"%s",OUTPATH);
    }
    FILE* f = fopen(outROMPath,"wb");
    printfLibless("GB ROM final output Size: %ubytes\n",0x4000 * (gb_patch_rom_length + 1));
    int outputSize = gb_patch_rom_length + 0x4000 * (numBanks + 1);
    fwrite(patchBuffer,1,outputSize,f);
    fclose(f);
    free(patchBuffer);

}

void convertToNewFormat(VgmBuffer vgmBuffer){
    LoopInfo loopInfo;
    loopInfo.gbLoopAddress = 0;
    loopInfo.gbLoopBank = 0;
    int currentVgmPos = DEFLEMASK_DATA_START;
    int currentBank = 0;//NOT TRUE BANK, is position in output array
    int currentOutputPos = 0;
    int notEndOfFile = 1;
    uint8_t* output[0xFF];//array of banks
    while(notEndOfFile){//we don't know how many banks the output will take up ahead of time
        //create new block
            //while in block parse until we hit the maxsize
            //create new ,
        uint8_t* currentBankBuffer = malloc(GB_BANK_SIZE);
        memset(currentBankBuffer,0,GB_BANK_SIZE);
        currentOutputPos = 0;
        int notEndOfBank = 1 ;
        while(notEndOfBank){
            if (currentVgmPos == LOOPVGMADDR){//checkForLoop
                printfLibless("loop found!\n");
                loopInfo.gbLoopAddress = currentOutputPos + 0x4000;
                loopInfo.gbLoopBank = currentBank+ DATA_START_BANK;
                printfLibless("DEBUG loop adr %X\nloopBank %X\n",loopInfo.gbLoopAddress,loopInfo.gbLoopBank);
            }
            switch(vgmBuffer.buffer[currentVgmPos]){
                case WRITEVGMCOMMAND://write to 0xFFXX
                    if (checkIfBankEnd(currentOutputPos,3)){
                        notEndOfBank = 0;    
                        currentBankBuffer[currentOutputPos] = NEXTBANKCUSCOMMAND;
                    }
                    else{
                        currentBankBuffer[currentOutputPos] = WRITECUSCOMMAND;//write new command
                        currentVgmPos++;
                        currentOutputPos++;
                        currentBankBuffer[currentOutputPos] = vgmToGBTL(vgmBuffer.buffer[currentVgmPos]);//write address
                        currentVgmPos++;
                        currentOutputPos++;
                        currentBankBuffer[currentOutputPos] = vgmBuffer.buffer[currentVgmPos];//write value
                        currentVgmPos++;
                        currentOutputPos++;
                    }                                       
                    break;
                case WAITVGMCOMMAND://wait for XX frames
                    if (checkIfBankEnd(currentOutputPos,3)){
                        notEndOfBank = 0;    
                        currentBankBuffer[currentOutputPos] = NEXTBANKCUSCOMMAND;
                    }
                    else{
                        //be careful: calculate frames from number of samples
                        currentBankBuffer[currentOutputPos] = WAITCUSCOMMAND;//write new command
                        currentOutputPos++;
                        currentVgmPos++;
                        int highV = (int)vgmBuffer.buffer[currentVgmPos];
                        currentVgmPos++;
                        int lowV = (int)vgmBuffer.buffer[currentVgmPos];
                        int numberOfSamples = (lowV << 8) | highV;//mask 16bit 
                        int numberOfFrames = samplesToFrames(ENGINE_RATE,numberOfSamples);//change 60 to be scanned value later
                        currentBankBuffer[currentOutputPos] = numberOfFrames;
                        currentVgmPos++;
                        currentOutputPos++; 
                    }
                    break;
                case WAITSTDVGMCOMMAND://wait for 1 frame in 60hz engine rate
                    if (checkIfBankEnd(currentOutputPos,3)){
                        notEndOfBank = 0;   
                        currentBankBuffer[currentOutputPos] = NEXTBANKCUSCOMMAND; 
                    }
                    else{
                        currentBankBuffer[currentOutputPos] = WAITCUSCOMMAND;//write new command
                        currentOutputPos++;
                        currentBankBuffer[currentOutputPos] = 1;
                        currentVgmPos++;
                        currentOutputPos++;
                    }
                    break;

                case DATABLOCKVGMCOMMAND://write data to 0xFF<SYNC_ADDRESS> +=9
                    if (checkIfBankEnd(currentOutputPos,3)){
                        notEndOfBank = 0;    
                        currentBankBuffer[currentOutputPos] = NEXTBANKCUSCOMMAND;
                    }
                    else{
                        currentVgmPos += 9;//jump to data block value
                        currentBankBuffer[currentOutputPos] = WRITECUSCOMMAND;
                        currentOutputPos++;
                        currentBankBuffer[currentOutputPos] = DEFAULT_SYNC_HIGH_ADDRESS;
                        currentOutputPos++;
                        currentBankBuffer[currentOutputPos] = vgmBuffer.buffer[currentVgmPos];
                        currentVgmPos++;
                        currentOutputPos++;
                    }
                    break;
                case WAITPALCOMMAND:
                    if (checkIfBankEnd(currentOutputPos,3)){
                        notEndOfBank = 0;   
                        currentBankBuffer[currentOutputPos] = NEXTBANKCUSCOMMAND; 
                    }
                    else{
                        if(ENGINE_RATE != 50){
                            static int alreadyWarned = 0;
                            if (alreadyWarned == 0)
                            {
                                printfLibless("Warning: PAL wait tick found in non PAL timed module! Did you enter the correct engine speed?\n");
                                alreadyWarned = 1;
                            }
                            //exit(1);
                        }
                        currentBankBuffer[currentOutputPos] = WAITCUSCOMMAND;//write new command
                        currentOutputPos++;
                        currentBankBuffer[currentOutputPos] = 1;
                        currentVgmPos++;
                        currentOutputPos++;
                    }
                break;
                case ENDVGMCOMMAND://end the song
                    printfLibless("VGM end found!\n");
                    if (LOOPVGMADDR == 0){
                        currentBankBuffer[currentOutputPos] = ENDSONGCUSCOMMAND;//write new command

                    }
                    else{
                        currentBankBuffer[currentOutputPos] = LOOPCUSCOMMAND;//write new command

                    }
                    currentOutputPos++;
                    notEndOfBank = 0;
                    notEndOfFile = 0;
                    break;
                default:
                    printfLibless("Error while parsing vgm commands, incorrect command found\n");
                    exit(1);
            }
        }
    output[currentBank] = currentBankBuffer;
    if (notEndOfFile){
        currentBank++;
    }
    }

    
    if (EXPORTMODE){//if asm export mode was enabled
        if (ENGINE_RATE != 60){
            int tmaDistance = calculateTMAModulo(TMA_RATE0);
            printfLibless("Non-vBlank Engine speed found, set TMA to = 0x%X\n",tmaDistance);
        }
        writeAllBanks(output,currentBank);       
    }
    else{
        patchROM(output,currentBank, loopInfo);
    }

    printfLibless("Conversion Complete!\n%u banks used\n",currentBank+1);
}

void parseArgs(int argc, char** argv){
    if (argc < 2){
        printfLibless("Must give a .vgm as argument to program\n");
        printfLibless(HELPSTRING);
        exit(1);
    }
    for (int i = 2; i < argc; i++){
        if(strcmp("-r",argv[i]) == 0){//rate
            i++;
            ENGINE_RATE = atoi(argv[i]);
            printfLibless("Engine rate set to %u\n",ENGINE_RATE);
        }
        else if(strcmp("-o",argv[i]) == 0){//output path
            i++;
            strcpy(OUTPATH,argv[i]);
        }
        else if(strcmp("-h",argv[i]) == 0){//help 
            printfLibless(HELPSTRING);
            exit(1);
        }
        else if(strcmp("-bin",argv[i]) == 0){//
            EXPORTMODE = 1;
        }
        else if(strcmp("-td",argv[i]) == 0){//tma decrease
            TMA_OFFSET = -atoi(argv[++i]);
        }
        else if(strcmp("-ti",argv[i]) == 0){//tma increase
            TMA_OFFSET = atoi(argv[++i]);
        }
    }   

}
#if LIB_MODE
int gbvgm(char *vgm_source_path, int hz, char* romPath){  // For .gb creation in library mode
    EXPORTMODE = 0;
    TMA_OFFSET = 0;
    ENGINE_RATE = hz;
    strcpy(OUTPATH,romPath);
    VgmBuffer vgmBuffer;
    openFile(vgm_source_path,&vgmBuffer);
    checkHeader(vgmBuffer);
    checkVgmIsDeflemask(vgmBuffer);
    convertToNewFormat(vgmBuffer);
    free(vgmBuffer.buffer);
    return 0;
}
#else
int main(int argc, char* argv[]){
    parseArgs(argc,argv);
    printfLibless("RUNNING\n");
    VgmBuffer vgmBuffer;
    printfLibless("OPENING .vgm\n");    
    openFile(argv[1],&vgmBuffer);
    printfLibless("OPENED\n");
    checkHeader(vgmBuffer);
    printfLibless("Header Check passed!\n");
    checkVgmIsDeflemask(vgmBuffer);
    printfLibless("Deflemask Footer check passed!\n");
    convertToNewFormat(vgmBuffer);
    free(vgmBuffer.buffer);
    return 0;
}
#endif