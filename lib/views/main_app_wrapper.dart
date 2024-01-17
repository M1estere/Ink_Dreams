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
        toolbarHeight: 60,
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
                  fontSize: 30,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _currentPageIndex = 2;
                });
              },
              child: const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black,
                foregroundImage: AssetImage('assets/images/attack.jpg'),
              ),
            ),
          ),
        ],
      ),
      // search intro app bar
      AppBar(
        toolbarHeight: 60,
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
                  fontSize: 30,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: const SearchResultsView(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentPageIndex = 2;
                    });
                  },
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black,
                    foregroundImage: AssetImage('assets/images/attack.jpg'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // account app bar
      AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        toolbarHeight: 60,
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
                  fontSize: 30,
                  letterSpacing: 2,
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
        animationDuration: Duration(milliseconds: 300),
        onTap: (value) {
          setState(() {
            _currentPageIndex = value;
          });
        },
        height: 60,
        backgroundColor: const Color(0xFF23202B),
        buttonBackgroundColor: Colors.white,
        color: const Color.fromARGB(255, 66, 61, 80),
        items: const [
          Icon(
            Icons.list,
            size: 35,
            color: Colors.black,
          ),
          Icon(
            Icons.search,
            size: 35,
            color: Colors.black,
          ),
          Icon(
            Icons.person,
            size: 35,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
