import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/core/data/controller/animal_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/scoreboard_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/vocabulary_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/scoreboard_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';
import 'package:ar_zoo_explorers/features/vocabularydetail/components/dialog_animal.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ItemVocabularyDetail extends StatefulWidget {
  final VocabularyEntity vocabularyEntity;
  const ItemVocabularyDetail({super.key, required this.vocabularyEntity});

  @override
  State<ItemVocabularyDetail> createState() => _ItemVocabularyDetailState();
}

class _ItemVocabularyDetailState extends State<ItemVocabularyDetail> {
  bool isCompleted = false;
  final languageCode = Get.locale?.languageCode;
  AudioPlayer audioPlayer = AudioPlayer();
  final scoreboardController = ScoreboardController.findOrInitialize;
  final animalController = AnimalController.findOrInitialize;
  final AuthController authController = AuthController.findOrInitialize;
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
    fetchComplete();
  }

  Future<void> fetchComplete() async {
    var scoreboard = await scoreboardController.getScoreboardByUser(context,
        authController.currentUser.value.id, widget.vocabularyEntity.id);
    if (scoreboard != null &&
        scoreboard.isAudio == true &&
        scoreboard.isQuestion == true) {
      setState(() {
        isCompleted = true;
      });
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showDialogAndBottomSheet(context, widget.vocabularyEntity);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 9, bottom: 9),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.vibrantYellow),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppColor.tinintIce,
        ),
        child: Center(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 2,
                child: isCompleted
                    ? const ImageSvgUrlCustom(
                        imagePath: AppIcons.icTick,
                        height: 24,
                        width: 24,
                      )
                    : Container(),
              ),
              Column(
                children: [
                  ImageSvgUrlCustom(
                    imagePath: widget.vocabularyEntity.thumbnail,
                    height: 110,
                    width: 100,
                  ),
                  languageCode != 'vi'
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                              widget.vocabularyEntity.phoneticTranscription ??
                                  ""),
                        )
                      : Container(
                          height: 0,
                        ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, right: 8.0, left: 8),
                    child: Text(
                      widget.vocabularyEntity.wordLocalize,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (widget.vocabularyEntity.modelId != null) {
                              navigatorToModel(
                                  widget.vocabularyEntity.modelId!);
                            } else {
                              Fluttertoast.showToast(
                                  msg: LanguageKeys.msg_model3D.tr);
                            }
                          },
                          icon: Image.asset(
                            AppIcons.icSnail,
                            height: 41,
                            width: 41,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () async {
                            audioPlayer.play(UrlSource(
                                widget.vocabularyEntity.audiosLocalize));
                            scoreboardEntity = scoreboardEntity.copyWith(
                                userId: authController.currentUser.value.id,
                                learningId: widget.vocabularyEntity.categoryId,
                                isAudio: true,
                                vocabularyId: widget.vocabularyEntity.id);
                            var scoreboardUserEntity =
                                await scoreboardController
                                    .createOrGetScoreboardByUserByUser(
                                        context, scoreboardEntity);
                            await scoreboardController.updateScoreboardByUser(
                                context, scoreboardUserEntity!);
                            setState(() {
                              fetchComplete();
                            });
                          },
                          icon: SvgPicture.asset(
                            AppIcons.icSound,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> navigatorToModel(String modelId) async {
    await animalController.updateCurrentAnimal(context, modelId);
    context.router.pushNamed(Routes.modeldetail);
  }
}

void _showDialogAndBottomSheet(
    BuildContext context, VocabularyEntity vocabularyEntities) {
  final vocabularyController = VocabularyController.findOrInitialize;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      vocabularyController.getVocabulary(context, vocabularyEntities.id);
      return DialogAnimal(vocabularyEntity: vocabularyEntities);
    },
  );
}
