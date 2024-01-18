import 'package:flutter/material.dart';
import 'package:manga_reading/support/get_friend_manga.dart';
import 'package:manga_reading/support/user_actions.dart';
import 'package:manga_reading/views/blocks/rated_manga_block.dart';
import 'package:manga_reading/views/blocks/user_section_block.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';
import 'package:manga_reading/views/support/no_books_by_request.dart';

class UserSectionView extends StatefulWidget {
  final String sectionName;
  final String userName;
  final String id;

  const UserSectionView({
    super.key,
    required this.id,
    required this.sectionName,
    required this.userName,
  });

  @override
  State<UserSectionView> createState() => _UserSectionViewState();
}

class _UserSectionViewState extends State<UserSectionView> {
  List mangaBooks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    if (widget.sectionName.contains('finished')) {
      getFriendManga(widget.id, widget.sectionName).then((value) {
        setState(() {
          mangaBooks = value;
          isLoading = false;
        });
      });
    } else {
      getMangaByUserSection(widget.id, widget.sectionName).then((value) {
        setState(() {
          mangaBooks = value;
          isLoading = false;
        });
      });
    }
  }

  refresh() {
    setState(() {
      isLoading = true;
    });

    if (widget.sectionName.contains('finished')) {
      getFriendManga(widget.id, widget.sectionName).then((value) {
        setState(() {
          mangaBooks = value;
          isLoading = false;
        });
      });
    } else {
      getMangaByUserSection(widget.id, widget.sectionName).then((value) {
        setState(() {
          mangaBooks = value;
          isLoading = false;
        });
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
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: MediaQuery.of(context).size.width * .9,
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
                '${widget.sectionName} [${widget.userName}]'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
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
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF121212),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: !isLoading
                ? mangaBooks.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              margin: const EdgeInsets.only(bottom: 20),
                              child: ListView.builder(
                                itemCount: mangaBooks.length,
                                itemBuilder: (context, index) {
                                  return !widget.sectionName
                                          .contains('finished')
                                      ? UserSectionBlock(
                                          title: mangaBooks[index].title!,
                                          desc: mangaBooks[index].desc!,
                                          addDate: mangaBooks[index].addTime!,
                                          chapters: mangaBooks[index].chapters!,
                                          status: mangaBooks[index].status!,
                                          author: mangaBooks[index].author!,
                                          updateFunc: refresh,
                                          image: mangaBooks[index].image!,
                                        )
                                      : RatedMangaBlock(
                                          finishDate:
                                              mangaBooks[index].addTime!,
                                          title: mangaBooks[index].title!,
                                          chapters: mangaBooks[index].chapters!,
                                          status: mangaBooks[index].status!,
                                          author: mangaBooks[index].author!,
                                          image: mangaBooks[index].image!,
                                          userRate: mangaBooks[index].userRate!,
                                          desc: mangaBooks[index].desc!,
                                          updateFunc: refresh,
                                        );
                                },
                                scrollDirection: Axis.vertical,
                              ),
                            ),
                          ),
                        ],
                      )
                    : const NoBooksByRequest()
                : const FetchingCircle(),
          ),
        ),
      ),
    );
  }
}
