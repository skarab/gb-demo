using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.IO;
using System.Text;

public class ExportVideo : MonoBehaviour
{
	private const string _Path = @"D:\prog\gameboy\data\cube.bytes";
	private List<Color[]> _framesData = null;
	private int _angle = 0;
	private const int _size = 32;
	private const int _angleStep = 24;

	void Start()
	{
		transform.rotation = Quaternion.identity;
		_framesData = new List<Color[]>();
	}

	void Update()
	{
		transform.rotation = Quaternion.Euler(new Vector3(_angle / 2.0f, _angle, 0.0f));
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
		byte[] data = new byte[_framesData.Count * _size * _size];

		for (int i = 0; i < _framesData.Count; ++i)
		{
			for (int j = 0; j < _framesData[i].Length; ++j)
			{
				data[i * _size * _size + j] = (byte)(_framesData[i][j].r * 255.0f);
			}
		}

		File.WriteAllBytes(_Path, data);
	}
}
