using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class ExportTunnel : MonoBehaviour
{
	private const string _Path = @"D:\prog\gameboy\data\tunnel.bytes";
	private List<Color[]> _framesData = null;
	private float _angle = 0;
	private const int _angleStep = 10;

	void Start()
	{
		transform.rotation = Quaternion.identity;
		_framesData = new List<Color[]>();
	}

	void Update()
	{
		transform.rotation = Quaternion.Euler(new Vector3(Mathf.Sin(_angle*2.0f*Mathf.Deg2Rad)*4.0f, _angle, 0.0f));
		_angle += _angleStep;
	}

	void LateUpdate()
	{
		StartCoroutine(RecordFrame());
	}

	IEnumerator RecordFrame()
	{
		yield return new WaitForEndOfFrame();
		Texture2D texture = ScreenCapture.CaptureScreenshotAsTexture();
		_framesData.Add(texture.GetPixels());
		Object.Destroy(texture);

		if (_angle >= 360 - _angleStep)
		{
			Export();
			UnityEditor.EditorApplication.isPlaying = false;
		}
	}

	private void Export()
	{
		byte[] framesData = new byte[(20 * 18) * _framesData.Count];
		List<byte[]> tiles = new List<byte[]>();

		for (int i = 0; i < _framesData.Count; ++i)
		{
			for (int y = 0; y < 18; ++y)
			{
				for (int x = 0; x < 20; ++x)
				{
					byte p0 = (byte)(_framesData[i][(y * 2) * 40 + x * 2].r * 3.0f);
					byte p1 = (byte)(_framesData[i][(y * 2) * 40 + x * 2 + 1].r * 3.0f);
					byte p2 = (byte)(_framesData[i][((y * 2) + 1) * 40 + x * 2].r * 3.0f);
					byte p3 = (byte)(_framesData[i][((y * 2) + 1) * 40 + x * 2 + 1].r * 3.0f);

					byte[] tile = new byte[] { p0, p1, p2, p3 };

					int tileId = tiles.FindIndex(t => t[0] == p0 && t[1] == p1 && t[2] == p2 && t[3] == p3);
					if (tileId == -1)
					{
						tileId = tiles.Count;
						tiles.Add(tile);
					}

					if (tileId > 255)
					{
						Debug.LogError("ARGL");
					}

					framesData[(20 * 18) * i + y * 20 + x] = (byte)tileId;
				}
			}
		}

		byte[] fileData = new byte[1 + framesData.Length + 1 + tiles.Count * 4];
		fileData[0] = (byte)_framesData.Count;
		System.Array.Copy(framesData, 0, fileData, 1, framesData.Length);
		fileData[1 + framesData.Length] = (byte)tiles.Count;

		for (int i = 0; i < tiles.Count; ++i)
		{
			System.Array.Copy(tiles[i], 0, fileData, 1 + framesData.Length + 1 + i * 4, 4);
		}

		File.WriteAllBytes(_Path, fileData);
	}
}
