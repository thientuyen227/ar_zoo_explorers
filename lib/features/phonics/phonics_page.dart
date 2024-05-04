import 'package:ar_zoo_explorers/app/languages/localization_service.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/phonics/phonics_cubit.dart';
import 'package:ar_zoo_explorers/features/phonics/phonics_state.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class PhonicsPage extends StatefulWidget {
  const PhonicsPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<PhonicsState, PhonicsCubit, PhonicsPage> {
  String vietnameseAlphabet = 'aăâbcdđeêghiklmnoôơpqrstuưvxy';
  String englishAlphabet = 'abcdefghijklmnopqrstuvwxyz';
  final Locale _locale = LocalizationService.locale;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    onPlayerStateChanged();
    setVolume();
    completeAudio();
  }

  void onPlayerStateChanged() {
    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
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
      setState(() {
        cubit.audioState = PlayerState.stopped;
        print("audio error:msg.toString()");
      });
    });
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

  void setVolume() {
    setState(() {
      cubit.volumeValue = 0.9;
      audioPlayer.setVolume(0.9);
    });
  }

  void onDurationChanged() {
    audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        cubit.position = d;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  bool isUpperCase = false;
  @override
  Widget buildByState(BuildContext context, PhonicsState state) {
    List<String> alphabetChars;
    if (_locale.countryCode == 'en') {
      alphabetChars = englishAlphabet.split('');
    } else {
      alphabetChars = vietnameseAlphabet.split('');
    }
    return RotatedBox(
      quarterTurns: 1,
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
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isUpperCase = true;
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(
                              child: Text(
                            "Chữ in hoa",
                          )),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isUpperCase = false;
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: const Center(child: Text("Chữ thường")),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      childAspectRatio: isUpperCase == true ? 1.0 : 0.75,
                      crossAxisSpacing: 1,
                    ),
                    itemCount: alphabetChars.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              audioPlayer.play(AssetSource(cubit.audioUrl));
                            },
                            child: Text(
                              isUpperCase == true
                                  ? alphabetChars[index].toUpperCase()
                                  : alphabetChars[index].toLowerCase(),
                              style: TextStyle(
                                fontSize: 120,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontFamily: isUpperCase == true
                                    ? "SVN-Poky's"
                                    : "SVN-Poky's",
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
      )),
    );
  }
}
