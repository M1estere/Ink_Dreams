import 'dart:math';

import 'package:flutter/material.dart';
import 'package:manga_reading/support/get_by_category.dart';
import 'package:manga_reading/support/get_search_intro_page.dart';
import 'package:manga_reading/views/blocks/search_author_block.dart';
import 'package:manga_reading/views/blocks/search_manga_block.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';

class SearchIntroPageView extends StatefulWidget {
  const SearchIntroPageView({super.key});

  @override
  State<SearchIntroPageView> createState() => _SearchIntroPageViewState();
}

class _SearchIntroPageViewState extends State<SearchIntroPageView> {
  bool isLoadingPopular = true;
  bool isLoadingHottest = true;
  bool isLoadingAuthors = true;

  List<MangaBook> popularManga = [];
  List<MangaBook> hottestManga = [];
  List<AuthorBlock> authors = [];

  @override
  void initState() {
    super.initState();

    getRandomManga(Random().nextInt(4) + 3).then((value) {
      setState(() {
        isLoadingPopular = false;
        popularManga = value;
      });
    });

    getRandomManga(Random().nextInt(4) + 3).then((value) {
      setState(() {
        isLoadingHottest = false;
        hottestManga = value;
      });
    });

    getRandomAuthor(1).then((value) {
      setState(() {
        isLoadingAuthors = false;
        authors = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              child: !isLoadingPopular
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return SearchMangaBlock(
                          title: popularManga[index].title!,
                          releaseYear: popularManga[index].year!,
                          image: popularManga[index].image!,
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: popularManga.length,
                    )
                  : const FetchingCircle(),
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
              child: !isLoadingHottest
                  ? ListView.builder(
                      itemCount: hottestManga.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SearchMangaBlock(
                          title: hottestManga[index].title!,
                          releaseYear: hottestManga[index].year!,
                          image: hottestManga[index].image!,
                        );
                      },
                    )
                  : const FetchingCircle(),
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
              child: !isLoadingAuthors
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: authors.length,
                      itemBuilder: (context, index) {
                        return SearchAuthorBlock(
                          author: authors[index].name!,
                          image: authors[index].image!,
                        );
                      },
                    )
                  : const FetchingCircle(),
            ),
          ],
        ),
      ),
    );
  }
}
