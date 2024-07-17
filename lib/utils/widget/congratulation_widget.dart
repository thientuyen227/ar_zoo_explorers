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

  Future<void> stopAudio() async => await audioPlayer.dispose();
  @override
  Future<void> dispose() async {
    super.dispose();
    await stopAudio();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 10)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          audioPlayer.play(AssetSource(AppSound.audioCorrect));
          return Lottie.asset(AppLotties.congratulation,
              height: 400, width: 400);
        } else {
          return Container();
        }
      },
    );
  }
}
