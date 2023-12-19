import 'dart:io';

import 'package:ar_zoo_explorers/core/data/controller/animal_controller.dart';
import 'package:ar_zoo_explorers/features/ar/presentation/ar_cubit.dart';
import 'package:ar_zoo_explorers/features/ar/presentation/ar_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/icons.dart';
import '../../../base/base_state.dart';

@RoutePage()
class ARPage extends StatefulWidget {
  const ARPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<ARState, ARCubit, ARPage> {
  //ARSessionManager? arSessionManager;
  final animalController = AnimalController.findOrInitialize;

  bool download = false;

  UnityWidgetController? unityWidgetController;

  @override
  Widget buildByState(BuildContext context, ARState arState) {
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
              child: Container(
                color: AppColor.blue,
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
                  ],
                ),
              )),
          Positioned(
              right: 0,
              bottom: 25,
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        // sendMessageToUnity("StartAnimation");
                      },
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
        ]),
      ),
    );
  }

  Future<void> onUnityCreated(UnityWidgetController controller) async {
    print("QQQQQQQ3");

    unityWidgetController = controller;

    unityWidgetController?.postMessage(
        "AICamera", "onFlutterMessage", "ResetModel");
    sendMessageToUnity(animalController.currentAnimal.value.name,
        animalController.currentAnimal.value.type);
  }

  void onUnityMessage(dynamic data) {
    print("QQQQQQ $data");
  }

  Future<void> sendMessageToUnity(String valueName, String type) async {
    Map<String, dynamic> url = await cubit.getFilePath(valueName, type);

    File filePath = url['file'];

    print("TTTT: ${filePath.path}");

    unityWidgetController?.postMessage(
        "AICamera", "onFlutterMessage", "FilePath: ${filePath.path}");
  }
}
