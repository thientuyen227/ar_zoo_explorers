import 'dart:io';

import 'package:ar_zoo_explorers/features/ar/presentation/ar_cubit.dart';
import 'package:ar_zoo_explorers/features/ar/presentation/ar_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

import '../../../app/theme/colors.dart';
import '../../../app/theme/icons.dart';
import '../../../base/base_state.dart';
import '../../../core/data/models/animal_model.dart';

@RoutePage()
class ARPage extends StatefulWidget {
  const ARPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<ARState, ARCubit, ARPage> {
  //ARSessionManager? arSessionManager;

  bool download = false;

  String valueName = "";

  String type = "";

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
          _buildAnimalListView()
        ]),
      ),
    );
  }

  Widget _buildAnimalListView() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream:
            FirebaseFirestore.instance.collection('animal_models').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          List<AnimalModel> data = snapshot.data!.docs
              .map((e) => AnimalModel.fromMap(e.data()))
              .toList();

          return Container(
            height: 100,
            color: Colors.amber,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(right: 50),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 0,
                  );
                },
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  var template = data.elementAt(index);

                  return FutureBuilder(
                      future: cubit.downloadModel(template.name, template.type),
                      builder: (context, snapshot) {
                        final isDownload = snapshot.data;

                        return Padding(
                          padding: const EdgeInsets.only(top: 15.0, right: 10),
                          child: Column(
                            children: [
                              Stack(children: [
                                Container(
                                  width: 70,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColor.blue.withOpacity(0.5),
                                          width: 2.0)),
                                  child: GestureDetector(
                                    onTap: () {
                                      valueName = template.name;

                                      type = template.type;
                                    },
                                    child: Center(
                                        child: Image.asset(
                                      template.icon,
                                      height: 45,
                                      width: 45,
                                    )),
                                  ),
                                ),
                                if (isDownload == false)
                                  Positioned(
                                    bottom: -9,
                                    right: -12,
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Center(
                                          child: IconButton(
                                        onPressed: () {
                                          cubit.downloadAndUnpack(
                                              template.name, template.type);

                                          valueName = template.name;

                                          type = template.type;
                                        },
                                        icon: Image.asset(
                                          AppIcons.icDownload,
                                          height: 24,
                                          width: 24,
                                        ),
                                      )),
                                    ),
                                  ),
                                const SizedBox(
                                  height: 20,
                                )
                              ]),
                              Text(template.title),
                            ],
                          ),
                        );
                      });
                }),
          );
        });
  }

  Future<void> onUnityCreated(UnityWidgetController controller) async {
    print("QQQQQQQ3");

    // Map<String, dynamic> url = {"file": File("/data/data/com.ttcompany.ar_zoo_explorers/files/BlackCat.glb")};

    Map<String, dynamic> url = await cubit.getFilePath(valueName, type);

    File filePath = url['file'];

    print("mylink: ${filePath.path}");

    controller.postMessage("AICamera", "onFlutterMessage", filePath.path);
  }

  void onUnityMessage(dynamic data) {
    print("QQQQQQ $data");
  }
}
