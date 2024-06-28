import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/core/data/api/api_service.dart';
import 'package:ar_zoo_explorers/domain/entities/chatbox_entity.dart';
import 'package:ar_zoo_explorers/features/learning/presentation/learning_cubit.dart';
import 'package:ar_zoo_explorers/features/learning/presentation/learning_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
  ApiService apiService = ApiService();
  TextEditingController textTest = TextEditingController();
  ChatBoxEntity? chatBoxEntity;

  @override
  Widget buildByState(BuildContext context, LearningState state) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(LanguageKeys.learning_home.tr.toUpperCase(),
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.blue[600],
          elevation: 0,
          leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [backButton()]),
          actions: const []),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _renderPoints(),
              const SizedBox(
                height: 24,
              ),
              _renderTitleAndIcon(
                  title: LanguageKeys.phonics.tr,
                  router: Routes.phonics,
                  lotties: AppLotties.animationanimal),
              _renderTitleAndIcon(
                  title: LanguageKeys.vocabulary,
                  router: Routes.vocabulary,
                  lotties: AppLotties.vocabulary),
              _renderTitleAndIcon(
                  title: LanguageKeys.puzzle,
                  router: Routes.puzzleword,
                  lotties: AppLotties.puzzle),
              _renderTitleAndIcon(
                  title: LanguageKeys.puzzle,
                  router: Routes.writechars,
                  lotties: AppLotties.puzzle),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderTitleAndIcon(
      {required String title,
      required String router,
      required String lotties}) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        GestureDetector(
          onTap: () {
            context.router.pushNamed(router);
          },
          child: Container(
            height: 96,
            decoration: BoxDecoration(
                color: AppColor.tinintIce,
                border: Border.all(),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                      child: Lottie.asset(
                    lotties,
                  )),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    title.tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget backButton() {
    return AppIconButton(
      onPressed: () => context.router.maybePop(),
      icon: Container(
          margin: const EdgeInsets.only(left: 0),
          child: Transform.scale(
              scale: 1.15,
              child:
                  Image.asset(AppIcons.icBack_x64_png, height: 24, width: 24))),
    );
  }

  Widget _renderPoints() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: AppColor.vibrantYellow,
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LanguageKeys.your_points.tr,
              style: const TextStyle(
                  fontSize: 16,
                  color: AppColor.black,
                  fontWeight: FontWeight.w500),
            ),
            Container(
              height: 30,
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: AppColor.lightBlue,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text(
                    "1000 pts",
                    style: TextStyle(color: AppColor.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
