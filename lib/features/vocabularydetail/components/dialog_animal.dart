import 'package:ar_zoo_explorers/app/config/app_router.gr.dart';
import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/core/data/controller/animal_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/question_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/scoreboard_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/vocabulary_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/scoreboard_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';
import 'package:ar_zoo_explorers/features/vocabulary/presentation/vocabulary_cubit.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DialogAnimal extends StatefulWidget {
  final VocabularyEntity vocabularyEntity;
  const DialogAnimal({super.key, required this.vocabularyEntity});

  @override
  State<DialogAnimal> createState() => _DialogAnimalState();
}

class _DialogAnimalState extends State<DialogAnimal> {
  final languageCode = Get.locale?.languageCode;
  final vocabularyController = VocabularyController.findOrInitialize;
  final scoreboardController = ScoreboardController.findOrInitialize;
  final animalController = AnimalController.findOrInitialize;
  final questionController = QuestionController.findOrInitialize;
  AuthController authController = AuthController.findOrInitialize;
  late int currentIndex;
  VocabularyCubit cubit = VocabularyCubit();
  AudioPlayer audioPlayer = AudioPlayer();
  List<VocabularyEntity>? vocabularyEntities;
  VocabularyEntity? vocabularyEntity;
  double? height;
  double? width;
  ScoreboardEntity scoreboardEntity = ScoreboardEntity(
    id: '',
    userId: '',
    learningId: '',
    vocabularyId: '',
    isAudio: false,
    isQuestion: false,
  );

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;
    height = mediaSize.height;
    width = mediaSize.width;
    vocabularyEntities = vocabularyController.listVocabulary.value
        .where((element) =>
            element.categoryId == widget.vocabularyEntity.categoryId)
        .toList();
    currentIndex = vocabularyEntities!
        .indexWhere((element) => element.id == widget.vocabularyEntity.id);
    vocabularyEntity = vocabularyEntities![currentIndex];
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void fetchData() {}

  void goToVocabulary(bool isNext) {
    setState(() {
      if (isNext) {
        if (currentIndex < vocabularyEntities!.length - 1) {
          currentIndex++;
          vocabularyEntity = vocabularyEntities?[currentIndex];
        }
      } else {
        if (currentIndex > 0) {
          currentIndex--;
          vocabularyEntity = vocabularyEntities?[currentIndex];
        }
      }
    });
  }

  Widget buttonPreviousAndNext() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            goToVocabulary(false);
          },
          child: Container(
            decoration: BoxDecoration(
                color: currentIndex != 0
                    ? AppColor.vibrantYellow
                    : AppColor.lightGrey,
                border: Border.all(),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  Image.asset(
                    AppIcons.icBack_x64_png,
                    height: 20,
                    width: 20,
                    color: AppColor.black,
                  ),
                  Text(
                    LanguageKeys.previous.tr,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            goToVocabulary(true);
          },
          child: Container(
            decoration: BoxDecoration(
                color: currentIndex == vocabularyEntities!.length - 1
                    ? AppColor.lightGrey
                    : AppColor.vibrantYellow,
                border: Border.all(),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    LanguageKeys.next.tr,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  SvgPicture.asset(
                    AppIcons.icVector,
                    height: 15,
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget renderContent() {
    return SizedBox(
      height: height! * 0.34,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        LanguageKeys.meaning.tr,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            AppIcons.icSound,
                            height: 30,
                            width: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    vocabularyEntity!.meaningLocalize,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        LanguageKeys.example.tr,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            AppIcons.icSound,
                            height: 30,
                            width: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    vocabularyEntity!.exampleLocalize,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderTitleAndSpell() {
    return Padding(
      padding: const EdgeInsets.all(11.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: ImageSvgUrlCustom(
            imagePath: vocabularyEntity!.thumbnail,
            height: height! * 0.16,
            width: width! * 0.4,
          )),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      if (vocabularyEntity!.modelId != null) {
                        navigatorToModel(vocabularyEntity!.modelId ?? "");
                      } else {
                        Fluttertoast.showToast(
                            msg: LanguageKeys.msg_model3D.tr);
                      }
                    },
                    icon: Image.asset(
                      AppIcons.icSnail,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  SizedBox(
                    width: 130,
                    child: Center(
                      child: Text(
                        vocabularyEntity!.wordLocalize,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      audioPlayer
                          .play(UrlSource(vocabularyEntity!.audiosLocalize));
                      scoreboardEntity = scoreboardEntity.copyWith(
                          userId: authController.currentUser.value.id,
                          learningId: vocabularyEntity!.categoryId,
                          isAudio: true,
                          vocabularyId: vocabularyEntity!.id);
                      var scoreboardUserEntity = await scoreboardController
                          .createOrGetScoreboardByUserByUser(
                              context, scoreboardEntity);
                      await scoreboardController.updateScoreboardByUser(
                          context, scoreboardUserEntity!);
                    },
                    icon: SvgPicture.asset(
                      AppIcons.icSound,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
          languageCode != 'vi'
              ? Center(
                  child: Text(
                    vocabularyEntity!.phoneticTranscription ?? "",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )
              : Container(),
          renderContent(),
          const Spacer(),
          buttonPreviousAndNext(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            bottom: height! * 0.1,
            right: width! * 0.029,
            left: width! * 0.029,
            top: height! * 0.06,
            child: Container(
              height: height! * 0.9,
              padding: const EdgeInsets.all(8),
              color: Colors.transparent,
              child: Column(
                children: [
                  SizedBox(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: SvgPicture.asset(AppIcons.icCloseBtn)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 41, left: 41),
                    child: Container(
                        height: height! * 0.66,
                        width: width! * 0.8,
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                width: 5, color: AppColor.vibrantYellow)),
                        child: renderTitleAndSpell()),
                  ),
                ],
              ),
            )),
        // Bottom sheet
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 75,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 18),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF49B0AB)),
                  onPressed: () async {
                    vocabularyController.currentVocabulary(vocabularyEntity);
                    var questionEntities =
                        await questionController.getAllQuestions(context);
                    questionEntities!
                        .firstWhere(
                          (element) =>
                              element.vocabularyId == vocabularyEntity!.id,
                          orElse: () => throw Fluttertoast.showToast(
                              msg: LanguageKeys.msg_question.tr),
                        )
                        .id;
                    context.router.push(
                        PuzzleWordRoute(vocabularyId: vocabularyEntity!.id));
                  },
                  child: Text(
                    LanguageKeys.take_the_quiz.tr,
                    style: const TextStyle(color: AppColor.white, fontSize: 18),
                  )),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> navigatorToModel(String modelId) async {
    await animalController.updateCurrentAnimal(context, modelId);
    context.router.pushNamed(Routes.modeldetail);
  }
}
