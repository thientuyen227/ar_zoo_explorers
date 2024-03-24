import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
  final Locale _selectedLocale = LocalizationService.locale;

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
                // _showDropdownBottomSheet(context);
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
