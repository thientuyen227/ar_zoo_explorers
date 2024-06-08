import 'dart:async';

import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/domain/entities/chars_entity.dart';
import 'package:ar_zoo_explorers/features/phonicsdetail/presentation/phonics_detail_cubit.dart';
import 'package:ar_zoo_explorers/features/phonicsdetail/presentation/phonics_detail_state.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PhonicsDetailPage extends StatefulWidget {
  PhonicsDetailPage({super.key, required this.type});
  String type;
  @override
  State createState() => _State();
}

class _State extends BaseState<PhonicsDetailState, PhonicsDetailCubit,
    PhonicsDetailPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  StreamSubscription<PlayerState>? _playerStateSubscription;
  StreamSubscription<PlayerState>? _completeAudioSubscription;
  StreamSubscription<Duration>? _durationSubscription;
  // bool _isOrientationLocked = true;

  @override
  void initState() {
    super.initState();
    cubit.showLoading();
    cubit.init(type: widget.type);
    onPlayerStateChanged();
    setVolume();
    completeAudio();

    cubit.hideLoading();
  }

  void onPlayerStateChanged() {
    _playerStateSubscription =
        audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (!mounted) return;

      if (state == PlayerState.playing) {
        setState(() {
          cubit.audioState = PlayerState.playing;
          cubit.isPlaying = true;
        });
      } else {
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
      if (!mounted) return;
      setState(() {
        cubit.audioState = PlayerState.stopped;
        print("audio error: ${msg.toString()}");
      });
    });
  }

  Future<void> completeAudio() async {
    _completeAudioSubscription =
        audioPlayer.onPlayerStateChanged.listen((PlayerState state) async {
      if (!mounted) return;

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

  void setVolume() {
    if (!mounted) return;
    setState(() {
      cubit.volumeValue = 0.9;
      audioPlayer.setVolume(0.9);
    });
  }

  void onDurationChanged() {
    _durationSubscription = audioPlayer.onDurationChanged.listen((Duration d) {
      if (!mounted) return;
      setState(() {
        cubit.position = d;
      });
    });
  }

  @override
  void dispose() {
    _playerStateSubscription?.cancel();
    _completeAudioSubscription?.cancel();
    _durationSubscription?.cancel();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget buildByState(BuildContext context, PhonicsDetailState state) {
    if (state.isNumber) {
      state.charsEntities.sort((a, b) {
        return int.parse(a.char).compareTo(int.parse(b.char));
      });
    }
    return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          context.router.pop();
        },
        child: Scaffold(
            body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.backgroundPhonics),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              context.router.pop();
                            },
                            child: const ImageSvgUrlCustom(
                                imagePath: AppIcons.icBackPng)),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cubit.isNumber == true ? 7 : 8,
                        childAspectRatio: 1.18,
                        crossAxisSpacing: 1,
                      ),
                      itemCount: state.charsEntities.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                audioPlayer.play(AssetSource(
                                    state.charsEntities[index].audiosLocalize));
                              },
                              child: Text(
                                state.isUpperCase == true
                                    ? state.charsEntities[index].char
                                        .toUpperCase()
                                    : state.charsEntities[index].char
                                        .toLowerCase(),
                                style: TextStyle(
                                  fontSize: 62,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Coiny-Regular",
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: const Offset(2.0, 2.0),
                                      blurRadius: 3.0,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}
