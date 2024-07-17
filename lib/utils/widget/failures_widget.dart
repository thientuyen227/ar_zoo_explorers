import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class FailuresWidget extends StatefulWidget {
  const FailuresWidget({super.key});

  @override
  State<FailuresWidget> createState() => _FailuresWidgetState();
}

class _FailuresWidgetState extends State<FailuresWidget> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
  }

  Future<void> stopAudio() async => await audioPlayer.dispose();

  @override
  void dispose() {
    stopAudio();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(microseconds: 1)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          audioPlayer.play(AssetSource(AppSound.audioFailed));
          return Container();
        } else {
          return Container();
        }
      },
    );
  }
}
