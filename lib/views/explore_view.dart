import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreView();
}

class _ExploreView extends State<ExploreView> {
  final PageController _controller = PageController(viewportFraction: .95);
  final PageController _globalController = PageController();
  int _currentGlobalIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                print('Ava Clicked');
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
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          print('Categories Chosen');
                          _currentGlobalIndex = 0;
                          _globalController.jumpToPage(_currentGlobalIndex);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 2,
                              color: _currentGlobalIndex == 0
                                  ? Color(0xFF9D1515)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        child: const Text(
                          'MAIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          print('Categories Chosen');
                          _currentGlobalIndex = 1;
                          _globalController.jumpToPage(_currentGlobalIndex);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 2,
                              color: _currentGlobalIndex == 1
                                  ? Color(0xFF9D1515)
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                        child: const Text(
                          'CATEGORIES',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .75,
                  child: PageView(
                    allowImplicitScrolling: false,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (value) {
                      print(value);
                    },
                    controller: _globalController,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * .65,
                              child: PageView.builder(
                                padEnds: false,
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                controller: _controller,
                                itemBuilder: (context, index) {
                                  return ListenableBuilder(
                                    listenable: _controller,
                                    builder: (context, child) {
                                      double factor = 1;
                                      if (_controller
                                          .position.hasContentDimensions) {
                                        factor = 1 -
                                            (_controller.page! - index).abs();
                                      }

                                      return _buildItem(context, factor);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Attack On Titan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.5,
                                ),
                              ),
                              Text(
                                'Hajime Isayama',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 2.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // categories section
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .65,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: [
                              SizedBox(
                                height: 200,
                                child: GestureDetector(
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 25),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/attack.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(.75),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Shonen',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 200,
                                child: GestureDetector(
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 25),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/attack.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(.75),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Shonen',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        animationDuration: Duration(milliseconds: 300),
        onTap: (value) {
          print('Nav bar $value clicked');
        },
        height: 60,
        backgroundColor: const Color(0xFF23202B),
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

  Widget _buildItem(BuildContext context, double factor) {
    return Center(
      child: SizedBox(
        height: 500 + (factor * 75),
        width: 400,
        child: Container(
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: const DecorationImage(
              image: AssetImage('assets/images/attack.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
