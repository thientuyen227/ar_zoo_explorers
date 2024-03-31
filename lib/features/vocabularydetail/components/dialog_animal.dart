import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DialogAnimal extends StatefulWidget {
  const DialogAnimal({super.key});

  @override
  State<DialogAnimal> createState() => _DialogAnimalState();
}

class _DialogAnimalState extends State<DialogAnimal> {
  Widget buttonPreviousAndNext() {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColor.vibrantYellow,
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
                const Text(
                  "Previous",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
              color: AppColor.vibrantYellow,
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  "Next",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
      ],
    );
  }

  Widget renderContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "A very large animal with short legs and thick, dark grey skin that lives near water in Africa",
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Location:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "Hippopotamus  are found in the rivers.",
              ),
            ],
          ),
        ),
        buttonPreviousAndNext(),
      ],
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
            child: SvgPicture.asset(AppImages.imgLionBaby),
          ),
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
              const Text(
                "Lion",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              SvgPicture.asset(AppIcons.icSound),
            ],
          ),
          const Center(
            child: Text(
              "/ˈlaɪən/",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          renderContent(),
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
              height: 500,
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
                        height: 450,
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
