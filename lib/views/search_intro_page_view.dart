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
  bool _isLoading = true;

  List<MangaBook> _popularManga = [];
  List<MangaBook> _hottestManga = [];

  @override
  void initState() {
    super.initState();

    getRandomManga(Random().nextInt(8) + 8).then(
      (value) {
        if (mounted) {
          setState(() {
            _popularManga = value.sublist(0, (value.length / 2).round());
            _hottestManga =
                value.sublist((value.length / 2).round(), value.length);

            _isLoading = false;
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
                _popularManga = value.sublist(0, (value.length / 2).round());
                _hottestManga =
                    value.sublist((value.length / 2).round(), value.length);

                _isLoading = false;
              });
            }
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
        child: SingleChildScrollView(
          child: !_isLoading
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Popular'.toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
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
                            title: _popularManga[index].title!,
                            image: _popularManga[index].image!,
                            releaseYear: _popularManga[index].year!,
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: _popularManga.length,
                      ),
                    ),
                    Text(
                      'Hottest'.toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      margin: const EdgeInsets.only(bottom: 20),
                      height: 360,
                      child: ListView.builder(
                        itemCount: _hottestManga.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return SearchMangaBlock(
                            title: _hottestManga[index].title!,
                            image: _hottestManga[index].image!,
                            releaseYear: _hottestManga[index].year!,
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
