import 'dart:async';

import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/modelbottomsheet/presentation/model_bottom_sheet.dart';
import 'package:ar_zoo_explorers/features/story/component/volume_slider.dart';
import 'package:ar_zoo_explorers/features/storyplayer/presentation/storyplayer_cubit.dart';
import 'package:ar_zoo_explorers/features/storyplayer/presentation/storyplayer_state.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  void initState() {
    cubit.init(context);
    _onPlayerStateChanged();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showOptionsDialog();
    });
    // _initCubit();
  }

  Future<void> showOptionsDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(LanguageKeys.msg_continue_story.tr),
          actions: <Widget>[
            TextButton(
              child: Text(LanguageKeys.msg_story_restart.tr),
              onPressed: () async {
                await cubit.showLoading();
                state.position = Duration.zero;
                await _playAudio();
                // await Future.delayed(const Duration(seconds: 1));
                Navigator.of(context).pop();
                await cubit.hideLoading();
              },
            ),
            const Spacer(),
            TextButton(
              child: Text(LanguageKeys.msg_story_continue.tr),
              onPressed: () async {
                await cubit.showLoading();

                await _playAudio();
                // await Future.delayed(const Duration(seconds: 1));
                Navigator.of(context).pop();
                await cubit.hideLoading();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildByState(BuildContext context, StoryPlayerState state) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          await _updatePausedTime(context);
          if (mounted) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
                centerTitle: true,
                title: Text(state.name,
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
                  child: Image.network(state.avatar,
                      width: state.width,
                      height: state.height,
                      fit: BoxFit.cover)),
              backgroundPage(context),
              Positioned(
                  top: state.height * 0.065,
                  right: state.width * 0.05,
                  child: Center(child: viewModelButton()))
            ])));
  }

  Widget viewModelButton() {
    return GestureDetector(
        onTap: () async {
          print(cubit.storyController.currentStory.value.modelId);
          await _showModelBottomSheet(context);
        },
        child: Container(
          height: state.width * 0.16,
          constraints: BoxConstraints(minWidth: state.width * 0.3),
          padding: EdgeInsets.all(state.width * 0.01),
          decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(state.width * 0.08),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 3))
              ]),
          child: Row(children: [
            SizedBox(width: state.width * 0.02),
            Container(
                child: Text(LanguageKeys.msg_story_view_models.tr,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColor.white))),
            SizedBox(width: state.width * 0.01),
            imageViewModelButton(),
          ]),
        ));
  }

  Widget imageViewModelButton() {
    return Container(
      width: state.width * 0.14,
      height: state.width * 0.14,
      padding: const EdgeInsets.all(5),
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: AppColor.white),
      child: ClipOval(
          child: Image.asset(AppIcons.icLion64Color, fit: BoxFit.cover)),
    );
  }

  Widget backButton() {
    return AppIconButton(
      onPressed: () async {
        await cubit.showLoading();
        await _updatePausedTime(context);
        Navigator.of(context).pop(true);
        await cubit.hideLoading();
      },
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
          constraints: BoxConstraints(minHeight: state.height),
          width: state.width,
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
      constraints: BoxConstraints(maxHeight: state.height * 0.85),
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
          top: state.height * 0.12, left: 20, right: 20, bottom: 25),
      // padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
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
        width: state.height * 0.15,
        height: state.height * 0.15,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(state.avatar, fit: BoxFit.cover)));
  }

  Widget txtStoryName() {
    return Container(
        width: state.width,
        height: state.height * 0.07,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Text(state.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
  }

  Widget contentStory() {
    List<String> txtLines = state.content.split('\n');
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
        width: state.width,
        height: state.height * 0.4,
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
        width: state.width * 0.9,
        height: state.height * 0.05,
        // decoration: BoxDecoration(border: Border.all()),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              width: state.width * 0.13,
              alignment: Alignment.center,
              // decoration: BoxDecoration(border: Border.all()),
              child: Text(
                  '${state.position.inMinutes} : ${state.position.inSeconds.remainder(60)}',
                  style: const TextStyle(fontSize: 14))),
          progressSlider(),
          Container(
              width: state.width * 0.13,
              alignment: Alignment.center,
              // decoration: BoxDecoration(border: Border.all()),
              child: Text(
                  '${state.duration.inMinutes} : ${state.duration.inSeconds.remainder(60)}',
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
              value: state.position.inSeconds.toDouble(),
              min: 0.0,
              max: state.duration.inSeconds.toDouble(),
              onChanged: (double value) {
                setState(() {
                  seekToSecond(value.toInt());
                });
              },
            )));
  }

  Widget audioSection() {
    return SizedBox(
      width: state.width,
      height: state.height * 0.08,
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
            state.audioState == PlayerState.playing ? btnPause() : btnPlay());
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
          await audioPlayer.play(UrlSource(state.audioUrl),
              position: state.position);
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
                  state.isLoop ? Colors.blue : Colors.grey, BlendMode.srcIn),
              child: Image.asset(AppIcons.icRefresh64, fit: BoxFit.cover))),
      onPressed: () async {
        await cubit
            .onChangeIsLoop(!state.isLoop)
            .then((value) => setState(() {}));
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
                  (state.volumeValue > 0) ? Colors.blue : Colors.grey,
                  BlendMode.srcIn),
              child: Image.asset(
                  (state.volumeValue > 0)
                      ? AppIcons.icVolume64
                      : AppIcons.icMute64,
                  fit: BoxFit.cover))),
      onPressed: () async {
        await showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return VolumeSlider(
              initialValue: state.volumeValue,
              onChanged: _updateSliderValue,
            );
          },
        );
      },
    );
  }

  Future<void> setVolume(double value) async {
    await cubit.onChangeVolume(value).then((value) => setState(() {}));
    await audioPlayer.setVolume(value).then((value) => setState(() {}));
  }

  Future<void> _onChangePlaying() async {
    await cubit.onChangeAudioState(PlayerState.playing);
    await cubit.onChangeIsPlaying(true);
    if (mounted) setState(() {});
    await startTimer();
  }

  Future<void> _onChangeIsPaused() async {
    await cubit.onChangeAudioState(PlayerState.paused);
    await cubit.onChangeIsPlaying(false);
    if (mounted) setState(() {});
    await stopTimer();
  }

  Future<void> _onChangeIsStopped() async {
    await cubit.onChangeAudioState(PlayerState.stopped);
    await cubit.onChangeIsPlaying(false);
    if (mounted) setState(() {});
    await stopTimer();
  }

  Future<void> _onChangeCompleted() async {
    await cubit.onChangePosition(const Duration(seconds: 0, minutes: 0));
    await _updateComplete();
    if (state.isLoop) {
      await audioPlayer.play(UrlSource(state.audioUrl),
          position: Duration.zero);
      print("Loop");
    } else {
      await _onChangeIsPaused();
      await _showModelBottomSheet(context).then((value) => setState(() {
            print("No Loop");
          }));
    }
  }

  Future<void> _onPlayerStateChanged() async {
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) async {
      if (!mounted) return;
      switch (state) {
        case PlayerState.playing:
          await _onChangePlaying();
          break;
        case PlayerState.paused:
          await _onChangeIsPaused();
          break;
        case PlayerState.stopped:
          await _onChangeIsStopped();
          break;
        case PlayerState.completed:
          await _onChangeCompleted();
          break;
        default:
          await _onChangeIsStopped();
          print("audio state: $state");
      }
      if (mounted) setState(() {});
    }, onError: (msg) async {
      if (!mounted) return;
      await _onChangeIsStopped();
      if (mounted) setState(() {});
    });
  }

  Future<void> _updateSliderValue(double value) async {
    await setVolume(value);
  }

  Future<void> _navigatorToModel(String modelId) async {
    cubit.showLoading();
    await audioPlayer.pause();
    await cubit.animalController.updateCurrentAnimal(context, modelId);
    context.router.pushNamed(Routes.modeldetail);
    cubit.hideLoading();
  }

  Future<void> skipAudio15s(bool skipForward) async {
    // Duration? currentPosition = await audioPlayer.getCurrentPosition();
    Duration? currentPosition = state.position;
    Duration newPosition = state.position;
    print(currentPosition);
    if (skipForward) {
      newPosition = currentPosition + const Duration(seconds: 15);
      if (newPosition.inSeconds > state.duration.inSeconds) {
        newPosition = state.duration;
      }
    } else {
      newPosition = currentPosition - const Duration(seconds: 15);
      if (newPosition.inSeconds < 0) {
        newPosition = const Duration(seconds: 0);
      }
    }
    await audioPlayer.seek(newPosition);
    await cubit.onChangePosition(newPosition).then((value) => setState(() {}));
  }

  Future<void> _playAudio() async {
    audioPlayer.play(UrlSource(state.audioUrl), position: state.position);
  }

  Future<void> seekToSecond(int second) async {
    Duration newDuration = Duration(seconds: second);
    await cubit.onChangePosition(newDuration).then((value) => setState(() {}));
    audioPlayer.seek(newDuration);
  }

  Future<void> startTimer() async {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      await audioPlayer.getCurrentPosition().then((Duration? duration) {
        if (duration != null && audioPlayer.state == PlayerState.playing) {
          cubit.onChangePosition(duration).then((value) {
            if (mounted) setState(() {});
          });
        }
      });
    });
  }

  Future<void> stopTimer() async => timer.cancel();

  Future<void> stopAudio() async => await audioPlayer.dispose();

  Future<void> _updatePausedTime(BuildContext context) async {
    await audioPlayer.stop();
    await cubit.updatePausedTime(context);
  }

  Future<void> _showModelBottomSheet(BuildContext context) async {
    if (cubit.storyController.currentStory.value.modelId.isNotEmpty) {
      // print(cubit.storyController.currentStory.value.modelId);
      await cubit.showLoading();
      await cubit.aniCateController.getAllModelCategories(context);
      await cubit.animalController.getAllAnimals(context);
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(state.height * 0.025))),
        barrierColor: Colors.grey.withOpacity(0.15),
        builder: (BuildContext context) {
          return ModelBottomSheet(
              lstModelId: cubit.storyController.currentStory.value.modelId,
              onTapped: _navigatorToModel);
        },
      );
      await cubit.hideLoading();
    } else {
      await cubit.hideLoading();
      cubit.showToast(LanguageKeys.msg_story_no_has_model.tr);
    }
  }

  Future<void> _updateComplete() async {
    await cubit.updateComplete(context);
  }

  // Future<void> _initCubit() async {
  //   await cubit.showLoading();
  //   cubit.init(context);
  //   await _onPlayerStateChanged();
  //   // await _playAudio();
  //   await cubit.hideLoading();
  // }

  Future<void> _disposePage() async {
    await stopTimer();
    await stopAudio();
  }

  @override
  void dispose() {
    _disposePage();
    super.dispose();
  }
}
