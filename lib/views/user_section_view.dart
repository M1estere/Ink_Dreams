import 'package:flutter/material.dart';
import 'package:manga_reading/support/classes/manga_book_timed.dart';
import 'package:manga_reading/support/user_actions.dart';
import 'package:manga_reading/views/blocks/user_section_block.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';
import 'package:manga_reading/views/support/no_books_by_request.dart';

class UserSectionView extends StatefulWidget {
  final String sectionName;
  final String userName;
  final String id;
  const UserSectionView(
      {super.key,
      required this.id,
      required this.sectionName,
      required this.userName});

  @override
  State<UserSectionView> createState() => _UserSectionViewState();
}

class _UserSectionViewState extends State<UserSectionView> {
  List<MangaBookTimed> mangaBooks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getMangaByUserSection(widget.id, widget.sectionName).then((value) {
      setState(() {
        mangaBooks = value;
        isLoading = false;
      });
    });
  }

  refresh() {
    setState(() {
      isLoading = true;
    });

    getMangaByUserSection(widget.id, widget.sectionName).then((value) {
      setState(() {
        mangaBooks = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 60,
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
              Expanded(
                child: FittedBox(
                  child: Text(
                    '${widget.sectionName} [${widget.userName}]'.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: 2,
                    ),
                  ),
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
            color: Color(0xFF23202B),
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
                                  return UserSectionBlock(
                                    title: mangaBooks[index].title!,
                                    addDateTime: mangaBooks[index].addTime!,
                                    chapters: mangaBooks[index].chapters!,
                                    status: mangaBooks[index].status!,
                                    author: mangaBooks[index].author!,
                                    updateParent: refresh,
                                    image: mangaBooks[index].image!,
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
