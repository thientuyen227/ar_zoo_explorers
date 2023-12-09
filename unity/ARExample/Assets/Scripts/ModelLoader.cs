using FlutterUnityIntegration;
using Siccity.GLTFUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.Networking;

public class ModelLoader : MonoBehaviour
{
    GameObject wrapper;
    string filePath;
    // Start is called before the first frame update
    void Start()
    {
        filePath = $"{Application.persistentDataPath}/Files/";
        wrapper = new GameObject
        {
            name="Model"
        };
        UnityMessageManager.Instance.OnMessage += onUnityMessage;
    }

    void onUnityMessage(String message)
    {
        Debug.Log(message);
        if(!string.IsNullOrEmpty(message))
        {
            DownloadFile(message);
        }
    }
    private void OnDestroy()
    {
        UnityMessageManager.Instance.OnMessage -= onUnityMessage;
    }
    string getPathFile(string url)
    {
        string[] pieces = url.Split('/');
        string fileName = pieces[pieces.Length - 1];
        return $"{filePath}{fileName}";
    }

    IEnumerator getFileRequest(string url, Action<UnityWebRequest> callback)
    {
        Debug.Log(url);
        using(UnityWebRequest req = UnityWebRequest.Get(url))
        {
            req.downloadHandler = new DownloadHandlerFile(getPathFile(url));
            yield return req.SendWebRequest();
            callback(req);
        }
    }

    public void DownloadFile(string url)
    {
        string path = getPathFile(url);
        if (File.Exists(path))
        {
            Debug.Log("Found file locally, loading...");
            loadModel(path);
            return;
        }

        StartCoroutine(getFileRequest(url, (UnityWebRequest req) =>
        {
            if(req.isNetworkError || req.isHttpError)
            {
                Debug.Log($"{req.error} : {req.downloadHandler.text}");
            }
            else
            {
                loadModel(path);
            }
        }));
    }
    void loadModel(string path)
    {
        ResetWrapper();
        GameObject model = Importer.LoadFromFile(path);
        model.transform.SetParent(wrapper.transform);
    }
    void ResetWrapper()
    {
        if(wrapper != null)
        {
            foreach(Transform t in wrapper.transform)
            {
                Destroy(t.gameObject);
            }
        }
    }
    // Update is called once per frame
    void Update()
    {
        
    }
}
