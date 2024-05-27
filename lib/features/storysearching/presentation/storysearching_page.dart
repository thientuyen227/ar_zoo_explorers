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
                  await _onSearch(value);
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
    if (state.listSearchStory.isNotEmpty) {
      return GridView.builder(
        shrinkWrap: true,
        itemCount: state.listSearchStory.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [storyButton(state.listSearchStory[index])],
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, childAspectRatio: 2.32, crossAxisSpacing: 0),
      );
    } else if (state.searchStatus) {
      return Container(
          width: state.width * 0.9,
          height: state.height,
          alignment: Alignment.center,
          child: Text(
              '${LanguageKeys.msg_no_story_has.tr} "${state.txtSearch}"',
              style: const TextStyle(fontSize: 20)));
    } else {
      return Container();
    }
  }

  Widget storyButton(StoryButtonObject item, {bool isLast = false}) {
    return GestureDetector(
        onTap: () async {
          await _onClickButton(context, item.id!);
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(state.width * 0.04),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 3))
              ]),
          width: state.width * 0.9,
          child: BasicStoryButton(item: item),
        ));
  }

  Future<void> _onSearch(String? value) async {
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
                await _onSearch(value);
              }
            });
          },
        );
      }
    });
  }

  Future<void> _onClickButton(BuildContext context, String itemId) async {
    await _onChangeBottomBarState();
    cubit.showLoading();
    await cubit.getStory(context, itemId);
    await cubit.createOrGetUserStory(context, itemId);
    await _navigateToOverviewPage();
    await _onChangeBottomBarState();
    cubit.hideLoading();
  }

  Future<void> _onChangeBottomBarState() async {
    setState(() {
      widget.toggleBottomBarVisibility();
    });
  }

  Future<void> _initCubit() async {
    await cubit.init(context);
    await _onChangeBottomBarState();
    _setSearchStatus();
  }

  @override
  void initState() {
    super.initState();
    _initCubit();
  }
}
