import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/features/vocabularydetail/components/dialog_animal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemVocabularyDetail extends StatefulWidget {
  const ItemVocabularyDetail({super.key});

  @override
  State<ItemVocabularyDetail> createState() => _ItemVocabularyDetailState();
}

class _ItemVocabularyDetailState extends State<ItemVocabularyDetail> {
  var isComplete = false;

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
            SvgPicture.asset(AppImages.imgLionBaby),
            const Text("/ˈlaɪən/"),
            const Text(
              "Lion",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                      _showDialogAndBottomSheet(context);
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

void _showDialogAndBottomSheet(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const DialogAnimal();
    },
  );
}
