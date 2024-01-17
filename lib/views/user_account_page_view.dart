import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manga_reading/support/auth_provider.dart';
import 'package:manga_reading/support/classes/manga_book.dart';
import 'package:manga_reading/support/classes/manga_book_timed.dart';
import 'package:manga_reading/support/user_actions.dart';
import 'package:manga_reading/views/auth_page_view.dart';
import 'package:manga_reading/views/blocks/category_block.dart';
import 'package:manga_reading/views/blocks/category_result_block.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';
import 'package:manga_reading/views/support/no_books_by_request.dart';
import 'package:manga_reading/views/user_friends_view.dart';
import 'package:manga_reading/views/user_section_view.dart';
import 'package:page_transition/page_transition.dart';

class UserAccountPageView extends StatefulWidget {
  final String id;
  const UserAccountPageView({
    super.key,
    required this.id,
  });

  @override
  State<UserAccountPageView> createState() => _UserAccountPageViewState();
}

class _UserAccountPageViewState extends State<UserAccountPageView> {
  List<MangaBookTimed> mangaBooks = [];

  UserFull pageUser = UserFull(
    id: '',
    email: '',
    nickname: '',
    registerDate: Timestamp.fromDate(DateTime.now()),
    friends: 0,
  );
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getFullUserInfo(widget.id).then((value) {
      setState(() {
        pageUser = value;
      });

      getMangaByUserSection(widget.id, 'finished').then((value) {
        setState(() {
          mangaBooks = value;
          isLoading = false;
        });
      });
    });
  }

  refresh() {
    setState(() {
      isLoading = true;
    });

    getFullUserInfo(widget.id).then((value) {
      setState(() {
        pageUser = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .07,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: MediaQuery.of(context).size.width * .7,
        leading: Container(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              Text(
                'm1estere'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, .42, .42, 1],
              colors: [
                const Color.fromARGB(255, 157, 21, 134).withOpacity(.5),
                const Color.fromARGB(255, 157, 21, 134).withOpacity(.5),
                const Color(0xFF23202B),
                const Color(0xFF23202B),
              ],
            ),
          ),
          child: !isLoading
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .26,
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.red,
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
                            Text(
                              'Since: ${DateFormat('dd/MM/yyyy').format(pageUser.registerDate.toDate())}',
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
                                      PageTransition(
                                        type: PageTransitionType
                                            .rightToLeftWithFade,
                                        child: UserSectionView(
                                          id: widget.id,
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
                                  splashColor:
                                      const Color.fromARGB(255, 34, 34, 34),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType
                                            .rightToLeftWithFade,
                                        child: UserSectionView(
                                          id: widget.id,
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
                                  splashColor:
                                      const Color.fromARGB(255, 34, 34, 34),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType
                                            .rightToLeftWithFade,
                                        child: UserSectionView(
                                          id: widget.id,
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
                        height: MediaQuery.of(context).size.height * .4,
                        child: mangaBooks.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Finished',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemBuilder: (context, index) {
                                        return CategoryResultBlock(
                                          title: mangaBooks[index].title!,
                                          chapters: mangaBooks[index].chapters!,
                                          status: mangaBooks[index].status!,
                                          author: mangaBooks[index].author!,
                                          image: mangaBooks[index].image!,
                                        );
                                      },
                                      itemCount: mangaBooks.length,
                                    ),
                                  ),
                                ],
                              )
                            : const NoBooksByRequest(),
                      ),
                    ],
                  ),
                )
              : const FetchingCircle(),
        ),
      ),
    );
  }
}
