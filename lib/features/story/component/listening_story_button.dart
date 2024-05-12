import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:flutter/material.dart';

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
    return Container(
        width: width,
        color: Colors.white,
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
                  buttonFieldName("Thời lượng : "),
                  Text(
                      '${widget.item.duration.inMinutes} phút ${widget.item.duration.inSeconds.remainder(60)} giây',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green))
                ]),
                topicStory(widget.item.topic[0]),
                progressBar(widget.item.timestamp, widget.item.duration)
              ])),
          const SizedBox(width: 20),
        ]));
  }

  Widget buttonFieldName(String name, {bool isTitle = false}) {
    return Text(name,
        style: TextStyle(
            fontSize: isTitle ? 18 : 14,
            fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
            color: isTitle ? Colors.black : Colors.grey.shade700));
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
        child: ClipRRect(child: Image.network(url, fit: BoxFit.cover)));
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
    _setDimension();
  }
}
