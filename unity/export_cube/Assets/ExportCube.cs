using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.IO;
using System.Text;

public class ExportCube : MonoBehaviour
{
	private const string _Path = @"D:\prog\gameboy\demo\data\cube.h";
	private const float s = 0.5f;
	private Vector3[] _cubeVertices = { new Vector3(-s, s, -s), new Vector3(s, s, -s), new Vector3(s, -s, -s), new Vector3(-s, -s, -s), new Vector3(-s, s, s), new Vector3(s, s, s), new Vector3(s, -s, s), new Vector3(-s, -s, s) };
	private uint[][] _cubeFaces = { new uint[] { 0, 1, 2, 3 }, new uint[] { 4, 5, 6, 7 }, new uint[] { 1, 5, 6, 2 }, new uint[] { 4, 0, 3, 7 }, new uint[] { 0, 4, 5, 1 }, new uint[] { 3, 7, 6, 2 } };
	private Vector3[] _cubeNormals = { new Vector3(0.0f, 0.0f, -1.0f), new Vector3(0.0f, 0.0f, 1.0f), new Vector3(1.0f, 0.0f, 0.0f), new Vector3(-1.0f, 0.0f, 0.0f), new Vector3(0.0f, 1.0f, 0.0f), new Vector3(0.0f, -1.0f, 0.0f) };
	private List<List<Vector2Int>> _framesData = null;
	private int _angle = 0;

	void Start()
	{
		transform.rotation = Quaternion.identity;
		_framesData = new List<List<Vector2Int>>();
	}

	void Update()
	{
		transform.rotation = Quaternion.Euler(new Vector3(_angle, _angle, 0.0f));

		Vector3 center = Camera.main.WorldToScreenPoint(Vector3.zero);
		Vector2Int cubeCenter = new Vector2Int((int)center.x, (int)center.y);

		List<KeyValuePair<uint, uint>> lineIds = new List<KeyValuePair<uint, uint>>();
		Vector2Int[] vertices = new Vector2Int[4];
		List<Vector2Int> frameData = new List<Vector2Int>();
		for (int i = 0; i < _cubeFaces.Length; ++i)
		{
			Vector3 normal = _cubeNormals[i];
			normal = transform.localToWorldMatrix.MultiplyVector(normal);
			Vector3 cam = (transform.localToWorldMatrix.MultiplyPoint(_cubeVertices[_cubeFaces[i][0]]) - Camera.main.transform.position).normalized;

			if (Vector3.Dot(normal, cam) < 0.0f)
			{
				for (int v = 0; v < 4; ++v)
				{
					uint id = _cubeFaces[i][v];
					Vector3 vertex = Camera.main.WorldToScreenPoint(transform.localToWorldMatrix.MultiplyPoint(_cubeVertices[id]));
					vertices[v] = new Vector2Int((int)vertex.x - cubeCenter.x, (int)vertex.y - cubeCenter.y);
				}

				for (int v = 0; v < 4; ++v)
				{
					uint i0 = (uint)v;
					uint i1 = (uint)((v + 1) % 4);
					uint ic0 = _cubeFaces[i][i0];
					uint ic1 = _cubeFaces[i][i1];

					if (lineIds.FindIndex(x => (x.Key == ic0 && x.Value == ic1) || (x.Key == ic1 && x.Value == ic0)) == -1)
					{
						frameData.Add(vertices[i0]);
						frameData.Add(vertices[i1]);
						lineIds.Add(new KeyValuePair<uint, uint>(ic0, ic1));
					}
				}
			}
		}

		_framesData.Add(frameData);
		
		_angle += 8;
		//++_angle; // += 2;
		if (_angle >= 360)
		{
			Export();
			UnityEditor.EditorApplication.isPlaying = false;
		}
	}

	private void Export()
	{
		string data = "const char resources_cube_data[] = {\n";
		uint size = 0;

		for (int i = 0; i < _framesData.Count; ++i)
		{
			if (i==0)
			{
				data += "    " + (_framesData[_framesData.Count - 1].Count / 2).ToString() + ", ";
			}
			else
			{
				data += "    " + (_framesData[i-1].Count / 2).ToString() + ", ";
			}
			data += "    " + (_framesData[i].Count / 2).ToString() + ", ";
			size += 2;

			for (int j = 0; j < _framesData[i].Count; ++j)
			{
				data += _framesData[i][j].x.ToString() + ", " + _framesData[i][j].y.ToString();
				size += 2;

				if (!(i==_framesData.Count-1 && j== _framesData[i].Count-1))
				{
					data += ", ";
				}
			}
			data += "\n";
		}

		data += "};\n";
		data += "const unsigned int resources_cube_data_size = " + size + ";\n";

		File.WriteAllBytes(_Path, Encoding.ASCII.GetBytes(data));
	}
}
