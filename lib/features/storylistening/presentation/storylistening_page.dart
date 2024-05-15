import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_topic_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/user_story_controller.dart';
import 'package:ar_zoo_explorers/features/story/component/listening_story_button.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:ar_zoo_explorers/features/storylistening/presentation/storylistening_cubit.dart';
import 'package:ar_zoo_explorers/features/storylistening/presentation/storylistening_state.dart';
import 'package:ar_zoo_explorers/features/storyoverview/presentation/storyoverview_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class StoryListeningPage extends StatefulWidget {
  const StoryListeningPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<StoryListeningState, StoryListeningCubit,
    StoryListeningPage> {
  final controller = AuthController.findOrInitialize;
  final storyTopicController = StoryTopicController.findOrInitialize;
  final userStoryController = UserStoryController.findOrInitialize;
  final storyController = StoryController.findOrInitialize;
  @override
  Widget buildByState(BuildContext context, StoryListeningState state) {
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
            color: Colors.grey.shade50,
            // padding: const EdgeInsets.only(left: 20, right: 20),
            constraints: BoxConstraints(minHeight: cubit.HEIGHT),
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
              child: Column(children: [
                listStoryButton(),
                SizedBox(height: cubit.HEIGHT * 0.05),
              ]),
            )));
  }

  Widget listStoryButton() {
    List<Widget> lstStory = [];
    lstStory.add(SizedBox(width: cubit.WIDTH, height: 15));
    for (int i = 0; i < cubit.listStory.length; i++) {
      lstStory.add(storyButton(cubit.listStory[i]));
    }
    return Column(children: lstStory);
  }

  Widget storyButton(StoryButtonObject item) {
    return GestureDetector(
        onTap: () async {
          await _setCurrentStory(item.id!, controller.currentUser.value.id);
          await _navigateToOverviewPage();
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(0, 3))
          ]),
          width: cubit.WIDTH * 0.9,
          child: ListeningStoryButton(item: item),
        ));
  }

  Future<void> _getUserStory() async {
    await userStoryController.getUserStoryByUser(context,
        userId: controller.currentUser.value.id);
  }

  Future<void> _setCurrentStory(String storyId, String userId) async {
    await storyController.getStory(context, id: storyId);
    await userStoryController.createOrGetUserStory(context,
        userId: controller.currentUser.value.id, storyId: storyId);
  }

  Future<void> _navigateToOverviewPage() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StoryOverviewPage(onClosed: (String value) async {
          _setInformations();
        }),
      ),
    );
  }

  void _setInformations() async {
    await _getUserStory();
    setState(() {
      cubit.setInformations(
        storyController.listStory.value,
        userStoryController.listUserStory.value,
        storyTopicController.listStoryTopic.value,
      );
    });
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
    _setInformations();
  }
}
