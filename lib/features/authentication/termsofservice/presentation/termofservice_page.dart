import 'package:ar_zoo_explorers/features/authentication/termsofservice/presentation/termofservice_cubit.dart';
import 'package:ar_zoo_explorers/features/authentication/termsofservice/presentation/termofservice_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/icons.dart';
import '../../../../base/base_state.dart';

@RoutePage()
class TermOfServicePage extends StatefulWidget {
  const TermOfServicePage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<TermOfServiceState, TermOfServiceCubit,
    TermOfServicePage> {
  @override
  Widget buildByState(BuildContext context, TermOfServiceState state) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black.withOpacity(0),
            title: const Text("Terms Of Service",
                style: TextStyle(fontSize: 20, color: Colors.white)),
            leading: const Column(children: [])),
        body: Stack(children: [
          ClipRect(
              child: Image.asset(AppImages.imgAppLogoBG,
                  width: cubit.WIDTH, height: cubit.HEIGHT, fit: BoxFit.cover)),
          Container(
              width: cubit.WIDTH,
              height: cubit.HEIGHT,
              color: Colors.black.withOpacity(0.2)),
          SingleChildScrollView(
              child: Center(
                  child: Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 25),
                      child: Column(children: [
                        SizedBox(height: cubit.HEIGHT * 0.13),
                        listTermsOfService(),
                        const SizedBox(height: 5),
                        submitButton()
                      ]))))
        ]));
  }

  Widget listTermsOfService() {
    return Container(
      padding: const EdgeInsets.all(10),
      width: cubit.WIDTH * 0.85,
      height: cubit.WIDTH * 1.2,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(15.0)),
      child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Align(
            alignment: Alignment.center,
            child: Transform.scale(
                scale: 1.5,
                child: Image.asset(AppImages.imgAppLogo, height: 200))),
        const SizedBox(height: 12),
        loadListTerm(),
      ])),
    );
  }

  Widget loadListTerm() {
    List<Widget> listTerm = [];
    for (int i = 0; i < cubit.listTerm.length; i++) {
      listTerm
          .add(termItem(cubit.listTerm[i].title, cubit.listTerm[i].content));
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: listTerm);
  }

  Widget termItem(String termTitle, String termContent) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const SizedBox(height: 8),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(termTitle,
            style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
      ]),
      const SizedBox(height: 6),
      Text(termContent,
          style: const TextStyle(fontSize: 14, color: Colors.black))
    ]);
  }

  Widget submitButton() {
    return Container(
        width: cubit.WIDTH * 0.5,
        height: cubit.WIDTH * 0.2,
        padding: const EdgeInsets.all(15),
        child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
                minimumSize: const Size(140, 50),
                backgroundColor: const Color.fromARGB(255, 248, 133, 18),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Back",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ])));
  }

  void setDimension() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        cubit.WIDTH = MediaQuery.of(context).size.width;
        cubit.HEIGHT = MediaQuery.of(context).size.height;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setDimension();
  }
}
