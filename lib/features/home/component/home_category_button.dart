import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/features/base-model/button_object.dart';
import 'package:flutter/material.dart';

class HomeCategoryButton extends StatefulWidget {
  const HomeCategoryButton({
    Key? key,
    required this.item,
  }) : super(key: key);
  final ButtonObject item;

  @override
  _HomeCategoryButtonState createState() => _HomeCategoryButtonState();
}

class _HomeCategoryButtonState extends State<HomeCategoryButton> {
  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width * 0.37,
        height: width * 0.37,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 7),
            borderRadius: BorderRadius.circular(15.0),
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3))
            ]),
        child: Column(children: [
          buttonImage(widget.item.icon),
          Padding(
              padding: const EdgeInsets.only(top: 5),
              child: buttonTitle(widget.item.title)),
        ]));
  }

  Widget buttonImage(String url) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        width: width * 0.23,
        height: width * 0.23,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), color: AppColor.white),
        child: (url == "")
            ? Image.asset(AppImages.imgProfile128x128, fit: BoxFit.cover)
            : Image.network(url, fit: BoxFit.cover));
  }

  Widget buttonTitle(String title) {
    return SizedBox(
        width: width * 0.24,
        child: Text(title,
            style: const TextStyle(
                color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
            softWrap: true,
            textAlign: TextAlign.center));
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
