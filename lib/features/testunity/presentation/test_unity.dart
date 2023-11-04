import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../app/theme/icons.dart';

@RoutePage()
class TestUnity extends StatefulWidget {
  const TestUnity({super.key});

  @override
  State<TestUnity> createState() => _TestUnityState();
}

class _TestUnityState extends State<TestUnity> {
  late UnityWidgetController _unityWidgetController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: <Widget>[
          UnityWidget(
            onUnityCreated: onUnityCreated,
            onUnityMessage: onUnityMessage,
          ),
          Positioned(
              top: 0,
              right: 10,
              child: Row(
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(AppIcons.icFeed),
                        iconSize: 40,
                      ),
                      const Text(
                        "Feed",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )
                    ],
                  ),
                  buttonMenu(),
                ],
              )),
          Positioned(
              right: 0,
              bottom: 25,
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.push_pin),
                      color: Colors.white,
                      iconSize: 40),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.volume_up),
                      color: Colors.white,
                      iconSize: 40),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.lock_open_outlined),
                      color: Colors.white,
                      iconSize: 40)
                ],
              )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 5.0)),
              child: GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(msg: "Click!!!");
                },
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.amber),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void onUnityCreated(UnityWidgetController controller) {}

  void onUnityMessage(dynamic data) {
    Map<String, dynamic> message = jsonDecode(data);
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  Widget buttonMenu() {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
            child:
                IconButton(onPressed: () {}, icon: const Icon(Icons.ac_unit)))
      ],
    );
  }
}
