import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/story/component/listening_story_button.dart';
import 'package:ar_zoo_explorers/features/story/listening/presentation/listening_cubit.dart';
import 'package:ar_zoo_explorers/features/story/listening/presentation/listening_state.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ListeningPage extends StatefulWidget {
  const ListeningPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<ListeningState, ListeningCubit, ListeningPage> {
  @override
  Widget buildByState(BuildContext context, ListeningState state) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
            centerTitle: true,
            title: const Text("Listening",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            backgroundColor: const Color.fromARGB(255, 109, 189, 255),
            elevation: 1,
            automaticallyImplyLeading: false),
        body: Container(
            width: cubit.WIDTH,
            padding: const EdgeInsets.only(left: 10, right: 10),
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
    lstStory.add(SizedBox(width: cubit.WIDTH, height: 15));
    for (int i = 0; i < cubit.listStory.length; i++) {
      lstStory.add(storyButton(cubit.listStory[i]));
      (i == cubit.listStory.length - 1)
          ? lstStory.add(SizedBox(width: cubit.WIDTH, height: 15))
          : lstStory.add(SizedBox(width: cubit.WIDTH, height: 15));
    }
    return Column(children: lstStory);
  }

  Widget storyButton(StoryButtonObject item) {
    return ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    side: const BorderSide(
                        color: Colors.transparent, width: 0.0))),
            elevation: MaterialStateProperty.all<double>(5), // Set elevation
            shadowColor: MaterialStateProperty.all<Color?>(
                Colors.blue.withOpacity(1))), // Set shadow color
        onPressed: () {
          // print(item.name);
        },
        child: Column(children: [
          ListeningStoryButton(item: item),
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
