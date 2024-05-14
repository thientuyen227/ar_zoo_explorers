import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/core/data/controller/vocabulary_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    vocabularyController.getAllVocabularys();
    currentIndex = vocabularyController.listVocabulary.value
        .indexWhere((element) => element.id == widget.vocabularyEntity.id);
  }

  void goToVocabulary(bool isNext) {
    setState(() {
      if (isNext) {
        if (currentIndex <
            vocabularyController.listVocabulary.value.length - 1) {
          currentIndex++;
        }
      } else {
        if (currentIndex > 0) {
          currentIndex--;
        }
      }
    });
  }

  VocabularyEntity getCurrentVocabulary() {
    return vocabularyController.listVocabulary.value[currentIndex];
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
                color: currentIndex ==
                        vocabularyController.listVocabulary.value.length - 1
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LanguageKeys.description.tr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  getCurrentVocabulary().meaningLocalize,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LanguageKeys.location.tr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  getCurrentVocabulary().exampleLocalize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget renderTitleAndSpell() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Easy",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
              child: ImageSvgUrlCustom(
                  imagePath: getCurrentVocabulary().thumbnail)),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  // _showDialogAndBottomSheet(context);
                },
                child: Image.asset(
                  AppIcons.icSnail,
                  height: 32,
                  width: 32,
                ),
              ),
              Text(
                getCurrentVocabulary().wordLocalize,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SvgPicture.asset(AppIcons.icSound),
            ],
          ),
          languageCode != 'vi'
              ? Center(
                  child: Text(
                    getCurrentVocabulary().phoneticTranscription ?? "",
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
      children: <Widget>[
        Positioned(
            top: 100,
            left: 16,
            right: 16,
            child: SizedBox(
              height: 700,
              child: Stack(
                children: [
                  Positioned(
                      right: 41,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(AppIcons.icCloseBtn))),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 55.0, right: 41, left: 41),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: 293,
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
                  onPressed: () {
                    context.router.pushNamed(Routes.puzzle);
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
}
