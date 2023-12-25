import 'package:flutter/material.dart';
import 'package:manga_reading/views/user_section_view.dart';
import 'package:page_transition/page_transition.dart';

class AccountPageView extends StatefulWidget {
  const AccountPageView({super.key});

  @override
  State<AccountPageView> createState() => _AccountPageViewState();
}

class _AccountPageViewState extends State<AccountPageView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0, .5, .5, 1],
            colors: [
              const Color(0xFF9D1515).withOpacity(.5),
              const Color(0xFF9D1515).withOpacity(.5),
              const Color(0xFF23202B),
              const Color(0xFF23202B),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .27,
                child: const Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Color.fromARGB(255, 255, 17, 0),
                        // foregroundImage:
                        //     AssetImage('assets/images/attack.jpg'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'M1estere',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      'Ilya Solovyev',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        height: .75,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 135,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(.65),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          splashColor: const Color.fromARGB(255, 34, 34, 34),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: UserSectionView(
                                  sectionName: 'favourites',
                                ),
                              ),
                            );
                          },
                          child: const SizedBox(
                            height: 135,
                            width: 160,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Favourites',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 2,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: Material(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(.65),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          splashColor: const Color.fromARGB(255, 34, 34, 34),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: UserSectionView(
                                  sectionName: 'saved',
                                ),
                              ),
                            );
                          },
                          child: const SizedBox(
                            height: 135,
                            width: 135,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.list,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Saved',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 2,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Material(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(.65),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(15),
                          splashColor: const Color.fromARGB(255, 34, 34, 34),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: UserSectionView(
                                  sectionName: 'finished',
                                ),
                              ),
                            );
                          },
                          child: const SizedBox(
                            height: 135,
                            width: 160,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Finished',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 2,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .27,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .75,
                        child: ClipRect(
                          child: Material(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.black,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(7),
                              splashColor:
                                  const Color.fromARGB(255, 34, 34, 34),
                              onTap: () {},
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Personalize',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1.5,
                                    ),
                                  ), // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * .75,
                      child: ClipRect(
                        child: Material(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.black,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(7),
                            splashColor: const Color.fromARGB(255, 34, 34, 34),
                            onTap: () {},
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Log Out',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.5,
                                  ),
                                ), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
