using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;

public class ImageRecognitionEx : MonoBehaviour
{
    private ARTrackedImageManager _aRTrackedImageManager;
    private static GameObject modelPrefab; // Biến tĩnh để lưu trữ prefab của model

    private GameObject instantiatedModel;
    private void Awake()
    {
        _aRTrackedImageManager = FindObjectOfType<ARTrackedImageManager>();
        modelPrefab = Resources.Load<GameObject>("YourModelPrefabName"); // Tải prefab từ tài nguyên
    }

    private void OnEnable()
    {
        _aRTrackedImageManager.trackedImagesChanged += OnImageChanged;
    }

    private void OnDisable()
    {
        _aRTrackedImageManager.trackedImagesChanged -= OnImageChanged;
    }
    private void UpdateModel(ARTrackedImage trackedImage)
    {
        // Tạo hoặc cập nhật model
        if (instantiatedModel == null || instantiatedModel != modelPrefab)
        {
            if (instantiatedModel != null)
            {
                Destroy(instantiatedModel);
            }

            instantiatedModel = Instantiate(modelPrefab, trackedImage.transform.position, trackedImage.transform.rotation);
        }
    }

    public void OnImageChanged(ARTrackedImagesChangedEventArgs args)
    {
        foreach (var trackedImage in args.added)
        {
            Debug.Log(trackedImage.name);
        }
    }
}
