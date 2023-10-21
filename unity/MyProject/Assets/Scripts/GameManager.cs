using System.Collections;
using System.Collections.Generic;
using FlutterUnityIntegration;
using Newtonsoft.Json;
using UnityEngine;

public class GameManger : MonoBehaviour
{
    void Start()
    {
        gameObject.AddComponent<UnityMessageManager>();
    }
    void Update()
    {
        if (Input.GetTouch(0).tapCount == 1)
        {
            Ray _ray = Camera.main.ScreenPointToRay(Input.GetTouch(0).position);
            RaycastHit _hit;
            if (Physics.Raycast(_ray, out _hit))
            {
                if (_hit.transform == transform)
                {
                    Dictionary<string, object> value = new Dictionary<string, object>();
                    value.Add("event", "onClick");
                    value.Add("data", new List<float> { Input.GetTouch(0).position.x, Input.GetTouch(0).position.y });
                    UnityMessageManager.Instance.SendMessageToFlutter(JsonConvert.SerializeObject(value));
                }
            }
        }
        //if (Input.GetMouseButtonDown(0))
        //{
        //    Ray _ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        //    RaycastHit _hit;
        //    if (Physics.Raycast(_ray, out _hit))
        //    {
        //        if (_hit.transform == transform)
        //        {
        //            Dictionary<string, object> value = new Dictionary<string, object>();
        //            value.Add("event", "onClick");
        //            value.Add("data", new List<float>{ Input.mousePosition.x, Input.mousePosition.y });

        //            Debug.Log("QQQQQQ " + JsonConvert.SerializeObject(value));
        //        }
        //    }
        //}
    }
}
