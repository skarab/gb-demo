using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.IO;
using System.Text;

public class ExportLandscape : MonoBehaviour
{
	private const string _Path = @"D:\prog\gameboy\demo\data\landscape.h";
	private int _angle = 0;
	private Mesh _mesh;
	private Vector3[] _vertices;
	private const float _size = 1.0f;
	private const int _gridSize = 10;
	private List<List<Vector2Int>> _framesData = null;

	void Start()
	{
		transform.rotation = Quaternion.identity;

		_mesh = new Mesh();
		GetComponent<MeshFilter>().mesh = _mesh;

		_vertices = new Vector3[_gridSize*_gridSize];
		_mesh.vertices = _vertices;

		int[] triangles = new int[(_gridSize-1) * (_gridSize-1) * 6];
		for (int j = 0; j < _gridSize -1; ++j)
		{
			for (int i = 0; i < _gridSize - 1; ++i)
			{
				int id = (j * (_gridSize-1) + i) * 6;
				int x = i;
				int y = j;

				triangles[id] = y * _gridSize + x;
				triangles[id + 1] = y * _gridSize + x + 1;
				triangles[id + 2] = (y + 1) * _gridSize + x;

				triangles[id + 3] = (y + 1) * _gridSize + x;
				triangles[id + 4] = y * _gridSize + x + 1;
				triangles[id + 5] = (y + 1) * _gridSize + x + 1;
			}
		}
		_mesh.triangles = triangles;

		_framesData = new List<List<Vector2Int>>();
	}

	void Update()
	{
		transform.rotation = Quaternion.Euler(new Vector3(0.0f, _angle, 0.0f));

		for (int j = 0; j < _gridSize; ++j)
		{
			for (int i = 0; i < _gridSize; ++i)
			{
				float y = Mathf.Sin((_angle + i + j) * Mathf.Deg2Rad) * 0.2f + Mathf.Cos((_angle + i * 10) * Mathf.Deg2Rad) * 0.2f + Mathf.Sin((_angle + i*j * 2) * Mathf.Deg2Rad) * 0.3f;
				_vertices[j * _gridSize + i] = new Vector3(i * _size / (_gridSize - 1.0f) - _size / 2.0f, y, _size / 2.0f - j * _size / (_gridSize - 1.0f));
			}
		}

		_mesh.vertices = _vertices;

		List<Vector2Int> frameData = new List<Vector2Int>();
		for (int i = 0; i < _vertices.Length; ++i)
		{
			Vector3 vertex = Camera.main.WorldToScreenPoint(transform.localToWorldMatrix.MultiplyPoint(_vertices[i]));
			frameData.Add(new Vector2Int((int)Mathf.Clamp(vertex.x, 0.0f, 159.0f), (int)Mathf.Clamp(vertex.y, 10.0f, 143.0f)));
		}
		_framesData.Add(frameData);

		_angle += 10;
		if (_angle >= 360-10)
		{
			Export();
			UnityEditor.EditorApplication.isPlaying = false;
		}
	}

	private void Export()
	{
		string data = "const UINT8 resources_landscape_data[] = {\n";
		
		for (int i = 0; i < _framesData.Count; ++i)
		{
			for (int j = 0; j < _framesData[i].Count; ++j)
			{
				data += _framesData[i][j].x.ToString() + ", " + (144-_framesData[i][j].y).ToString();
				
				if (!(i == _framesData.Count - 1 && j == _framesData[i].Count - 1))
				{
					data += ", ";
				}
			}
			data += "\n";
		}

		data += "};\n";
		data += "const unsigned int resources_landscape_frames = " + _framesData.Count + ";\n";

		File.WriteAllBytes(_Path, Encoding.ASCII.GetBytes(data));
	}
}
