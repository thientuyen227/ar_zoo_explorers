import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CongratulationWidget extends StatefulWidget {
  const CongratulationWidget({super.key});

  @override
  State<CongratulationWidget> createState() => _CongratulationWidgetState();
}

class _CongratulationWidgetState extends State<CongratulationWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 10)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          audioPlayer.play(UrlSource(
              "https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/effects%2Fsounds%2Fcongratulation.mp3?alt=media"));
          return Lottie.asset(AppLotties.congratulation,
              height: 400, width: 400);
        } else {
          return Container();
        }
      },
    );
  }
}
