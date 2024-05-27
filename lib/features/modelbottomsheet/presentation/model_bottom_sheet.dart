import 'package:flutter/material.dart';

class ModelBottomSheet extends StatefulWidget {
  const ModelBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  _ModelBottomSheetState createState() => _ModelBottomSheetState();
}

class _ModelBottomSheetState extends State<ModelBottomSheet> {
  double width = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: width,
        height: height * 0.3,
        decoration: BoxDecoration(
          color: Colors.blue.shade200,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(height * 0.025),
            topRight: Radius.circular(height * 0.025),
          ),
        ),
        child: Column(children: [
          SizedBox(
            width: width,
            height: height * 0.075,
          ),
          const Text('Hello')
        ]),
      ),
      topSection()
    ]);
  }

  Widget topSection() {
    return Container(
        width: width,
        height: height * 0.075,
        decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(height * 0.025),
              topRight: Radius.circular(height * 0.025),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 4))
            ]),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
              height: height * 0.01,
              width: width * 0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height * 0.005),
                  color: Colors.grey)),
          Text("Select your favorite model",
              style: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 22,
                  fontWeight: FontWeight.w700))
        ]));
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
