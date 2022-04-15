using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class ExportTunnelVideo : MonoBehaviour
{
	private const string _Path = @"D:\prog\gameboy\data\tunnel_video.bytes";
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
		transform.rotation = Quaternion.Euler(new Vector3(Mathf.Sin(_angle * 2.0f * Mathf.Deg2Rad) * 4.0f, _angle, 0.0f));
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
		
		for (int i = 0; i < _framesData.Count; ++i)
		{
			for (int y = 0; y < 18; ++y)
			{
				for (int x = 0; x < 20; ++x)
				{
					byte p = (byte)Mathf.Clamp(_framesData[i][(17 - y) * 20 + x].r * 12.0f, 0.0f, 12.0f);
					framesData[(20 * 18) * i + y * 20 + x] = p;
				}
			}
		}

		byte[] fileData = new byte[1 + framesData.Length];
		fileData[0] = (byte)_framesData.Count;
		System.Array.Copy(framesData, 0, fileData, 1, framesData.Length);

		File.WriteAllBytes(_Path, fileData);
	}
}
