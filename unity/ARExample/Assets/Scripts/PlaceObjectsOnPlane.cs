using FlutterUnityIntegration;
using Newtonsoft.Json;
using Siccity.GLTFUtility;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.Networking;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;

[RequireComponent(typeof(ARRaycastManager))]
public class PlaceObjectsOnPlane : MonoBehaviour
{
    [SerializeField]
    [Tooltip("Instantiates this prefab on a plane at the touch location.")]
    GameObject m_PlacedPrefab;

    [SerializeField]
    GameObject visualObject;

    public GameObject placedPrefab
    {
        get { return m_PlacedPrefab; }
        set { m_PlacedPrefab = value; }
    }

    public GameObject spawnedObject { get; private set; }
    public static event Action onPlacedObject;

    ARRaycastManager m_RaycastManager;
    static List<ARRaycastHit> s_Hits = new List<ARRaycastHit>();

    [SerializeField]
    int m_MaxNumberOfObjectsToPlace = 1;
    int m_NumberOfPlacedObjects = 0;

    [SerializeField]
    bool m_CanReposition = true;
    GameObject wrapper;
    public bool canReposition
    {
        get => m_CanReposition;
        set => m_CanReposition = value;
    }

    string filePath;

    void Awake()
    {
        m_RaycastManager = GetComponent<ARRaycastManager>();
        UnityMessageManager.Instance.OnMessage += onUnityMessage;
        wrapper = new GameObject
        {
            name = "Model"
        };
    }

    void Update()
    {
        if (Input.touchCount > 0)
        {
            Touch touch = Input.GetTouch(0);

            if (touch.phase == TouchPhase.Began)
            {
                if (m_RaycastManager.Raycast(touch.position, s_Hits, TrackableType.PlaneWithinPolygon))
                {
                    Pose hitPose = s_Hits[0].pose;

                    if (m_NumberOfPlacedObjects < m_MaxNumberOfObjectsToPlace)
                    {
                        spawnedObject = LoadModel(filePath, hitPose.position, hitPose.rotation);
                        m_NumberOfPlacedObjects++;
                    }
                    else
                    {
                        if (m_CanReposition)
                        {
                            spawnedObject.transform.SetPositionAndRotation(hitPose.position, hitPose.rotation);
                        }
                    }

                    if (onPlacedObject != null)
                    {
                        onPlacedObject();
                    }
                }
            }
        }
    }

    public void DiableVisual()
    {
        visualObject.SetActive(false);
    }

    void onUnityMessage(String message)
    {
        filePath = message;
    }

    private void OnDestroy()
    {
        UnityMessageManager.Instance.OnMessage -= onUnityMessage;
    }

    public void onFlutterMessage(string message)
    {
        UnityMessageManager.Instance.SendMessageToFlutter("QQQQQ1");
    }

    // Tích hợp logic của ModelLoader vào PlaceObjectsOnPlane
    GameObject LoadModel(string path, Vector3 position, Quaternion rotation)
    {
        // Thêm logic của ModelLoader vào đây
        ResetWrapper();
        

        GameObject model = Importer.LoadFromFile(path);
        model.transform.SetParent(wrapper.transform);
        model.transform.position = position;
        model.transform.rotation = rotation;
        return model;
    }

    void ResetWrapper()
    {
        if (wrapper != null)
        {
            foreach (Transform t in wrapper.transform)
            {
                Destroy(t.gameObject);
            }
        }
    }
}
