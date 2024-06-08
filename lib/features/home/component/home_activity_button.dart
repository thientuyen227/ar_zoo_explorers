import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:flutter/material.dart';

class HomeActivityButton extends StatefulWidget {
  const HomeActivityButton({
    Key? key,
    required this.imageUrl,
    required this.content,
  }) : super(key: key);
  // final ButtonObject item;
  final String imageUrl;
  final String content;

  @override
  _HomeActivityButtonState createState() => _HomeActivityButtonState();
}

class _HomeActivityButtonState extends State<HomeActivityButton> {
  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width * 0.85,
        height: height * 0.1,
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 3))
            ]),
        child: Row(
          children: [
            const SizedBox(width: 10),
            activityButtonImage(widget.imageUrl),
            const SizedBox(width: 10),
            activityButtonContent(widget.content),
          ],
        ));
  }

  Widget activityButtonImage(String imageUrl) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(imageUrl,
            width: height * 0.08, height: height * 0.08, fit: BoxFit.cover));
  }

  Widget activityButtonContent(String content) {
    return SizedBox(
        width: width * 0.55,
        child: Text(
          content,
          style: const TextStyle(
              color: AppColor.white, fontSize: 18, fontWeight: FontWeight.w700),
          softWrap: true,
        ));
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
