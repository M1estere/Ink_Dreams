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
        leading: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'EXPLORE',
                style: TextStyle(
                  color: Colors.white,
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
        leading: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'SEARCH',
                style: TextStyle(
                  color: Colors.white,
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
                color: Colors.white, // Button color
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
                  child: const SizedBox(
                    width: 43,
                    height: 43,
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
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
        leading: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'ACCOUNT',
                style: TextStyle(
                  color: Colors.white,
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
      appBar: appbarList[_currentPageIndex],
      body: bodies,
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentPageIndex,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (value) {
          setState(() {
            _currentPageIndex = value;
          });
        },
        height: 60,
        backgroundColor: const Color(0xFF121212),
        buttonBackgroundColor: Colors.white,
        color: const Color(0xFF252525),
        items: [
          Icon(
            Icons.list,
            size: 35,
            color: _currentPageIndex == 0 ? Colors.black : Colors.grey,
          ),
          Icon(
            Icons.search,
            size: 35,
            color: _currentPageIndex == 1 ? Colors.black : Colors.grey,
          ),
          Icon(
            Icons.person,
            size: 35,
            color: _currentPageIndex == 2 ? Colors.black : Colors.grey,
          ),
        ],
      ),
    );
  }
}
