import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/story/component/basic_story_button.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:ar_zoo_explorers/features/storylisting/presentation/storylisting_cubit.dart';
import 'package:ar_zoo_explorers/features/storylisting/presentation/storylisting_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class StoryListingPage extends StatefulWidget {
  const StoryListingPage({super.key});

  @override
  State createState() => _State();
}

class _State
    extends BaseState<StoryListingState, StoryListingCubit, StoryListingPage> {
  @override
  Widget buildByState(BuildContext context, StoryListingState state) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
            centerTitle: true,
            title: const Text("Favorites",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            backgroundColor: const Color.fromARGB(255, 109, 189, 255),
            elevation: 1,
            automaticallyImplyLeading: false),
        body: Container(
            width: cubit.WIDTH,
            // padding: const EdgeInsets.only(left: 10, right: 10),
            constraints: BoxConstraints(minHeight: cubit.HEIGHT),
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
              child: Column(children: [
                listStoryButton(),
              ]),
            )));
  }

  Widget listStoryButton() {
    List<Widget> lstStory = [];
    for (int i = 0; i < cubit.lstStory.length; i++) {
      lstStory.add(storyButton(cubit.lstStory[i],
          isLast: (i == cubit.lstStory.length - 1) ? true : false));
    }
    return Column(children: lstStory);
  }

  Widget storyButton(StoryButtonObject item, {bool isLast = false}) {
    return ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    side: const BorderSide(
                        color: Colors.transparent, width: 0.0)))),
        onPressed: () {
          context.router.pushNamed(Routes.storyoverview);
        },
        child: Column(children: [
          BasicStoryButton(item: item),
          isLast
              ? Container()
              : Container(
                  width: cubit.WIDTH * 0.9,
                  height: 0.5,
                  color: Colors.grey.shade500)
        ]));
  }

  void _setDimension() {
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

    // controller.getCurrentUser(context);
    _setDimension();
  }
}
