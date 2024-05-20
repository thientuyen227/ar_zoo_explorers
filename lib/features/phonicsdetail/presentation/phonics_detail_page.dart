import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/core/data/controller/chars_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/chars_entity.dart';
import 'package:ar_zoo_explorers/features/phonicsdetail/presentation/phonics_detail_cubit.dart';
import 'package:ar_zoo_explorers/features/phonicsdetail/presentation/phonics_detail_state.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

@RoutePage()
class PhonicsDetailPage extends StatefulWidget {
  const PhonicsDetailPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<PhonicsDetailState, PhonicsDetailCubit,
    PhonicsDetailPage> {
  String vietnameseAlphabet = 'aăâbcdđeêghiklmnoôơpqrstuưvxy';
  String englishAlphabet = 'abcdefghijklmnopqrstuvwxyz';
  String numbers = '1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20';
  CharsController charsController = CharsController.findOrInitialize;
  final languageCode = Get.locale?.languageCode;
  AudioPlayer audioPlayer = AudioPlayer();
  List<CharsEntity>? xalphabet;
  List<CharsEntity>? listChars;
  // bool _isOrientationLocked = true;

  @override
  void initState() {
    super.initState();
    fetchData();
    onPlayerStateChanged();
    setVolume();
    completeAudio();
  }

  Future<void> fetchData() async {
    xalphabet = await charsController.getAllChars(context);
    setState(() {}); // Yêu cầu build lại UI sau khi nhận được dữ liệu
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
  bool isNumber = false;
  @override
  Widget buildByState(BuildContext context, PhonicsDetailState state) {
    List<String> alphabetChars;
    if (isNumber == false) {
      if (languageCode == 'en') {
        alphabetChars = englishAlphabet.split('');
      } else {
        alphabetChars = vietnameseAlphabet.split('');
      }
    } else {
      alphabetChars = numbers.split(' ');
    }
    listChars = xalphabet!.where((element) {
      return alphabetChars.contains(element.char);
    }).toList();
    if (isNumber) {
      listChars!.sort((a, b) {
        return int.parse(a.char).compareTo(int.parse(b.char));
      });
    }

    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          Navigator.of(context).pop();
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isUpperCase = !isUpperCase;
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
                            child: Center(
                                child: isUpperCase == true
                                    ? const Text("Chữ in hoa")
                                    : const Text(
                                        "Chữ thường",
                                      )),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isNumber = !isNumber;
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
                              "Số đếm",
                            )),
                          ),
                        ),
                      ],
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isNumber == true ? 7 : 8,
                        childAspectRatio: 1.18,
                        crossAxisSpacing: 1,
                      ),
                      itemCount: listChars!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                audioPlayer.play(AssetSource(
                                    listChars![index].audiosLocalize));
                              },
                              child: Text(
                                isUpperCase == true
                                    ? listChars![index].char.toUpperCase()
                                    : listChars![index].char.toLowerCase(),
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
