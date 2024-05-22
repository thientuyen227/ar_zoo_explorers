import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
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
import 'package:get/get.dart';

@RoutePage()
class StorySearchingPage extends StatefulWidget {
  final VoidCallback toggleBottomBarVisibility;

  const StorySearchingPage(
      {super.key, required this.toggleBottomBarVisibility});

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
            title: Text(LanguageKeys.search.tr.toUpperCase(),
                style: const TextStyle(
                    fontSize: 20,
                    color: AppColor.white,
                    fontWeight: FontWeight.bold)),
            backgroundColor: AppColor.appBarColor,
            elevation: 1,
            automaticallyImplyLeading: false,
            actions: [searchButton()]),
        body: Container(
            width: state.width,
            // padding: const EdgeInsets.only(left: 10, right: 10),
            constraints: BoxConstraints(minHeight: state.height),
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
              child: Column(children: [
                listStoryButton(),
                SizedBox(height: state.height * 0.05),
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
                  await onSearch(value);
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

    for (int i = 0; i < state.listSearchStory.length; i++) {
      lstStory.add(storyButton(state.listSearchStory[i],
          isLast: (i == state.listSearchStory.length - 1) ? true : false));
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
          await storyController.getStory(context, id: item.id!);
          await userStoryController.createOrGetUserStory(context,
              userId: controller.currentUser.value.id, storyId: item.id!);
          await _navigateToOverviewPage();
        },
        child: Column(children: [
          BasicStoryButton(item: item),
          isLast
              ? Container()
              : Container(
                  width: state.width * 0.9,
                  height: 0.5,
                  color: Colors.grey.shade500)
        ]));
  }

  Future<void> onSearch(String? value) async {
    await cubit.onSearch(context, value ?? "").then((value) => setState(() {}));
  }

  Future<void> _navigateToOverviewPage() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StoryOverviewPage(onClosed: (String value) async {
          await cubit.init(context).then((value) => setState(() {}));
          await _setSearchStatus();
        }),
      ),
    );
  }

  Future<void> _setSearchStatus() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (state.searchStatus == false) {
        await showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return SearchBottomSheet(onClosed: (String? value) async {
              if (value != null) {
                await onSearch(value);
              }
            });
          },
        );
      }
    });
  }

  Future<void> _initCubit() async {
    await cubit.init(context);
    setState(() {
      widget.toggleBottomBarVisibility();
    });
    _setSearchStatus();
  }

  @override
  void initState() {
    super.initState();
    _initCubit();
  }
}
