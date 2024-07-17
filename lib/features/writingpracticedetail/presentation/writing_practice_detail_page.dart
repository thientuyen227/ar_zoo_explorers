import 'dart:async';

import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/core/data/controller/writing_practice_controller.dart';
import 'package:ar_zoo_explorers/domain/entities/chars_entity.dart';
import 'package:ar_zoo_explorers/features/writingpracticedetail/components/dialog_exit.dart';
import 'package:ar_zoo_explorers/features/writingpracticedetail/presentation/writing_practice_detail_cubit.dart';
import 'package:ar_zoo_explorers/features/writingpracticedetail/presentation/writing_practice_detail_state.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:finger_painter/finger_painter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class WritingPracticeDetailPage extends StatefulWidget {
  const WritingPracticeDetailPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<
    WritingPracticeDetailState,
    WritingPracticeDetailCubit,
    WritingPracticeDetailPage> with SingleTickerProviderStateMixin {
  final languageCode = Get.locale?.languageCode;
  WritingPracticeController writingPracticeController =
      WritingPracticeController.findOrInitialize;
  late PainterController painterController;
  AudioPlayer audioPlayer = AudioPlayer();
  late AnimationController _animationController;
  List<Uint8List> _drawingHistory = [];
  int _currentHistoryIndex = -1;
  int penSelected = 1;
  Color colorSelected = Colors.black;
  List<Color> colors = [];
  double _scrollPosition = 0.0;
  final GlobalKey _globalKey = GlobalKey();
  Offset? _lastPoint;
  bool _showAnimation = false;
  bool isDelete = false;
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    colors = cubit.generateBlackToWhiteColors();
    painterController = PainterController()
      ..setStrokeColor(Colors.black)
      ..setMinStrokeWidth(10)
      ..setMaxStrokeWidth(10)
      ..setBlurSigma(0.0)
      ..setPenType(PenType.paintbrush2);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]).then((value) {
      cubit.init(context);
    });
  }

  @override
  onStateChanged(
      WritingPracticeDetailState previous, WritingPracticeDetailState current) {
    if (previous.charsEntity != current.charsEntity) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _loadAndSetImage(currentCharsEntity: current.charsEntity);
      });
    }
    return super.onStateChanged(previous, current);
  }

  void _updateColor(double position) {
    int index = (position / (41 + state.height * 0.02)).floor();
    if (index >= 0 && index < colors.length) {
      setState(() {
        colorSelected = colors[index];
      });
      painterController.setStrokeColor(colorSelected);
    }
    if (index == colors.length) {
      painterController.setStrokeColor(Colors.white);
    }
  }

  Future<void> _loadAndSetImage(
      {required CharsEntity? currentCharsEntity}) async {
    try {
      Uint8List image;
      if (currentCharsEntity != null) {
        if (isDelete) {
          CharsEntity charsEntity = cubit.listChars!
              .firstWhere((element) => element.id == currentCharsEntity.id);
          image = (await rootBundle.load(charsEntity.imagePaths[languageCode]!))
              .buffer
              .asUint8List();
          isDelete = false;
        } else {
          if (currentCharsEntity.imagePaths[languageCode]!
              .startsWith('https')) {
            image = await _loadImageFromFirebase(
                currentCharsEntity.imagePaths[languageCode]!);
          } else {
            image = (await rootBundle
                    .load(currentCharsEntity.imagePaths[languageCode]!))
                .buffer
                .asUint8List();
          }
        }
        Uint8List resizedImage =
            cubit.resizeImage(image, state.width * 0.66, state.height * 0.94);
        await painterController.setBackgroundImage(resizedImage);
        _addToHistory(resizedImage);
      }
    } catch (e) {
      throw Fluttertoast.showToast(
          msg: LanguageKeys.download_image_failures.tr);
    }
  }

  Future<Uint8List> _loadImageFromFirebase(String imageUrl) async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.refFromURL(imageUrl);
      final imageBytes = await storageReference.getData();
      if (imageBytes == null) {
        throw Fluttertoast.showToast(
            msg: LanguageKeys.download_image_failures.tr);
      }
      return imageBytes;
    } catch (e) {
      throw Fluttertoast.showToast(
          msg: LanguageKeys.download_image_failures.tr);
    }
  }

  void _addToHistory(Uint8List imageBytes) {
    if (_currentHistoryIndex < _drawingHistory.length - 1) {
      _drawingHistory = _drawingHistory.sublist(0, _currentHistoryIndex + 1);
    }
    _drawingHistory.add(imageBytes);
    _currentHistoryIndex++;
  }

  void _undo() {
    if (_currentHistoryIndex >= 0) {
      _currentHistoryIndex--;
      painterController
          .setBackgroundImage(_drawingHistory[_currentHistoryIndex]);
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
    painterController.clearContent();
  }

  @override
  Widget buildByState(BuildContext context, WritingPracticeDetailState state) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.backgroundWriting),
                fit: BoxFit.cover,
              ),
            ),
          ),
          state.height != 0
              ? Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              buttonsFirst(),
                              const SizedBox(
                                width: 10,
                              ),
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: RepaintBoundary(
                                      key: _globalKey,
                                      child: Painter(
                                        controller: painterController,
                                        backgroundColor:
                                            const Color(0xFFF0F0F0),
                                        onDrawingEnded: (bytes) async {
                                          _animationController.reset();
                                          _animationController.forward();
                                          _addToHistory(bytes!);
                                          setState(() {
                                            final points =
                                                painterController.getPoints();

                                            if (points != null &&
                                                points.isNotEmpty) {
                                              _lastPoint = points.last;
                                              _showAnimation = true;
                                              Timer(const Duration(seconds: 1),
                                                  () {
                                                setState(() {
                                                  _showAnimation = false;
                                                });
                                              });
                                            }
                                          });
                                        },
                                        size: Size(state.width * 0.66,
                                            state.height * 0.94),
                                      ),
                                    ),
                                  ),
                                  if (_lastPoint != null)
                                    Positioned(
                                      left: _lastPoint!.dx - 50,
                                      top: _lastPoint!.dy - 50,
                                      child: Visibility(
                                        visible: _showAnimation,
                                        child: Lottie.asset(
                                          AppLotties.complete,
                                          controller: _animationController,
                                          width: 100,
                                          height: 100,
                                          onLoaded: (composition) {
                                            _animationController.duration =
                                                composition.duration;
                                            audioPlayer.play(AssetSource(
                                                "audio/complete.mp3"));
                                          },
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: state.height,
                                  width: 50,
                                  decoration: const BoxDecoration(
                                      color: Colors.amber,
                                      border: Border.symmetric(
                                          vertical: BorderSide(width: 3))),
                                  child:
                                      NotificationListener<ScrollNotification>(
                                    onNotification: (scrollNotification) {
                                      if (scrollNotification
                                          is ScrollUpdateNotification) {
                                        setState(() {
                                          _scrollPosition =
                                              scrollNotification.metrics.pixels;
                                          _updateColor(_scrollPosition);
                                        });
                                      }
                                      return true;
                                    },
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        if (index == 0 ||
                                            index >= colors.length) {
                                          return Center(
                                            child: Container(
                                              width: state.width * 0.4,
                                              height: index == 0
                                                  ? state.height * 0.59
                                                  : state.height * 0.4,
                                              color: index == 0
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          );
                                        }
                                        return Container(
                                          height: 50,
                                          width: 50,
                                          color: colors[index],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider(
                                          height: 1,
                                          color: Colors.black,
                                        );
                                      },
                                      itemCount: colors.length + 1,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -1,
                                  bottom: 1,
                                  child: ImageSvgUrlCustom(
                                    imagePath: AppIcons.icBack,
                                    color: colorSelected,
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        imagePen()
                      ],
                    ),
                  ],
                )
              : Stack(
                  children: [
                    ModalBarrier(
                      color: Colors.black.withOpacity(0.5),
                      dismissible: false,
                    ),
                    Center(
                      child: Lottie.asset(AppLotties.loading,
                          height: 150, width: 150),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  String _getSelectedImagePath(int index) {
    List<String> selectedImages = [
      AppIcons.selectedPencil,
      AppIcons.selectedBrushPen,
      AppIcons.selectedBrushPen2,
    ];
    return selectedImages[index];
  }

  String _getDefaultImagePath(int index) {
    List<String> defaultImages = [
      AppIcons.pencil,
      AppIcons.brushPen,
      AppIcons.brushPen2,
    ];
    return defaultImages[index];
  }

  Widget buttonsFirst() {
    return SizedBox(
      height: state.height * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return SizedBox(
                          height: 110,
                          width: 80,
                          child: DialogExit(
                            globalKey: _globalKey,
                            painterController: painterController,
                            state: state,
                          ));
                    }).then((value) async {
                  if (value == true) {
                    return Navigator.pop(context, true);
                  } else {
                    return Navigator.pop(context, false);
                  }
                });
              },
              child: const ImageSvgUrlCustom(imagePath: AppIcons.icBackPng)),
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
                child: IconButton(
                    icon: const Icon(Icons.delete_outline, size: 30),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        _drawingHistory = [];
                        _currentHistoryIndex = -1;
                      });
                      isDelete = true;
                      _loadAndSetImage(currentCharsEntity: state.charsEntity);
                    }),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: _currentHistoryIndex > 0 ? Colors.blue : Colors.grey,
                    shape: BoxShape.circle),
                child: IconButton(
                    icon: const Icon(Icons.undo, size: 30),
                    color: Colors.white,
                    onPressed: () {
                      if (_currentHistoryIndex > 0) {
                        _undo();
                      }
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget imagePen() {
    return SizedBox(
      height: state.height * 0.99,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < 3; i++)
            GestureDetector(
              onTap: () {
                List<double> strokeWidths = [2, 10, 20];
                penSelected = i;
                painterController.setMinStrokeWidth(strokeWidths[i]);
                painterController.setMaxStrokeWidth(strokeWidths[i]);
                setState(() {});
              },
              child: ImageSvgUrlCustom(
                height: state.width * 0.0839,
                width: state.height * 0.0839,
                imagePath: penSelected == i
                    ? _getSelectedImagePath(i)
                    : _getDefaultImagePath(i),
              ),
            ),
        ],
      ),
    );
  }
}
