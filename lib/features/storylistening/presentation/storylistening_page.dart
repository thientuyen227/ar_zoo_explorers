import 'package:ar_zoo_explorers/app/languages/language_key.dart';
import 'package:ar_zoo_explorers/app/theme/colors.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/story/component/listening_story_button.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:ar_zoo_explorers/features/storylistening/presentation/storylistening_cubit.dart';
import 'package:ar_zoo_explorers/features/storylistening/presentation/storylistening_state.dart';
import 'package:ar_zoo_explorers/features/storyoverview/presentation/storyoverview_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

@RoutePage()
class StoryListeningPage extends StatefulWidget {
  final VoidCallback toggleBottomBarVisibility;
  const StoryListeningPage(
      {super.key, required this.toggleBottomBarVisibility});

  @override
  State createState() => _State();
}

class _State extends BaseState<StoryListeningState, StoryListeningCubit,
    StoryListeningPage> {
  @override
  Widget buildByState(BuildContext context, StoryListeningState state) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
            centerTitle: true,
            title: Text(LanguageKeys.listening.tr.toUpperCase(),
                style: const TextStyle(
                    fontSize: 20,
                    color: AppColor.white,
                    fontWeight: FontWeight.bold)),
            backgroundColor: AppColor.appBarColor,
            elevation: 1,
            automaticallyImplyLeading: false),
        body: Container(
            width: state.width,
            color: Colors.grey.shade50,
            // padding: const EdgeInsets.only(left: 20, right: 20),
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

  Widget listStoryButton() {
    if (state.listStory.isNotEmpty) {
      return GridView.builder(
        shrinkWrap: true,
        itemCount: state.listStory.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [storyButton(state.listStory[index])],
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, childAspectRatio: 2.3, crossAxisSpacing: 0),
      );
    } else {
      return Container(
          width: state.width * 0.9,
          height: state.height,
          alignment: Alignment.center,
          child: Text(LanguageKeys.empty_favorite_stories.tr,
              style: const TextStyle(fontSize: 20)));
    }
  }

  Widget storyButton(StoryButtonObject item) {
    return GestureDetector(
        onTap: () async {
          cubit.showLoading();
          await _onChangeBottomBarState();
          await cubit.setCurrentStory(context, item.id!);
          await _navigateToOverviewPage();
          await _onChangeBottomBarState();
          cubit.hideLoading();
        },
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(state.width * 0.04),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: const Offset(0, 3))
              ]),
          width: state.width,
          child: ListeningStoryButton(item: item),
        ));
  }

  Future<void> _navigateToOverviewPage() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StoryOverviewPage(onClosed: (String value) async {
          await cubit.init(context).then((value) => setState(() {}));
        }),
      ),
    );
  }

  Future<void> _onChangeBottomBarState() async {
    setState(() {
      widget.toggleBottomBarVisibility();
    });
  }

  Future<void> _initCubit() async {
    await cubit.init(context);
    await _onChangeBottomBarState();
  }

  @override
  void initState() {
    super.initState();
    _initCubit();
    // controller.getCurrentUser(context);
  }
}
