import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/languages/localization_service.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/language/change_language_cubit.dart';
import 'package:ar_zoo_explorers/features/language/change_language_state.dart';
import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../app/theme/colors.dart';

@RoutePage()
class ChangLanguagePage extends StatefulWidget {
  const ChangLanguagePage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<ChangLanguageState, ChangLanguageCubit,
    ChangLanguagePage> {
  LocalizationService localizationService = LocalizationService();

  String? initialLanguageCode = Get.locale.toString();
  String? currentLanguageCode = Get.locale.toString();

  @override
  void initState() {
    super.initState();

    switch (Get.locale.toString()) {
      case "vi_VN":
        initialLanguageCode = currentLanguageCode = "vi";
        break;
      case "en_EN":
        initialLanguageCode = currentLanguageCode = "en";
        break;
      default:
        initialLanguageCode = currentLanguageCode = '';
        break;
    }
  }

  @override
  Widget buildByState(BuildContext context, ChangLanguageState state) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        leading: CustomBackButton(
          onPressed: () {
            LocalizationService.changeLocale(initialLanguageCode!);
            Navigator.pop(context);
            // Get.back();
          },
        ),
        title: Text(LanguageKeys.changeLanguage.tr),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                initialLanguageCode = currentLanguageCode;
                LocalizationService.changeLocale(initialLanguageCode!);
              });
              // Get.back();
              Navigator.pop(context);
            },
            child: Text(
              LanguageKeys.done.tr,
              style: const TextStyle(
                  color: AppColor.dartBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: ListView.separated(
          itemCount: localizationService.keys.entries.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          separatorBuilder: (BuildContext context, int index) {
            return const Padding(
              padding: EdgeInsets.only(left: 80),
              child: SizedBox(
                height: 1,
                child: Divider(
                  color: Color(0xFFC4C4C4),
                  thickness: 1.5,
                ),
              ),
            );
          },
          itemBuilder: (BuildContext context, int index) {
            String key = localizationService.keys.entries.elementAt(index).key;
            return _buildLanguageOption(key);
          },
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String key) {
    bool isCurrentLocale = Get.locale.toString() == key;
    final isSelectedLocale = isCurrentLocale;

    String flagPath;
    String languageCode;

    switch (key) {
      case "vi_VN":
        flagPath = AppImages.flagVN;
        languageCode = "vi";
        break;
      case "en_EN":
        flagPath = AppImages.flagUK;
        languageCode = "en";
        break;
      default:
        flagPath = '';
        languageCode = '';
        break;
    }

    return ListTile(
      onTap: () {
        setState(() {
          currentLanguageCode = languageCode;
          LocalizationService.changeLocale(currentLanguageCode!);
        });
      },
      leading: Image.asset(
        flagPath,
        width: 41,
        height: 27,
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isSelectedLocale
                    ? key.displayLanguageCountry
                    : key.displayLanguageCountry.tr,
                style: isSelectedLocale
                    ? const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFF006837))
                    : null,
              ),
              Text(
                key.tr,
                style: isSelectedLocale
                    ? const TextStyle(color: Color(0xFF006837))
                    : null,
              ),
            ],
          ),
          if (isSelectedLocale) const Spacer(),
          if (isCurrentLocale) SvgPicture.asset(AppIcons.icTick)
        ],
      ),
    );
  }
}
