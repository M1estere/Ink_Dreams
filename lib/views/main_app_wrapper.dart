import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manga_reading/views/account_page_view.dart';
import 'package:manga_reading/views/explore_view.dart';
import 'package:manga_reading/views/search_intro_page_view.dart';
import 'package:manga_reading/views/search_results_view.dart';
import 'package:page_transition/page_transition.dart';

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
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 180,
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'EXPLORE',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
      ),
      // search intro app bar
      AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 180,
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'SEARCH',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: ClipOval(
              child: Material(
                color: Theme.of(context).primaryColor, // Button color
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
                      color: Theme.of(context).secondaryHeaderColor,
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
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 180,
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'ACCOUNT',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  letterSpacing: 0,
                ),
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
      extendBody: true,
      appBar: appbarList[_currentPageIndex],
      body: bodies,
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentPageIndex,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (value) {
          if (mounted) {
            setState(() {
              _currentPageIndex = value;
            });
          }
        },
        height: 60,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Theme.of(context).bottomAppBarTheme.color!,
        color: const Color(0xFF252525),
        items: [
          Icon(
            Icons.list,
            size: 35,
            color: _currentPageIndex == 0
                ? Theme.of(context).bottomAppBarTheme.shadowColor!
                : Colors.grey,
          ),
          Icon(
            Icons.search,
            size: 35,
            color: _currentPageIndex == 1
                ? Theme.of(context).bottomAppBarTheme.shadowColor!
                : Colors.grey,
          ),
          Icon(
            Icons.person,
            size: 35,
            color: _currentPageIndex == 2
                ? Theme.of(context).bottomAppBarTheme.shadowColor!
                : Colors.grey,
          ),
        ],
      ),
    );
  }
}
