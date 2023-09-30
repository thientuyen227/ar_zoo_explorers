import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/features/ar/model/ar_item.dart';
import 'package:ar_zoo_explorers/features/ar/presentation/ar_cubit.dart';
import 'package:ar_zoo_explorers/features/ar/presentation/ar_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../base/base_state.dart';
import '../../../utils/widget/spacer_widget.dart';
import '../model/ar_type.dart';

@RoutePage()
class ARPage extends StatefulWidget {
  const ARPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<ARState, ARCubit, ARPage> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  @override
  void dispose() {
    super.dispose();
    arSessionManager?.dispose();
  }

  @override
  Widget buildByState(BuildContext context, ARState arState) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        child: ARView(
          onARViewCreated: cubit.onARViewCreated,
          planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
        ),
      ),
      BottomAppBar(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: cubit.onRemoveEverything,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final item = cubit.ARItems[index];
                        return _buildARItem(item);
                      },
                      separatorBuilder: (context, index) => const VSpacing(),
                      itemCount: cubit.ARItems.length),
                ),
              ),
            ),
          ],
        ),
      )
    ]));
  }

  Widget _buildARItem(ARItem item) {
    return GestureDetector(
      onTap: () {
        _onTapAR(item.type, item.link, item.name);
      },
      child: Row(
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColor.blue.withOpacity(0.5), width: 2.0)),
                  child: Center(
                    child: Image.asset(
                      item.icon!,
                      height: 32,
                      width: 32,
                    ),
                  ),
                ),
                Text(item.title),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

  Future<void> _onTapAR(ARType type, String? link, String name) async {
    switch (type) {
      case ARType.Wolf:
        cubit.downloadAndUnpack(link.toString(), name.toString());
        break;
      case ARType.Dragon:
        cubit.downloadAndUnpack(link.toString(), name.toString());
      case ARType.Shark:
        cubit.downloadAndUnpack(link.toString(), name.toString());
      default:
    }
  }
}
