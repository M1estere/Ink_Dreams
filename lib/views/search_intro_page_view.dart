import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manga_reading/views/search_results_view.dart';
import 'package:page_transition/page_transition.dart';

class SearchIntroPageView extends StatefulWidget {
  const SearchIntroPageView({super.key});

  @override
  State<SearchIntroPageView> createState() => _SearchIntroPageViewState();
}

class _SearchIntroPageViewState extends State<SearchIntroPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  onTap: () {},
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
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Popular',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: 360,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 185,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 280,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/attack.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Text(
                            'Attack On Titan',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.5),
                          ),
                          Text(
                            '2023',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.5),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 185,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 280,
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/attack.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Text(
                            'Attack On Titan',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.5),
                          ),
                          Text(
                            '2023',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.5),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 185,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 280,
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/attack.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Text(
                            'Attack On Titan',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.5),
                          ),
                          Text(
                            '2023',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Hottest',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: 360,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 185,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 280,
                            margin: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/attack.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Text(
                            'Attack On Titan',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.5),
                          ),
                          Text(
                            '2023',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.5),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 185,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 280,
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/attack.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Text(
                            'Attack On Titan',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.5),
                          ),
                          Text(
                            '2023',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.5),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 185,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 280,
                            margin: EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/attack.jpg'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Text(
                            'Attack On Titan',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.5),
                          ),
                          Text(
                            '2023',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Best Authors',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: SizedBox(
                        width: 150,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.zero,
                              child: const CircleAvatar(
                                radius: 75,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  foregroundImage:
                                      AssetImage('assets/images/attack.jpg'),
                                  radius: 65,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              'Hidetaka Babadzaki',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: SizedBox(
                        width: 150,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.zero,
                              child: const CircleAvatar(
                                radius: 75,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  foregroundImage:
                                      AssetImage('assets/images/attack.jpg'),
                                  radius: 65,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              'Hidetaka Babadzaki',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: SizedBox(
                        width: 150,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.zero,
                              child: const CircleAvatar(
                                radius: 75,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  foregroundImage:
                                      AssetImage('assets/images/attack.jpg'),
                                  radius: 65,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              'Hidetaka Babadzaki',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        animationDuration: Duration(milliseconds: 300),
        onTap: (value) {
          print('Nav bar $value clicked');
        },
        height: 60,
        backgroundColor: Color(0x00ffffff),
        buttonBackgroundColor: Colors.white,
        color: Color.fromARGB(255, 66, 61, 80),
        items: [
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
