import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manga_reading/support/auth_provider.dart';
import 'package:manga_reading/support/classes/rated_manga.dart';
import 'package:manga_reading/support/classes/user_full.dart';
import 'package:manga_reading/support/get_friend_manga.dart';
import 'package:manga_reading/views/blocks/rated_manga_block.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';
import 'package:manga_reading/views/support/no_books_by_request.dart';
import 'package:manga_reading/views/user_section_view.dart';

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
  List<RatedMangaBook> _mangaBooks = [];

  UserFull _pageUser = UserFull(
    id: '',
    email: '',
    nickname: '',
    registerDate: Timestamp.fromDate(DateTime.now()),
    friends: 0,
    imagePath: '',
  );

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    getFullUserInfo(widget.id).then((value) {
      if (mounted) {
        setState(() {
          _pageUser = value;
        });

        getFriendManga(widget.id, 'finished').then((value) {
          if (mounted) {
            setState(() {
              _mangaBooks = value;
              _isLoading = false;
            });
          }
        });
      }
    });
  }

  refresh() {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });

      getFullUserInfo(widget.id).then((value) {
        if (mounted) {
          setState(() {
            _pageUser = value;
            _isLoading = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
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
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                _pageUser.nickname.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.7),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, .42, .42, 1],
                colors: [
                  Colors.pink.withOpacity(.5),
                  const Color(0xFFE67FA1).withOpacity(.5),
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
            child: !_isLoading
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .29,
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.red,
                                  backgroundImage: Image.network(
                                    _pageUser.imagePath,
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
                                _pageUser.nickname,
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
                                        _pageUser.registerDate.toDate()),
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
                                          builder: (context) => UserSectionView(
                                            id: widget.id,
                                            userName: _pageUser.nickname,
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
                                                    fontWeight: FontWeight.w400,
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
                                          builder: (context) => UserSectionView(
                                            id: widget.id,
                                            userName: _pageUser.nickname,
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
                                                    fontWeight: FontWeight.w400,
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
                                          builder: (context) => UserSectionView(
                                            id: widget.id,
                                            userName: _pageUser.nickname,
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
                                                    fontWeight: FontWeight.w400,
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
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .4,
                          child: _mangaBooks.isNotEmpty
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Finished',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
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
                                          return RatedMangaBlock(
                                            finishDate:
                                                _mangaBooks[index].addTime!,
                                            title: _mangaBooks[index].title!,
                                            chapters:
                                                _mangaBooks[index].chapters!,
                                            status: _mangaBooks[index].status!,
                                            author: _mangaBooks[index].author!,
                                            image: _mangaBooks[index].image!,
                                            userRate:
                                                _mangaBooks[index].userRate!,
                                            desc: _mangaBooks[index].desc!,
                                          );
                                        },
                                        itemCount: _mangaBooks.length,
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
      ),
    );
  }
}
