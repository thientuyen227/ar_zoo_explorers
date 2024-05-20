import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';
import 'package:ar_zoo_explorers/features/vocabularydetail/components/dialog_animal.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 19, bottom: 9),
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
              height: 70,
              width: 70,
              size: 70,
            ),
            languageCode != 'vi'
                ? Text(widget.vocabularyEntity.phoneticTranscription ?? "")
                : Container(
                    height: 0,
                  ),
            Text(
              widget.vocabularyEntity.wordLocalize,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18, left: 18),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _showDialogAndBottomSheet(
                          context, widget.vocabularyEntity);
                    },
                    child: Image.asset(
                      AppIcons.icSnail,
                      height: 32,
                      width: 32,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(AppIcons.icSound)
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
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DialogAnimal(vocabularyEntity: vocabularyEntities);
    },
  );
}
