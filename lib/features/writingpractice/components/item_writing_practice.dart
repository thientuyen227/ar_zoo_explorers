import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/core/data/controller/chars_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/chars_entity.dart';
import 'package:ar_zoo_explorers/features/writingpractice/presentation/writing_practice_state.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemWritingPractice extends StatefulWidget {
  const ItemWritingPractice(
      {super.key, required this.charsEntity, required this.state});
  final CharsEntity charsEntity;
  final WritingPracticeState state;

  @override
  State<ItemWritingPractice> createState() => _ItemWritingPracticeState();
}

class _ItemWritingPracticeState extends State<ItemWritingPractice> {
  final languageCode = Get.locale?.languageCode;
  CharsController charsController = CharsController.findOrInitialize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        charsController.currentChars(widget.charsEntity);
        context.router.pushNamed(Routes.writingpracticedetail);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 5, color: AppColor.lightBlue)),
        child: ImageSvgUrlCustom(
          imagePath: widget.charsEntity.imagePaths[languageCode]!,
          height: widget.state.width * 0.3,
          width: widget.state.height * 0.4,
        ),
      ),
    );
  }
}
