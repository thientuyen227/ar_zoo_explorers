import 'package:ar_zoo_explorers/app/theme/colors.dart';
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
  const PhonicsDetailPage({super.key, required this.type});
  final String type;
  @override
  State createState() => _State();
}

class _State extends BaseState<PhonicsDetailState, PhonicsDetailCubit,
    PhonicsDetailPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isReading = false;
  bool isSinging = false;
  int selectedIndex = -1;

  @override
  void initState() {
    cubit.init(context: context, type: widget.type);
    super.initState();
    // onPlayerStateChanged();
    setVolume();
    // completeAudio();
  }

  // void onPlayerStateChanged() {
  //   audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
  //     if (!mounted) return;

  //     if (state == PlayerState.playing) {
  //       setState(() {
  //         cubit.audioState = PlayerState.playing;
  //         cubit.isPlaying = true;
  //       });
  //     } else {
  //       cubit.isPlaying = false;
  //       if (state == PlayerState.paused) {
  //         setState(() {
  //           cubit.audioState = PlayerState.paused;
  //         });
  //       } else if (state == PlayerState.stopped) {
  //         setState(() {
  //           cubit.audioState = PlayerState.stopped;
  //         });
  //       }
  //     }
  //   }, onError: (msg) {
  //     if (!mounted) return;
  //     setState(() {
  //       cubit.audioState = PlayerState.stopped;
  //       print("audio error: ${msg.toString()}");
  //     });
  //   });
  // }

  // Future<void> completeAudio() async {
  //   audioPlayer.onPlayerStateChanged.listen((PlayerState state) async {
  //     if (!mounted) return;
  //     if (state == PlayerState.completed) {
  //       if (cubit.isLoop) {
  //         await audioPlayer.play(UrlSource(cubit.audioUrl[cubit.languageCode]!),
  //             position: Duration.zero);
  //       } else {
  //         setState(() {
  //           cubit.audioState = PlayerState.stopped;
  //         });
  //       }
  //     }
  //   });
  // }

  void setVolume() {
    if (!mounted) return;
    setState(() {
      audioPlayer.setVolume(1);
    });
  }

  @override
  void dispose() {
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
                  image: AssetImage(AppImages.backgroundPhonicsDetail),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            state.height != 0
                ? SingleChildScrollView(
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
                              const Spacer(),
                              btnReadAndSing(),
                              const Spacer(),
                              const SizedBox(
                                width: 40,
                              )
                            ],
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: cubit.isNumber == true ? 6 : 8,
                              crossAxisSpacing: 4,
                              mainAxisSpacing: 4,
                              childAspectRatio: cubit.isNumber == true
                                  ? state.height * 2.3 / state.width
                                  : state.height * 1.6 / state.width,
                            ),
                            itemCount: state.charsEntities.length,
                            itemBuilder: (context, index) {
                              return Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: selectedIndex == index
                                      ? AppColor.vibrantYellow.withOpacity(0.5)
                                      : Colors.transparent,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    audioPlayer.play(UrlSource(state
                                        .charsEntities[index].audiosLocalize));
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                  child: Text(
                                    state.isUpperCase == true
                                        ? state.charsEntities[index].char
                                            .toUpperCase()
                                        : state.charsEntities[index].char
                                            .toLowerCase(),
                                    style: TextStyle(
                                      fontSize: 90,
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
                              );
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        )));
  }

  void toggleRead() {
    setState(() {
      isReading = !isReading;
      if (isReading) {
        audioPlayer.stop();
        audioPlayer.play(AssetSource(cubit.audioUrlRead[cubit.languageCode]!));
        isSinging = false;
      } else {
        audioPlayer.stop();
      }
    });
  }

  void toggleSing() {
    setState(() {
      isSinging = !isSinging;
      if (isSinging) {
        audioPlayer.stop();
        audioPlayer.play(AssetSource(cubit.audioUrlSing[cubit.languageCode]!));
        isReading = false;
      } else {
        audioPlayer.stop();
      }
    });
  }

  Widget btnReadAndSing() {
    return cubit.languageCode == 'en'
        ? Row(
            children: [
              renderButton(
                  AppImages.imgReadEn,
                  isReading ? AppImages.imgStopEn : AppImages.imgReadEn,
                  toggleRead),
              const SizedBox(width: 8),
              renderButton(
                  AppImages.imgSingEn,
                  isSinging ? AppImages.imgStopEn : AppImages.imgSingEn,
                  toggleSing),
            ],
          )
        : Row(
            children: [
              renderButton(
                  AppImages.imgReadVi,
                  isReading ? AppImages.imgStopVi : AppImages.imgReadVi,
                  toggleRead),
              const SizedBox(width: 8),
              renderButton(
                  AppImages.imgSingVi,
                  isSinging ? AppImages.imgStopVi : AppImages.imgSingVi,
                  toggleSing),
            ],
          );
  }

  Widget renderButton(String image, String stopImage, VoidCallback onPressed) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(isReading || isSinging ? stopImage : image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: Colors.transparent,
            minimumSize: const Size(50, 50),
            shadowColor: Colors.transparent,
          ),
          child: const Text(""),
        ),
      ],
    );
  }
}
