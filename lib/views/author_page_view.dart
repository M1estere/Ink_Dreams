import 'package:flutter/material.dart';
import 'package:manga_reading/support/get_author_manga.dart';
import 'package:manga_reading/views/blocks/author_manga_block.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';

class AuthorPageView extends StatefulWidget {
  final String authorName;

  const AuthorPageView({
    super.key,
    required this.authorName,
  });

  @override
  State<AuthorPageView> createState() => _AuthorPageViewState();
}

class _AuthorPageViewState extends State<AuthorPageView> {
  bool isLoading = true;
  List<AuthorManga> mangaBooks = [];

  @override
  void initState() {
    super.initState();

    getAuthorManga(widget.authorName).then((value) {
      setState(() {
        isLoading = false;
        mangaBooks = value;
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
        leadingWidth: MediaQuery.of(context).size.width,
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
                widget.authorName.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  letterSpacing: 2,
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  margin: const EdgeInsets.only(bottom: 20),
                  height: MediaQuery.of(context).size.height * .7,
                  child: !isLoading
                      ? ListView.builder(
                          itemCount: mangaBooks.length,
                          itemBuilder: (context, index) {
                            return AuthorMangaBlock(
                              title: mangaBooks[index].title!,
                              chapters: mangaBooks[index].chaptersAmount!,
                              status: mangaBooks[index].status!,
                              author: widget.authorName,
                              image: mangaBooks[index].image!,
                              genres: mangaBooks[index].genres!,
                            );
                          },
                          scrollDirection: Axis.vertical,
                        )
                      : const FetchingCircle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
