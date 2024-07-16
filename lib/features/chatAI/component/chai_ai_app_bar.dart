import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:flutter/material.dart';

class ChatAIAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ChatAIAppBar({super.key});

  @override
  _ChatAIAppBarState createState() => _ChatAIAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(MediaQueryData.fromView(
              WidgetsBinding.instance.platformDispatcher.views.single)
          .size
          .height *
      0.1);
}

class _ChatAIAppBarState extends State<ChatAIAppBar> {
  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 1,
        // centerTitle: true,
        title: Row(
          children: [
            avatarAppBar(),
            const SizedBox(width: 10),
            const Text("Ar Baby",
                style: TextStyle(
                    fontSize: 22,
                    color: AppColor.white,
                    fontWeight: FontWeight.w800))
          ],
        ),
        toolbarHeight: height * 0.1,
        backgroundColor: Colors.grey.shade400.withOpacity(0.1),
        leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [turnBack()]),
        actions: const []);
  }

  Widget turnBack() {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop(true);
      },
      icon: Icon(
        Icons.keyboard_arrow_left,
        size: height * 0.05,
        color: AppColor.white,
      ),
    );
  }

  Widget avatarAppBar() {
    return Stack(children: [
      SizedBox(height: height * 0.07, width: height * 0.07),
      avatar(),
      Positioned(bottom: 0, right: 0, child: activeStatus()),
    ]);
  }

  Widget avatar() {
    return Container(
      height: height * 0.07,
      width: height * 0.07,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppColor.primaryColor),
          shape: BoxShape.circle,
          color: Colors.white),
      child: ClipOval(
          child: Image.asset(
        AppImages.imgArBaby,
        fit: BoxFit.cover,
      )),
    );
  }

  Widget activeStatus() {
    return Container(
      height: height * 0.018,
      width: height * 0.018,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.green.shade500),
    );
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
