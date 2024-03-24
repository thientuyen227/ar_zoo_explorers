import 'dart:io';

import 'package:ar_zoo_explorers/core/data/controller/animal_controller.dart';
import 'package:ar_zoo_explorers/features/ar/presentation/ar_cubit.dart';
import 'package:ar_zoo_explorers/features/ar/presentation/ar_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../base/base_state.dart';

@RoutePage()
class ARPage extends StatefulWidget {
  const ARPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<ARState, ARCubit, ARPage> {
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
        ]),
      ),
    );
  }

  // Future<void> onUnityCreated(UnityWidgetController controller) async {
  //   print("QQQQQQQ3");
  //   unityWidgetController = controller;

  //   controller.postMessage("AICamera", "onFlutterMessage", "ResetModel");
  //   sendMessageToUnity(animalController.currentAnimal.value.name,
  //       animalController.currentAnimal.value.type);
  // }

  // Future<void> sendMessageToUnity(String valueName, String type) async {
  //   if (valueName.isNotEmpty && type.isNotEmpty) {
  //     Map<String, dynamic> url = await cubit.getFilePath(valueName, type);
  //     File filePath = url['file'];

  //     print("TTTT: ${filePath.path}");
  //     unityWidgetController?.postMessage(
  //         "AICamera", "onFlutterMessage", "FilePath: ${filePath.path}");
  //   }
  // }

  void onUnityMessage(dynamic data) {
    print("QQQQQQ $data");
  }
}
