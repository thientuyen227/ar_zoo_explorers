import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VolumeSlider extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onChanged;

  const VolumeSlider({
    Key? key,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  _VolumeSliderState createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double _currentSliderValue = 1.0;
  double _tmpVolumeValue = 1.0;
  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150.0,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(LanguageKeys.volume.tr,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 15.0),
          Row(children: [
            btnVolume(),
            Expanded(
                child: Slider(
              value: _currentSliderValue,
              min: 0,
              max: 2,
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
                if (_currentSliderValue == 0) {
                  _tmpVolumeValue = 1.0;
                }
                widget.onChanged(value);
              },
              activeColor: Colors.blue,
              inactiveColor: Colors.grey.shade500,
            ))
          ])
        ]));
  }

  Widget btnVolume() {
    return IconButton(
        icon: Container(
            alignment: Alignment.center,
            width: 32,
            height: 32,
            child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    (_currentSliderValue > 0) ? Colors.blue : Colors.grey,
                    BlendMode.srcIn),
                child: Image.asset(
                    (_currentSliderValue > 0)
                        ? AppIcons.icVolume64
                        : AppIcons.icMute64,
                    fit: BoxFit.cover))),
        onPressed: () async {
          await onTapVolume();
        });
  }

  Future<void> onTapVolume() async {
    setState(() {
      if (_currentSliderValue > 0) {
        _tmpVolumeValue = _currentSliderValue;
        _currentSliderValue = 0;
      } else {
        _currentSliderValue = _tmpVolumeValue;
      }
    });
    widget.onChanged(_currentSliderValue);
  }

  void _setDimension() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        width = MediaQuery.of(context).size.width;
        height = MediaQuery.of(context).size.height;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _currentSliderValue = widget.initialValue;
    _setDimension();
  }
}
