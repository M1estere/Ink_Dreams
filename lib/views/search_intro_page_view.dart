import 'dart:math';
import 'package:flutter/material.dart';
import 'package:manga_reading/support/classes/author_block.dart';
import 'package:manga_reading/support/classes/manga_book.dart';
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
  bool isLoading = true;

  List<MangaBook> popularManga = [];
  List<MangaBook> hottestManga = [];
  List<AuthorBlock> authors = [];

  @override
  void initState() {
    super.initState();

    getRandomManga(Random().nextInt(8) + 8).then(
      (value) {
        setState(() {
          popularManga = value.sublist(0, (value.length / 2).round());
          hottestManga =
              value.sublist((value.length / 2).round(), value.length);
          getRandomAuthor(1).then((value) {
            setState(() {
              authors = value;
              isLoading = false;
            });
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getRandomManga(Random().nextInt(8) + 8).then(
          (value) {
            setState(() {
              popularManga = value.sublist(0, (value.length / 2).round());
              hottestManga =
                  value.sublist((value.length / 2).round(), value.length);
              getRandomAuthor(1).then((value) {
                setState(() {
                  authors = value;
                  isLoading = false;
                });
              });
            });
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: SingleChildScrollView(
          child: !isLoading
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Popular'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      height: 360,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return SearchMangaBlock(
                            title: popularManga[index].title!,
                            image: popularManga[index].image!,
                            releaseYear: popularManga[index].year!,
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: popularManga.length,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Hottest'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      height: 360,
                      child: ListView.builder(
                        itemCount: hottestManga.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SearchMangaBlock(
                            title: hottestManga[index].title!,
                            image: hottestManga[index].image!,
                            releaseYear: hottestManga[index].year!,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Best Authors'.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: authors.length,
                        itemBuilder: (context, index) {
                          return SearchAuthorBlock(
                            author: authors[index].name!,
                            image: authors[index].image!,
                          );
                        },
                      ),
                    ),
                  ],
                )
              : const FetchingCircle(),
        ),
      ),
    );
  }
}
