import 'package:ar_zoo_explorers/features/learning/presentation/learning_cubit.dart';
import 'package:ar_zoo_explorers/features/learning/presentation/learning_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../app/theme/icons.dart';
import '../../../base/base_state.dart';
import '../../../utils/widget/button_widget.dart';

@RoutePage()
class LearningPage extends StatefulWidget {
  const LearningPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<LearningState, LearningCubit, LearningPage> {
  @override
  Widget buildByState(BuildContext context, LearningState state) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          centerTitle: true,
          title: const Text("Learning Home",
              style: TextStyle(fontSize: 20, color: Colors.white)),
          backgroundColor: Colors.blue[600],
          elevation: 0,
          leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [backButton()]),
          actions: const []),
    );
  }

  Widget backButton() {
    return AppIconButton(
      onPressed: () => context.router.pop(),
      icon: Container(
          margin: const EdgeInsets.only(left: 0),
          child: Transform.scale(
              scale: 1.15,
              child:
                  Image.asset(AppIcons.icBack_x64_png, height: 24, width: 24))),
    );
  }
}
