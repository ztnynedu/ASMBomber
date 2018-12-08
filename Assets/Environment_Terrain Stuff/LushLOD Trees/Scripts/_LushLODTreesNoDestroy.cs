using UnityEngine;
using System.Collections;

public class _LushLODTreesNoDestroy : MonoBehaviour {
	// Use this for initialization
	void Start () {
        DontDestroyOnLoad(this.gameObject);
	}
}
