import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ModelDetailLoading extends StatefulWidget {
  final ValueNotifier<bool> isClosedLoading;
  const ModelDetailLoading({super.key, required this.isClosedLoading});
  @override
  _ModelDetailLoadingState createState() => _ModelDetailLoadingState();
}

class _ModelDetailLoadingState extends State<ModelDetailLoading> {
  double width = 0;
  double height = 0;

  String assetSound = AppSound.mindset;

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {},
        child: Stack(children: [
          bgLayout(),
          bgLotties(),
          Positioned(
              bottom: height * 0.15, right: width * 0.05, child: logoLotties())
        ]));
  }

  Widget bgLayout() {
    return SizedBox(
      width: width,
      height: height,
      child: Image.asset(AppImages.imgBGStarrySky, fit: BoxFit.cover),
      // decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //         colors: [Colors.blue.shade100, Colors.blue.shade900],
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter)),
    );
  }

  Widget bgLotties() {
    return Center(
      child: SizedBox(
          width: width * 0.9,
          height: width * 0.9,
          child: Lottie.asset(AppLotties.earthSwing, fit: BoxFit.cover)),
    );
  }

  Widget logoLotties() {
    return Center(
        child: SizedBox(
            width: width * 0.35,
            height: width * 0.35,
            child: Lottie.asset(AppLotties.scientistPanda, fit: BoxFit.cover)));
  }

  Future<void> _setDimension() async {
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;

    setState(() {
      width = mediaSize.width;
      height = mediaSize.height;
    });
  }

  void _checkClosedValue() {
    if (!widget.isClosedLoading.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    }
  }

  Future<void> stopAudio() async => await audioPlayer.dispose();

  @override
  void dispose() {
    stopAudio();
    super.dispose();
    widget.isClosedLoading.removeListener(_checkClosedValue);
    print("[Stop loading ...]");
  }

  @override
  void initState() {
    super.initState();

    _setDimension();
    audioPlayer.setVolume(0.9);
    audioPlayer.play(AssetSource(assetSound));
    Future.delayed(const Duration(seconds: 2), () {
      if (!widget.isClosedLoading.value) {
        _checkClosedValue();
      }
    });
  }
}
