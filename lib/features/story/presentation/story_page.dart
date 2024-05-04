import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/story/presentation/story_cubit.dart';
import 'package:ar_zoo_explorers/features/story/presentation/story_state.dart';
import 'package:ar_zoo_explorers/features/storyfavorite/presentation/storyfavorite_page.dart';
import 'package:ar_zoo_explorers/features/storyhome/presentation/storyhome_page.dart';
import 'package:ar_zoo_explorers/features/storylistening/presentation/storylistening_page.dart';
import 'package:ar_zoo_explorers/features/storysearching/presentation/storysearching_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<StoryState, StoryCubit, StoryPage> {
  final PageController _pageController = PageController();

  late List<Widget> _pages;

  @override
  Widget buildByState(BuildContext context, StoryState state) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  children: _pages,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            items: [
              for (var index = 0; index < cubit.lstBottomItem.length; index++)
                BottomNavigationBarItem(
                    icon: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            cubit.selectedIndex == index
                                ? Colors.blue
                                : Colors.grey,
                            BlendMode.srcIn),
                        child: Image.asset(cubit.lstBottomItem[index]['url']!,
                            height: 16, width: 16)),
                    label: cubit.lstBottomItem[index]['name']!),
            ],
            currentIndex: cubit.selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: _onItemTapped));
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
    // print("_onItemTapped $index");
  }

  void _onPageChanged(int index) {
    setState(() {
      cubit.selectedIndex = index;
    });
    // print("_onPageChanged $index");
  }

  void _onJump(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      cubit.selectedIndex = index;
    });
    // print("_onPageChanged $index");
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      StoryHomePage(onPageChanged: _onJump),
      const StoryFavoritePage(),
      const StorySearchingPage(),
      const StoryListeningPage(),
    ];
  }
}
