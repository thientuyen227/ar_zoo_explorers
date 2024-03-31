import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ItemVocabulary extends StatefulWidget {
  const ItemVocabulary({super.key});

  @override
  State<ItemVocabulary> createState() => _ItemVocabularyState();
}

class _ItemVocabularyState extends State<ItemVocabulary> {
  var isComplete = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.pushNamed(Routes.vocabularydetail);
      },
      child: Container(
        padding: const EdgeInsets.only(top: 19, bottom: 9),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.vibrantYellow),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppColor.tinintIce,
        ),
        child: Center(
          child: Column(
            children: [
              SvgPicture.asset(AppImages.imgLionBaby),
              Text(
                LanguageKeys.animals.tr,
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
