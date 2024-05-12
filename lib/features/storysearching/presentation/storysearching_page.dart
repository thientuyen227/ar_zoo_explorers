import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/story_topic_controller.dart';
import 'package:ar_zoo_explorers/core/data/controller/user_story_controller.dart';
import 'package:ar_zoo_explorers/features/story/component/basic_story_button.dart';
import 'package:ar_zoo_explorers/features/story/component/search_bottom_sheet.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:ar_zoo_explorers/features/storyoverview/presentation/storyoverview_page.dart';
import 'package:ar_zoo_explorers/features/storysearching/presentation/storysearching_cubit.dart';
import 'package:ar_zoo_explorers/features/storysearching/presentation/storysearching_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class StorySearchingPage extends StatefulWidget {
  const StorySearchingPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<StorySearchingState, StorySearchingCubit,
    StorySearchingPage> {
  final controller = AuthController.findOrInitialize;
  final storyTopicController = StoryTopicController.findOrInitialize;
  final userStoryController = UserStoryController.findOrInitialize;
  final storyController = StoryController.findOrInitialize;

  @override
  Widget buildByState(BuildContext context, StorySearchingState state) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
            centerTitle: true,
            title: const Text("Search",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            backgroundColor: const Color.fromARGB(255, 109, 189, 255),
            elevation: 1,
            automaticallyImplyLeading: false,
            actions: [searchButton()]),
        body: Container(
            width: cubit.WIDTH,
            // padding: const EdgeInsets.only(left: 10, right: 10),
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

  Widget searchButton() {
    return IconButton(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SearchBottomSheet(onClosed: (String? value) async {
                if (value != null) {
                  setState(() {
                    cubit.txtSearch = value;
                  });
                  await onSearch(cubit.txtSearch);
                }
              });
            },
          );
        },
        icon: ColorFiltered(
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            child: ClipRRect(
                child: Image.asset(AppIcons.icMagnifyingGlass64,
                    height: 24, width: 24))));
  }

  Widget listStoryButton() {
    List<Widget> lstStory = [];

    for (int i = 0; i < cubit.listSearchStory.length; i++) {
      lstStory.add(storyButton(cubit.listSearchStory[i],
          isLast: (i == cubit.listSearchStory.length - 1) ? true : false));
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
        onPressed: () async {
          await _navigateToOverviewPage();
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

  Future<void> onSearch(String? value) async {
    await storyController.updateSearching(context, text: value ?? "");
    setState(() {
      cubit.onSearch(value ?? "");
    });
  }

  Future<void> _getAllStories(BuildContext context) async {
    await storyController.getAllStories(context);
    await storyTopicController.getAllStoryTopics(context);
    if (mounted) {
      setState(() {
        cubit.getAllStories(
            storyController.listStory.value,
            storyTopicController.listStoryTopic.value,
            storyController.searchStatus.value);
      });
    }
  }

  void _setDimension() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        cubit.WIDTH = MediaQuery.of(context).size.width;
        cubit.HEIGHT = MediaQuery.of(context).size.height;
      });
    });
  }

  Future<void> _navigateToOverviewPage() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StoryOverviewPage(onClosed: (String value) async {
          await _getAllStories(context);
          await _setSearchStatus();
        }),
      ),
    );
  }

  Future<void> _setSearchStatus() async {
    setState(() {
      cubit.txtSearch = storyController.txtSearch.value;
      cubit.searchStatus = storyController.searchStatus.value;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (cubit.searchStatus == false) {
        await showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SearchBottomSheet(onClosed: (String? value) async {
              if (value != null) {
                if (mounted) {
                  setState(() {
                    cubit.txtSearch = value;
                  });
                  await onSearch(cubit.txtSearch);
                }
              }
            });
          },
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _setDimension();
    _getAllStories(context);
    _setSearchStatus();
  }
}
