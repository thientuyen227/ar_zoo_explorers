import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListeningStoryButton extends StatefulWidget {
  const ListeningStoryButton({Key? key, required this.item}) : super(key: key);
  final StoryButtonObject item;

  @override
  _ListeningStoryButtonState createState() => _ListeningStoryButtonState();
}

class _ListeningStoryButtonState extends State<ListeningStoryButton> {
  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          width: width,
          constraints: BoxConstraints(minHeight: height * 0.18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width * 0.03),
              color: AppColor.white),
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(children: [
            const SizedBox(width: 20),
            imageStory(widget.item.avatar),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  buttonFieldName(widget.item.name, isTitle: true),
                  Row(children: [
                    buttonFieldName("${LanguageKeys.duration.tr} : "),
                    Text(
                        '${(widget.item.duration.inMinutes < 10) ? '0' : ''}${widget.item.duration.inMinutes} : ${(widget.item.duration.inSeconds.remainder(60) < 10) ? '0' : ''}${widget.item.duration.inSeconds.remainder(60)}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green))
                  ]),
                  topicStory(widget.item.topic[0]),
                  progressBar(widget.item.timestamp, widget.item.duration)
                ])),
            const SizedBox(width: 20),
          ])),
      widget.item.isCompleted
          ? Positioned(
              top: width * 0.025,
              left: width * 0.025,
              child: Center(child: imageTicked()))
          : Container(),
    ]);
  }

  Widget buttonFieldName(String name, {bool isTitle = false}) {
    return Text(
      name,
      style: TextStyle(
          fontSize: isTitle ? 18 : 14,
          fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
          color: isTitle ? Colors.black : Colors.grey.shade700),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget topicStory(String topic) {
    return Container(
        padding: const EdgeInsets.all(5),
        color: Colors.grey.shade50,
        child: Text(topic,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700)));
  }

  Widget imageStory(String url) {
    return SizedBox(
      height: width * 0.25,
      width: width * 0.25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width * 0.03),
        child: Image.network(url, fit: BoxFit.cover),
      ),
    );
  }

  Widget imageTicked() {
    return Container(
        height: width * 0.06,
        width: width * 0.06,
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3))
        ]),
        child: ClipOval(
            child: Image.asset(AppIcons.icChecked64Green, fit: BoxFit.cover)));
  }

  Widget progressBar(Duration timestamp, Duration duration) {
    double progress = (timestamp.inSeconds / duration.inSeconds);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      // Widget LinearProgressIndicator
      Expanded(
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey.shade600)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor: Colors.grey[200],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  )))),
      const SizedBox(width: 5),
      Text("${(progress * 100).toStringAsFixed(2)}%",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
    ]);
  }

  Future<void> _setDimension() async {
    Size mediaSize = MediaQueryData.fromView(
            WidgetsBinding.instance.platformDispatcher.views.single)
        .size;

    setState(() {
      width = mediaSize.width;
      height = mediaSize.height;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _setDimension();
  }
}
