import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

@RoutePage()
class TestUnity extends StatefulWidget {
  const TestUnity({super.key});

  @override
  State<TestUnity> createState() => _TestUnityState();
}

class _TestUnityState extends State<TestUnity> {
  @override
  Widget build(BuildContext context) {
    return UnityWidget(
      onUnityCreated: onUnityCreated,
      onUnityMessage: onUnityMessage,
    );
  }

  void onUnityCreated(UnityWidgetController controller) {}

  void onUnityMessage(dynamic data) {
    Map<String, dynamic> message = jsonDecode(data);
    List<double> points =
        (message["data"] as List<dynamic>).map((e) => e as double).toList();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: const Text(
            "Warrok!!!!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }
}
