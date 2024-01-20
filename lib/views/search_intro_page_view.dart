import 'dart:math';
import 'package:flutter/material.dart';
import 'package:manga_reading/support/classes/manga_book.dart';
import 'package:manga_reading/support/get_search_intro_page.dart';
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

  @override
  void initState() {
    super.initState();

    getRandomManga(Random().nextInt(8) + 8).then(
      (value) {
        if (mounted) {
          setState(() {
            popularManga = value.sublist(0, (value.length / 2).round());
            hottestManga =
                value.sublist((value.length / 2).round(), value.length);

            isLoading = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getRandomManga(Random().nextInt(8) + 8).then(
          (value) {
            if (mounted) {
              setState(() {
                popularManga = value.sublist(0, (value.length / 2).round());
                hottestManga =
                    value.sublist((value.length / 2).round(), value.length);

                isLoading = false;
              });
            }
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
                      height: MediaQuery.of(context).size.height * .4,
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
                      margin: EdgeInsets.only(bottom: 20),
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
                      height: 20,
                    ),
                  ],
                )
              : const FetchingCircle(),
        ),
      ),
    );
  }
}
