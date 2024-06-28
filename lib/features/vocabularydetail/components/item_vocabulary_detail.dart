import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/core/data/controller/vocabulary_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';
import 'package:ar_zoo_explorers/features/vocabularydetail/components/dialog_animal.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ItemVocabularyDetail extends StatefulWidget {
  final VocabularyEntity vocabularyEntity;
  const ItemVocabularyDetail({super.key, required this.vocabularyEntity});

  @override
  State<ItemVocabularyDetail> createState() => _ItemVocabularyDetailState();
}

class _ItemVocabularyDetailState extends State<ItemVocabularyDetail> {
  var isComplete = false;
  final languageCode = Get.locale?.languageCode;
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 9, bottom: 9),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.vibrantYellow),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: AppColor.tinintIce,
      ),
      child: Center(
        child: Column(
          children: [
            ImageSvgUrlCustom(
              imagePath: widget.vocabularyEntity.thumbnail,
              height: 100,
              width: 100,
            ),
            languageCode != 'vi'
                ? Text(widget.vocabularyEntity.phoneticTranscription ?? "")
                : Container(
                    height: 0,
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 8.0, left: 8),
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
                      _showDialogAndBottomSheet(
                          context, widget.vocabularyEntity);
                    },
                    icon: Image.asset(
                      AppIcons.icSnail,
                      height: 41,
                      width: 41,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      audioPlayer.play(
                          UrlSource(widget.vocabularyEntity.audiosLocalize));
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
      ),
    );
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
