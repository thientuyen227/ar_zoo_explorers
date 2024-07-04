import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChatAILoading extends StatefulWidget {
  final ValueNotifier<bool> isClosedLoading;
  const ChatAILoading({super.key, required this.isClosedLoading});
  @override
  _ChatAILoadingState createState() => _ChatAILoadingState();
}

class _ChatAILoadingState extends State<ChatAILoading> {
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
          Positioned(bottom: 0, left: 0, right: 0, child: bgLotties()),
        ]));
  }

  Widget bgLayout() {
    return Container(
      width: width,
      height: height,
      color: Colors.blue.shade300,
    );
  }

  Widget bgLotties() {
    return Center(
      child: SizedBox(
          width: width,
          height: width,
          child: Lottie.asset(AppLotties.arBaby, fit: BoxFit.cover)),
    );
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
      if (widget.isClosedLoading.value) {
        _checkClosedValue();
      }
    });
  }
}
