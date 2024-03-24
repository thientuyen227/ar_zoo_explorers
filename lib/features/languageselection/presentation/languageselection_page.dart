import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../app/config/routes.dart';
import '../../../app/languages/localization_service.dart';
import '../../../app/theme/icons.dart';
import '../../../base/base_state.dart';
import 'languageselection_cubit.dart';
import 'languageselection_state.dart';

@RoutePage()
class LanguageSelectionPage extends StatefulWidget {
  const LanguageSelectionPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<LanguageSelectionState, LanguageSelectionCubit,
    LanguageSelectionPage> {
  Locale _selectedLocale = LocalizationService.locale;

  @override
  Widget buildByState(BuildContext context, LanguageSelectionState state) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          padding: const EdgeInsets.only(left: 35, right: 35, bottom: 50),
          child: Column(children: [
            const SizedBox(height: 12),
            appLogo(),
            bodyHeader(),
            const SizedBox(height: 12),
            languageSelection(),
            SizedBox(height: cubit.HEIGHT * 0.25),
            startButton(
              context,
            )
          ])),
    ));
  }

  Widget appLogo() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(height: 48),
      Transform.scale(
        scale: 2,
        child: Image.asset(
          AppImages.imgAppLogo,
          height: cubit.HEIGHT * 0.25,
          width: cubit.WIDTH,
        ),
      ),
      const SizedBox(height: 10),
    ]);
  }

  Widget bodyHeader() {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(width: MediaQuery.of(context).size.width),
        primaryGradientText("Select Language!", 32.0),
        const SizedBox(height: 36),
      ],
    );
  }

  Widget primaryGradientText(String content, double size,
      {Color color = Colors.white}) {
    return ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            colors: [Colors.blue.shade800, Colors.orange.shade500],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(bounds);
        },
        child: Text(content,
            softWrap: true,
            style: TextStyle(
                fontSize: size, fontWeight: FontWeight.bold, color: color)));
  }

  Widget languageSelection() {
    return SizedBox(
      height: 45,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _selectedLocale.languageCode == 'en'
                  ? AppImages.flagUK
                  : AppImages.flagVN,
              width: 41,
              height: 27,
            ),
            const SizedBox(width: 5),
            Text(_selectedLocale.countryCode.toString(),
                style: const TextStyle(fontSize: 18)),
            IconButton(
              onPressed: () {
                _showDropdownBottomSheet(context);
              },
              icon: const RotatedBox(
                quarterTurns: 45,
                child: Icon(Icons.chevron_right_rounded),
              ),
              iconSize: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget startButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          context.router.pop();
          context.router.pushNamed(Routes.login);
        },
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(Size(cubit.WIDTH * 0.6, 50)),
            backgroundColor: MaterialStateProperty.all(Colors.blue[600]),
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)))),
        child: const Text("Go To Login",
            style: TextStyle(fontSize: 20, color: Colors.white)));
  }

  void _showDropdownBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      barrierColor: Colors.transparent,
      backgroundColor: const Color(0xFFF2F2F2),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      LanguageKeys.chooseLanguage.tr,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 0,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.zero,
                      splashRadius: 10,
                      constraints: const BoxConstraints(),
                      icon: SvgPicture.asset(
                        AppIcons.icClose,
                        width: 28,
                        height: 28,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 23),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  children: _buildDropdownMenuItems(context),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildDropdownMenuItems(BuildContext context) {
    return LocalizationService.langs.entries.mapIndexed((idx, e) {
      final iconPath = e.key == 'en' ? AppImages.flagUK : AppImages.flagVN;
      final isSelectedLocale = _selectedLocale.languageCode == e.key;
      return Column(
        children: [
          ListTile(
            leading: Image.asset(
              iconPath,
              width: 41,
              height: 27,
            ),
            title: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isSelectedLocale
                          ? Locale(e.key).displayLanguageCountry
                          : Locale(e.key).displayLanguageCountry,
                      style: isSelectedLocale
                          ? const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5F8D4D))
                          : null,
                    ),
                    Text(
                      e.value.toString(),
                      style: isSelectedLocale
                          ? const TextStyle(color: Color(0xFF5F8D4E))
                          : null,
                    ),
                  ],
                ),
                if (isSelectedLocale) const Spacer(),
                if (isSelectedLocale) SvgPicture.asset(AppIcons.icTick),
              ],
            ),
            onTap: () {
              LocalizationService.changeLocale(e.key);
              setState(() =>
                  _selectedLocale = LocalizationService.locales.firstWhere(
                    (element) => element.languageCode == e.key,
                  ));
              Navigator.pop(context);
            },
          ),
          if (idx < LocalizationService.langs.length - 1) ...{
            const Padding(
              padding: EdgeInsets.only(left: 80),
              child: Divider(
                color: Color(0xFFC4C4C4),
                height: 1,
              ),
            )
          }
        ],
      );
    }).toList();
  }

  void setDimension() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        cubit.WIDTH = MediaQuery.of(context).size.width;
        cubit.HEIGHT = MediaQuery.of(context).size.height;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setDimension();
  }
}
