import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/story/component/basic_story_button.dart';
import 'package:ar_zoo_explorers/features/story/component/search_bottom_sheet.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
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
              ]),
            )));
  }

  Widget searchButton() {
    return IconButton(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SearchBottomSheet(onClosed: (String value) {
                setState(() {
                  cubit.txtSearch = value;
                });
              });
            },
          );
          await onSearch(cubit.txtSearch);
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
        onPressed: () {
          // print(item.name);
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
    // await animalController.setSearchValue(
    //     context, _formKey.currentState!.fields['search']?.value);
    setState(() {
      cubit.onSearch(value ?? "");
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
    _setDimension();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SearchBottomSheet(onClosed: (String value) {
            setState(() {
              cubit.txtSearch = value;
            });
          });
        },
      );
    });
  }
}
