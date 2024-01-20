import 'package:flutter/material.dart';
import 'package:manga_reading/views/account_page_view.dart';
import 'package:manga_reading/views/explore_view.dart';
import 'package:manga_reading/views/search_intro_page_view.dart';
import 'package:manga_reading/views/search_results_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stylish_bottom_bar/model/bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appbarList = [
      // explore app bar
      AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
        leadingWidth: MediaQuery.of(context).size.width * .5,
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'EXPLORE',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ),
          ],
        ),
      ),
      // search intro app bar
      AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
        leadingWidth: MediaQuery.of(context).size.width * .5,
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'SEARCH',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: ClipOval(
              child: Material(
                color: Theme.of(context)
                    .appBarTheme
                    .foregroundColor, // Button color
                child: InkWell(
                  splashColor: Colors.grey, // Splash color
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: const SearchResultsView(),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 43,
                    height: 43,
                    child: Icon(
                      Icons.search,
                      color:
                          Theme.of(context).appBarTheme.actionsIconTheme!.color,
                      size: 33,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // account app bar
      AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
        leadingWidth: MediaQuery.of(context).size.width * .5,
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'ACCOUNT',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ),
          ],
        ),
      ),
    ];

    final bodies = IndexedStack(
      index: _currentPageIndex,
      children: const [
        ExploreView(),
        SearchIntroPageView(),
        AccountPageView(),
      ],
    );

    return Scaffold(
      appBar: appbarList[_currentPageIndex],
      body: bodies,
      bottomNavigationBar: StylishBottomBar(
        hasNotch: true,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        option: AnimatedBarOptions(
          iconSize: 30,
          barAnimation: BarAnimation.liquid,
          opacity: 0.3,
        ),
        items: [
          BottomBarItem(
            icon: const Icon(Icons.home_outlined),
            title: Text(
              'Explore',
              style:
                  Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
            ),
            unSelectedColor: Colors.grey,
            selectedIcon: const Icon(Icons.home),
            selectedColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
          ),
          BottomBarItem(
            icon: const Icon(Icons.search),
            title: Text(
              'Search',
              style:
                  Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
            ),
            unSelectedColor: Colors.grey,
            selectedIcon: const Icon(Icons.search),
            selectedColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
          ),
          BottomBarItem(
            icon: const Icon(Icons.person_outline),
            title: Text(
              'Account',
              style:
                  Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
            ),
            unSelectedColor: Colors.grey,
            selectedIcon: const Icon(Icons.person),
            selectedColor:
                Theme.of(context).bottomNavigationBarTheme.selectedItemColor!,
          ),
        ],
      ),
    );
  }
}
