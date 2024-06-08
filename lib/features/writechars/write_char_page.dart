import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/writechars/write_char_cubit.dart';
import 'package:ar_zoo_explorers/features/writechars/write_char_state.dart';
import 'package:ar_zoo_explorers/utils/widget/image_svg_url_custom.dart';
import 'package:auto_route/auto_route.dart';
import 'package:finger_painter/finger_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

@RoutePage()
class WriteCharsPage extends StatefulWidget {
  const WriteCharsPage({super.key});

  @override
  State createState() => _State();
}

class _State
    extends BaseState<WriteCharsState, WriteCharsCubit, WriteCharsPage> {
  Image? image;
  late PainterController painterController;
  List<Uint8List> _drawingHistory = [];
  int _currentHistoryIndex = -1;
  int penSelected = 1;
  Color colorSelected = Colors.black;
  List<Color> colors = [];
  final double _icBackTopPosition = 0;
  double _scrollPosition = 0.0;
  @override
  void initState() {
    cubit.showLoading();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    cubit.init();
    generateBlackToWhiteColors();
    painterController = PainterController()
      ..setStrokeColor(Colors.black)
      ..setMinStrokeWidth(10)
      ..setMaxStrokeWidth(10)
      ..setBlurSigma(0.0)
      ..setPenType(PenType.paintbrush2);
    _loadAndSetImage();
    cubit.hideLoading();
    super.initState();
  }

  List<Color> generateBlackToWhiteColors() {
    for (int i = 0; i < 20; i++) {
      double hue = (360 * i / 20) % 360;
      colors.add(HSVColor.fromAHSV(1, hue, 1, 1).toColor());
    }
    return colors;
  }

  void _updateColor(double position) {
    int index = (position / (41)).floor();
    if (index >= 0 && index < colors.length) {
      setState(() {
        colorSelected = colors[index];
      });
      painterController.setStrokeColor(colorSelected);
    }
  }

  Future<void> _loadAndSetImage() async {
    try {
      Uint8List image =
          (await rootBundle.load('assets/images/learning_image/write/A.jpg'))
              .buffer
              .asUint8List();
      Uint8List resizedImage =
          resizeImage(image, state.height * 0.75, state.width * 0.92);
      painterController.setBackgroundImage(resizedImage);
      state.backgroundImageBytes = resizedImage;
      _addToHistory(resizedImage);
    } catch (e) {
      print("TTT $e");
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget buildByState(BuildContext context, WriteCharsState state) {
    return Scaffold(
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
          Column(
            children: [
              const SizedBox(
                height: 4,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: state.width * 0.9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    context.router.pop();
                                  },
                                  child: const ImageSvgUrlCustom(
                                      imagePath: AppIcons.icBackPng)),
                              Container(
                                color: Colors.red,
                                child: IconButton(
                                    icon: const Icon(Icons.delete_outline,
                                        size: 30),
                                    color: Colors.white,
                                    onPressed: () {
                                      _drawingHistory = [];
                                      _currentHistoryIndex = 0;
                                      painterController.setBackgroundImage(
                                          state.backgroundImageBytes!);
                                      setState(() {});
                                    }),
                              ),
                              Container(
                                color: _currentHistoryIndex > 0
                                    ? Colors.blue
                                    : Colors.grey,
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
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Painter(
                          controller: painterController,
                          backgroundColor: const Color(0xFFF0F0F0),
                          onDrawingEnded: (bytes) async {
                            _addToHistory(bytes!);
                            setState(() {});
                          },
                          size: Size(state.height * 0.75, state.width * 0.92),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: state.width * 0.99,
                                width: 50,
                                decoration: const BoxDecoration(
                                    border: Border.symmetric(
                                        vertical: BorderSide(width: 3))),
                                child: NotificationListener<ScrollNotification>(
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
                                    itemBuilder: (context, index) {
                                      if (index == 0 ||
                                          index >= colors.length) {
                                        return SizedBox(
                                          height: state.width * 0.5,
                                          child: Center(
                                            child: Container(
                                              width: state.width * 0.4,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return SizedBox(
                                        height: 50,
                                        child: Center(
                                          child: Container(
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: colors[index],
                                            ),
                                          ),
                                        ),
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
                                top: 0,
                                bottom: 0,
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
                      Column(
                        children: [
                          for (var i = 0; i < 3; i++)
                            GestureDetector(
                              onTap: () {
                                List<double> strokeWidths = [2, 10, 20];
                                penSelected = i;
                                painterController
                                    .setMinStrokeWidth(strokeWidths[i]);
                                painterController
                                    .setMaxStrokeWidth(strokeWidths[i]);
                                setState(() {});
                              },
                              child: ImageSvgUrlCustom(
                                height: state.height * 0.0839,
                                width: state.height * 0.0839,
                                imagePath: penSelected == i
                                    ? _getSelectedImagePath(i)
                                    : _getDefaultImagePath(i),
                              ),
                            ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getSelectedColor(double scrollPosition) {
    // Calculate the index of the selected color based on scroll position
    int index = (scrollPosition / 40).floor();
    return colors[index];
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

  Uint8List resizeImage(Uint8List data, double width, double height) {
    img.Image image = img.decodeImage(data)!;
    img.Image resizedImage =
        img.copyResize(image, width: width.toInt(), height: height.toInt());
    return Uint8List.fromList(img.encodePng(resizedImage));
  }
}
