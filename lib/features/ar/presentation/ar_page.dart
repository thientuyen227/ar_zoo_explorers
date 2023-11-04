// import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:ar_zoo_explorers/features/ar/presentation/ar_cubit.dart';
import 'package:ar_zoo_explorers/features/ar/presentation/ar_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  // ARSessionManager? arSessionManager;

  bool download = false;

  // @override
  // void dispose() {
  //   super.dispose();
  //   arSessionManager?.dispose();
  // }

  @override
  Widget buildByState(BuildContext context, ARState arState) {
    return Scaffold(
        body: Column(children: [
      // Expanded(
      //   child: ARView(
      //     onARViewCreated: cubit.onARViewCreated,
      //     planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
      //   ),
      // ),
      Row(
        children: [
          // Center(
          //   child: IconButton(
          //     icon: const Icon(Icons.delete),
          //     onPressed: cubit.onRemoveEverything,
          //   ),
          // ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  child: _buildAnimalListView()),
            ),
          ),
        ],
      )
    ]));
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

          return ListView.separated(
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
                    future: cubit.downloadModel(template.name),
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
                                    cubit.valueName = template.name;
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
                                        cubit.downloadAndUnpack(template.id,
                                            template.link, template.name);
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
              });
        });
  }
}
