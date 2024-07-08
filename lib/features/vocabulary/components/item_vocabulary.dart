import 'package:ar_zoo_explorers/app/config/app_router.gr.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/scoreboard_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/vocabulary_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/learning_category_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/scoreboard_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';
import 'package:ar_zoo_explorers/features/vocabulary/presentation/vocabulary_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ItemVocabulary extends StatefulWidget {
  final LearningCategoryEntity learningCategoryEntity;
  final VocabularyState state;
  const ItemVocabulary(
      {super.key, required this.learningCategoryEntity, required this.state});

  @override
  State<ItemVocabulary> createState() => _ItemVocabularyState();
}

class _ItemVocabularyState extends State<ItemVocabulary> {
  AuthController authController = AuthController.findOrInitialize;
  final scoreboardController = ScoreboardController.findOrInitialize;
  final vocabularyController = VocabularyController.findOrInitialize;
  var isComplete = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<VocabularyEntity>? vocabularyEntities =
        await vocabularyController.getAllVocabularys(context);
    List<ScoreboardEntity>? scoreboards =
        await scoreboardController.getAllScoreboardByUser(
            context,
            authController.currentUser.value.id,
            widget.learningCategoryEntity.id);
    scoreboards = scoreboards!
        .where(
            (element) => element.isAudio == true && element.isQuestion == true)
        .toList();
    if (vocabularyEntities!.length == scoreboards.length) {
      setState(() {
        isComplete = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(
            VocabularyDetailRoute(category: widget.learningCategoryEntity));
      },
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 9),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.vibrantYellow),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppColor.tinintIce,
        ),
        child: Center(
          child: Column(
            children: [
              Lottie.asset(widget.learningCategoryEntity.imagePath,
                  height: widget.state.height * 0.118,
                  width: widget.state.width * 0.2),
              Text(
                widget.learningCategoryEntity.nameLocalize,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const Text("1000pts"),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color:
                      !isComplete ? AppColor.vibrantYellow : AppColor.completed,
                ),
                child: !isComplete
                    ? Text(
                        LanguageKeys.in_process.tr,
                        style: const TextStyle(
                            color: AppColor.brown, fontSize: 12),
                      )
                    : Text(LanguageKeys.completed.tr,
                        style: const TextStyle(
                            color: AppColor.white, fontSize: 12)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
