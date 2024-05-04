import 'dart:async';

import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/story/component/volume_slider.dart';
import 'package:ar_zoo_explorers/features/storyplayer/presentation/storyplayer_cubit.dart';
import 'package:ar_zoo_explorers/features/storyplayer/presentation/storyplayer_state.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class StoryPlayerPage extends StatefulWidget {
  const StoryPlayerPage({super.key});

  @override
  State createState() => _State();
}

class _State
    extends BaseState<StoryPlayerState, StoryPlayerCubit, StoryPlayerPage> {
  AudioPlayer audioPlayer = AudioPlayer();

  Timer timer = Timer(Duration.zero, () {});

  @override
  Widget buildByState(BuildContext context, StoryPlayerState state) {
    return PopScope(
        canPop: false, //When false, blocks the current route from being popped.
        onPopInvoked: (didPop) {
          Navigator.of(context).pop();
        },
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
                centerTitle: true,
                title: Text(cubit.name,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [backButton()]),
                actions: const []),
            body: Stack(children: [
              ClipRect(
                  child: Image.network(cubit.avatar,
                      width: cubit.WIDTH,
                      height: cubit.HEIGHT,
                      fit: BoxFit.cover)),
              backgroundPage(context)
            ])));
  }

  Widget backButton() {
    return AppIconButton(
      onPressed: () => context.router.pop(),
      icon: Container(
          margin: const EdgeInsets.only(left: 0),
          child: Transform.scale(
              scale: 1.15,
              child:
                  Image.asset(AppIcons.icBack_x64_png, height: 24, width: 24))),
    );
  }

  Widget backgroundPage(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
          constraints: BoxConstraints(minHeight: cubit.HEIGHT),
          width: cubit.WIDTH,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.blue.shade700.withOpacity(0.4),
            Colors.blue.shade300.withOpacity(0.4)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: whiteLayoutPage()),
    ]));
  }

  Widget whiteLayoutPage() {
    return Container(
      constraints: BoxConstraints(maxHeight: cubit.HEIGHT * 0.85),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.6),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3))
          ]),
      margin: EdgeInsets.only(
          top: cubit.HEIGHT * 0.12, left: 20, right: 20, bottom: 25),
      // padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          imgStory(),
          const SizedBox(height: 10),
          txtStoryName(),
          contentStory(),
          const Spacer(),
          progressBar(),
          audioSection(),
          const SizedBox(height: 5),
          // Text('Audio State: ${cubit.audioState}'),
        ],
      ),
    );
  }

  Widget imgStory() {
    return SizedBox(
        width: cubit.HEIGHT * 0.15,
        height: cubit.HEIGHT * 0.15,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(cubit.avatar, fit: BoxFit.cover)));
  }

  Widget txtStoryName() {
    return Container(
        width: cubit.WIDTH,
        height: cubit.HEIGHT * 0.07,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Text(cubit.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
  }

  Widget contentStory() {
    List<String> txtLines = cubit.content.split('\n');
    List<Widget> lines = [const SizedBox(height: 15)];
    String space = " " * 3;
    for (int i = 0; i < txtLines.length; i++) {
      lines.add(Text('$space${txtLines[i]}',
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr));
    }
    lines.add(const SizedBox(height: 15));
    return Container(
        width: cubit.WIDTH,
        height: cubit.HEIGHT * 0.4,
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: lines),
        ));
  }

  Widget progressBar() {
    return SizedBox(
        width: cubit.WIDTH * 0.9,
        height: cubit.HEIGHT * 0.05,
        // decoration: BoxDecoration(border: Border.all()),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              width: cubit.WIDTH * 0.13,
              alignment: Alignment.center,
              // decoration: BoxDecoration(border: Border.all()),
              child: Text(
                  '${cubit.position.inMinutes} : ${cubit.position.inSeconds.remainder(60)}',
                  style: const TextStyle(fontSize: 14))),
          progressSlider(),
          Container(
              width: cubit.WIDTH * 0.13,
              alignment: Alignment.center,
              // decoration: BoxDecoration(border: Border.all()),
              child: Text(
                  '${cubit.duration.inMinutes} : ${cubit.duration.inSeconds.remainder(60)}',
                  style: const TextStyle(fontSize: 14))),
        ]));
  }

  Widget progressSlider() {
    return Expanded(
        child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 8.0,
              thumbColor: Colors.blue.shade700,
              overlayColor: Colors.blue.withOpacity(0.3),
              activeTrackColor: Colors.blue,
              inactiveTrackColor: Colors.grey,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
              tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 16),
              trackShape: const RoundedRectSliderTrackShape(),
            ),
            child: Slider(
              value: cubit.position.inSeconds.toDouble(),
              min: 0.0,
              max: cubit.duration.inSeconds.toDouble(),
              onChanged: (double value) {
                setState(() {
                  seekToSecond(value.toInt());
                  // value = value;
                });
              },
            )));
  }

  Widget audioSection() {
    return SizedBox(
      width: cubit.WIDTH,
      height: cubit.HEIGHT * 0.08,
      // decoration: BoxDecoration(border: Border.all()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnVolume(),
          btnRewind15s(),
          playButtonState(),
          btnFastForward15s(),
          btnLoop(),
        ],
      ),
    );
  }

  Widget playButtonState() {
    return Center(
        child:
            cubit.audioState == PlayerState.playing ? btnPause() : btnPlay());
  }

  Widget btnPlay() {
    return IconButton(
        icon: SizedBox(
            height: 45,
            width: 45,
            child: ColorFiltered(
                colorFilter:
                    const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                child: Image.asset(AppIcons.icPlay64, fit: BoxFit.cover))),
        onPressed: () async {
          await audioPlayer.play(UrlSource(cubit.audioUrl),
              position: cubit.position);
        });
  }

  Widget btnPause() {
    return IconButton(
        icon: SizedBox(
            height: 45,
            width: 45,
            child: ColorFiltered(
                colorFilter:
                    const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                child: Image.asset(AppIcons.icPause64, fit: BoxFit.cover))),
        onPressed: () async {
          await audioPlayer.pause();
        });
  }

  Widget btnLoop() {
    return IconButton(
      icon: SizedBox(
          height: 30,
          width: 30,
          child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  cubit.isLoop ? Colors.blue : Colors.grey, BlendMode.srcIn),
              child: Image.asset(AppIcons.icRefresh64, fit: BoxFit.cover))),
      onPressed: () async {
        setState(() {
          cubit.isLoop = !cubit.isLoop;
        });
      },
    );
  }

  Widget btnRewind15s() {
    return IconButton(
      icon: Container(
          alignment: Alignment.center,
          width: 40,
          height: 40,
          child: Stack(alignment: Alignment.center, children: [
            ColorFiltered(
                colorFilter:
                    const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                child: Image.asset(AppIcons.icRewind64, fit: BoxFit.cover)),
            const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text("15",
                    style: TextStyle(fontSize: 11, color: Colors.blue),
                    textAlign: TextAlign.center))
          ])),
      onPressed: () async {
        await skipAudio15s(false);
      },
    );
  }

  Widget btnFastForward15s() {
    return IconButton(
      icon: Container(
          alignment: Alignment.center,
          width: 40,
          height: 40,
          child: Stack(alignment: Alignment.center, children: [
            ColorFiltered(
                colorFilter:
                    const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
                child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..scale(-1.0, 1.0),
                    child:
                        Image.asset(AppIcons.icRewind64, fit: BoxFit.cover))),
            const Padding(
                padding: EdgeInsets.only(right: 7),
                child: Text("15",
                    style: TextStyle(fontSize: 11, color: Colors.blue),
                    textAlign: TextAlign.center))
          ])),
      onPressed: () async {
        await skipAudio15s(true);
      },
    );
  }

  Widget btnVolume() {
    return IconButton(
      icon: Container(
          alignment: Alignment.center,
          width: 32,
          height: 32,
          child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                  (cubit.volumeValue > 0) ? Colors.blue : Colors.grey,
                  BlendMode.srcIn),
              child: Image.asset(
                  (cubit.volumeValue > 0)
                      ? AppIcons.icVolume64
                      : AppIcons.icMute64,
                  fit: BoxFit.cover))),
      onPressed: () async {
        await showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return VolumeSlider(
              initialValue: cubit.volumeValue,
              onChanged: _updateSliderValue,
            );
          },
        );
      },
    );
  }

  void setVolume() {
    setState(() {
      cubit.volumeValue = 0.5;
      audioPlayer.setVolume(0.5);
    });
  }

  void onPlayerStateChanged() {
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.playing) {
        setState(() {
          cubit.audioState = PlayerState.playing;
          cubit.isPlaying = true;
        });
        startTimer();
      } else {
        stopTimer();
        cubit.isPlaying = false;
        if (state == PlayerState.paused) {
          setState(() {
            cubit.audioState = PlayerState.paused;
          });
        } else if (state == PlayerState.stopped) {
          setState(() {
            cubit.audioState = PlayerState.stopped;
          });
        }
      }
    }, onError: (msg) {
      setState(() {
        cubit.audioState = PlayerState.stopped;
        print("audio error:msg.toString()");
      });
    });
  }

  void _updateSliderValue(double value) {
    setState(() {
      cubit.volumeValue = value;
      audioPlayer.setVolume(value);
    });
  }

  Future<void> skipAudio15s(bool skipForward) async {
    // Duration? currentPosition = await audioPlayer.getCurrentPosition();
    Duration? currentPosition = cubit.position;
    Duration newPosition = cubit.position;
    print(currentPosition);
    if (skipForward) {
      newPosition = currentPosition + const Duration(seconds: 15);
      if (newPosition.inSeconds > cubit.duration.inSeconds) {
        newPosition = cubit.duration;
      }
    } else {
      newPosition = currentPosition - const Duration(seconds: 15);
      if (newPosition.inSeconds < 0) {
        newPosition = const Duration(seconds: 0);
      }
    }
    await audioPlayer.seek(newPosition);
    setState(() {
      cubit.position = newPosition;
    });
  }

  Future<void> playAudio() async {
    audioPlayer.play(UrlSource(cubit.audioUrl), position: cubit.position);
  }

  Future<void> completeAudio() async {
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) async {
      if (state == PlayerState.completed) {
        if (cubit.isLoop) {
          await audioPlayer.play(UrlSource(cubit.audioUrl),
              position: Duration.zero);
        } else {
          setState(() {
            cubit.audioState = PlayerState.stopped;
          });
        }
      }
    });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    cubit.position = newDuration;
    audioPlayer.seek(newDuration);
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      audioPlayer.getCurrentPosition().then((Duration? duration) {
        if (duration != null && audioPlayer.state == PlayerState.playing) {
          setState(() {
            cubit.position = duration;
          });
        }
      });
    });
  }

  void stopTimer() => timer.cancel();

  void onDurationChanged() {
    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        cubit.position = d;
      });
    });
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
    onDurationChanged();
    onPlayerStateChanged();
    setVolume();
    playAudio();
    completeAudio();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
    stopTimer();
  }
}
