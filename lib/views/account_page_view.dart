import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manga_reading/support/auth_provider.dart';
import 'package:manga_reading/support/classes/user_full.dart';
import 'package:manga_reading/views/auth_page_view.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';
import 'package:manga_reading/views/user_friends_view.dart';
import 'package:manga_reading/views/user_section_view.dart';

class AccountPageView extends StatefulWidget {
  const AccountPageView({
    super.key,
  });

  @override
  State<AccountPageView> createState() => _AccountPageViewState();
}

class _AccountPageViewState extends State<AccountPageView> {
  UserFull pageUser = UserFull(
    id: '',
    email: '',
    nickname: '',
    registerDate: Timestamp.fromDate(DateTime.now()),
    friends: 0,
    imagePath: '',
  );
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getFullUserInfo(currentUser!.id).then((value) {
      if (mounted) {
        setState(() {
          pageUser = value;
          isLoading = false;
        });
      }
    });
  }

  refresh() {
    if (mounted) {
      setState(() {
        isLoading = true;
      });

      getFullUserInfo(currentUser!.id).then((value) {
        if (mounted) {
          setState(() {
            pageUser = value;
            isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        refresh();
      },
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * .8,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(1),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, .5, .5, 1],
                  colors: [
                    Colors.red.withOpacity(.5),
                    const Color(0xFFF3756C).withOpacity(.5),
                    Theme.of(context).scaffoldBackgroundColor,
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: !isLoading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .27,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.red,
                                    backgroundImage: Image.network(
                                      pageUser.imagePath,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return const Center(
                                            child: SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ).image,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  pageUser.nickname,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.app_registration,
                                      size: 25,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      DateFormat('dd/MM/yyyy').format(
                                          pageUser.registerDate.toDate()),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                        height: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .15,
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
                                      splashColor:
                                          const Color.fromARGB(255, 34, 34, 34),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const UserFriendsView(),
                                          ),
                                        ).then((value) => refresh());
                                      },
                                      child: SizedBox(
                                        height: 135,
                                        width: 160,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    Icons.person,
                                                    color: Colors.white,
                                                    size: 50,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${pageUser.friends} Friends',
                                                    style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                      splashColor:
                                          const Color.fromARGB(255, 34, 34, 34),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserSectionView(
                                              id: currentUser!.id,
                                              userName: pageUser.nickname,
                                              sectionName: 'reading',
                                            ),
                                          ),
                                        );
                                      },
                                      child: const SizedBox(
                                        height: 135,
                                        width: 140,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    Icons.list,
                                                    color: Colors.white,
                                                    size: 50,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Reading',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                      splashColor:
                                          const Color.fromARGB(255, 34, 34, 34),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserSectionView(
                                              id: currentUser!.id,
                                              userName: pageUser.nickname,
                                              sectionName: 'favourites',
                                            ),
                                          ),
                                        );
                                      },
                                      child: const SizedBox(
                                        height: 135,
                                        width: 180,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    Icons.favorite,
                                                    color: Colors.white,
                                                    size: 50,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Favourites',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                      splashColor:
                                          const Color.fromARGB(255, 34, 34, 34),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserSectionView(
                                              id: currentUser!.id,
                                              userName: pageUser.nickname,
                                              sectionName: 'planned',
                                            ),
                                          ),
                                        );
                                      },
                                      child: const SizedBox(
                                        height: 135,
                                        width: 145,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    Icons.save,
                                                    color: Colors.white,
                                                    size: 50,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Planned',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                      splashColor:
                                          const Color.fromARGB(255, 34, 34, 34),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserSectionView(
                                              id: currentUser!.id,
                                              userName: pageUser.nickname,
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    Icons.timer,
                                                    color: Colors.white,
                                                    size: 50,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Finished',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                SizedBox(
                                  height: 45,
                                  width:
                                      MediaQuery.of(context).size.width * .75,
                                  child: ClipRect(
                                    child: Material(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.red,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(7),
                                        splashColor: const Color.fromARGB(
                                            255, 34, 34, 34),
                                        onTap: () {
                                          signOut().then((value) {
                                            if (value == 0) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: ((context) {
                                                    return const AuthPageView();
                                                  }),
                                                ),
                                              );
                                            } else {
                                              print('No user');
                                            }
                                          });
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Log Out'.toUpperCase(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
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
                      )
                    : const FetchingCircle(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
