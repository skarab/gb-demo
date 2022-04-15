using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.IO;
using System.Text;

public class ExportTorus : MonoBehaviour
{
	private const string _Path = @"D:\prog\gameboy\data\torus.bytes";
	private List<Color[]> _framesData = null;
	private float _angle = 0;
	private const int _size = 16;
	private const int _angleStep = 20;

	void Start()
	{
		transform.rotation = Quaternion.identity;
		_framesData = new List<Color[]>();
	}

	void Update()
	{
		transform.rotation = Quaternion.Euler(new Vector3(0.0f, _angle, 90.0f));
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

		for (int y = 0; y < _size; ++y)
		{
			for (int x = 0; x < _size * _framesData.Count; ++x)
			{
				int f = x / _size;
				data[y * (_size * _framesData.Count) + x] = (byte)(_framesData[f][(_size - y - 1) * _size + (x-f*_size)].r * 255.0f);
			}
		}
	
		File.WriteAllBytes(_Path, data);
	}
}
