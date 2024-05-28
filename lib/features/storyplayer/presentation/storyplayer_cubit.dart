import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_topic_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/user_story_controller.dart';
import 'package:ar_zoo_explorers/features/storyplayer/presentation/storyplayer_state.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoryPlayerCubit extends BaseCubit<StoryPlayerState> {
  StoryPlayerCubit() : super(StoryPlayerState());

  final controller = AuthController.findOrInitialize;
  final storyTopicController = StoryTopicController.findOrInitialize;
  final userStoryController = UserStoryController.findOrInitialize;
  final storyController = StoryController.findOrInitialize;

  Future<void> init(BuildContext context) async {
    showLoading();
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;

    // await state.setAttributes(
    //   height: mediaSize.height,
    //   width: mediaSize.width,
    //   name: storyController.currentStory.value.title,
    //   avatar: storyController.currentStory.value.avatar,
    //   audioUrl: storyController.currentStory.value.sourceUrl,
    //   content:
    //       storyController.currentStory.value.content.replaceAll("\\n", "\n"),
    //   duration: Duration(seconds: storyController.currentStory.value.duration),
    //   position: Duration(
    //       seconds: userStoryController.currentUserStory.value.pausedTime),
    //   isPlaying: false,
    //   audioState: PlayerState.stopped,
    //   volumeValue: 1.0,
    //   isLoop: false,
    // );

    emit(state.copyWith(
      height: mediaSize.height,
      width: mediaSize.width,
      name: storyController.currentStory.value.title,
      avatar: storyController.currentStory.value.avatar,
      audioUrl: storyController.currentStory.value.sourceUrl,
      content:
          storyController.currentStory.value.content.replaceAll("\\n", "\n"),
      duration: Duration(seconds: storyController.currentStory.value.duration),
      position: Duration(
          seconds: userStoryController.currentUserStory.value.pausedTime),
      isPlaying: false,
      audioState: PlayerState.stopped,
      volumeValue: 1.0,
      isLoop: false,
    ));

    print("Cubit.Init() : Get data");
    hideLoading();
  }

  Future<void> onChangePosition(Duration newPosition) async {
    await state.setAttributes(position: newPosition);
  }

  Future<void> onChangeIsPlaying(bool isPlay) async {
    await state.setAttributes(isPlaying: isPlay);
  }

  Future<void> onChangeAudioState(PlayerState newState) async {
    await state.setAttributes(audioState: newState);
  }

  Future<void> onChangeVolume(double newValue) async {
    await state.setAttributes(volumeValue: newValue);
  }

  Future<void> onChangeIsLoop(bool newValue) async {
    print("Before ${state.isLoop}");
    await state.setAttributes(isLoop: newValue);
    print("After ${state.isLoop}");
  }

  Future<void> updatePausedTime(BuildContext context) async {
    await userStoryController.updatePausedTime(context,
        id: userStoryController.currentUserStory.value.id,
        pausedTime: state.position.inSeconds);
  }

  Future<void> updateComplete(BuildContext context) async {
    if (!userStoryController.currentUserStory.value.isCompleted) {
      await userStoryController.updateComplete(context,
          id: userStoryController.currentUserStory.value.id, isCompleted: true);
    }
  }
}
