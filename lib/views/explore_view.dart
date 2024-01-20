import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:manga_reading/support/classes/manga_book.dart';
import 'package:manga_reading/support/get_manga.dart';
import 'package:manga_reading/support/get_search_intro_page.dart';
import 'package:manga_reading/views/blocks/category_block.dart';
import 'package:manga_reading/views/blocks/explore_start_block.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';

class Category {
  String? name;
  String? link;
  String? desc;

  Category({
    this.name,
    this.link,
    this.desc,
  });
}

class CategoryBlockT {
  String? name;
  String? link;
  String? desc;

  CategoryBlockT({
    this.name,
    this.link,
    this.desc,
  });

  CategoryBlockT.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    link = json['image_link'];
    desc = json['description'];
  }
}

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreView();
}

class _ExploreView extends State<ExploreView> {
  bool isLoading = true;
  List<MangaBook> mangaBooks = [];

  String currentTitle = '';
  String currentAuthor = '';

  final PageController _mangaPagesController =
      PageController(viewportFraction: .95);
  int _currentSectionIndex = 0;

  List<Category> categories = [];

  DatabaseReference ref =
      FirebaseDatabase.instance.ref().child('categories_titles');

  @override
  void initState() {
    super.initState();

    getCategories().then(
      (value) {
        if (mounted) {
          setState(
            () {
              categories = value;
            },
          );
        }
      },
    );

    getRandomManga(3).then((value) {
      if (mounted) {
        setState(() {
          isLoading = false;

          mangaBooks = value;

          currentTitle = mangaBooks[0].title!;
          currentAuthor = mangaBooks[0].author!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageSections = IndexedStack(
      index: _currentSectionIndex,
      children: [
        // main section
        !isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .65,
                      child: PageView.builder(
                        onPageChanged: (value) {
                          if (mounted) {
                            Future.delayed(
                              Duration(milliseconds: 350),
                              () {
                                setState(() {
                                  currentTitle = mangaBooks[value].title!;
                                  currentAuthor = mangaBooks[value].author!;
                                });
                              },
                            );
                          }
                        },
                        padEnds: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        controller: _mangaPagesController,
                        itemBuilder: (context, index) {
                          return ListenableBuilder(
                            listenable: _mangaPagesController,
                            builder: (context, child) {
                              double factor = 1;
                              if (_mangaPagesController
                                  .position.hasContentDimensions) {
                                factor = 1 -
                                    (_mangaPagesController.page! - index).abs();
                              } else {
                                if (index == 0) {
                                  factor = 1;
                                } else {
                                  factor = 0;
                                }
                              }

                              return ExploreStartBlock(
                                title: mangaBooks[index].title!,
                                factor: factor,
                                image: mangaBooks[index].image!,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          currentTitle,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          currentAuthor,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                            height: .55,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const FetchingCircle(),
        // categories section
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .9,
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryBlock(
                  image: categories[index].link!,
                  title: categories[index].name!,
                  desc: categories[index].desc!,
                );
              },
              scrollDirection: Axis.vertical,
            ),
          ),
        ),
      ],
    );

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        _currentSectionIndex = 0;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: _currentSectionIndex == 0
                              ? Colors.red
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    child: Text(
                      'MAIN',
                      style: TextStyle(
                        color: _currentSectionIndex == 0
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        fontSize: _currentSectionIndex == 0 ? 20 : 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        _currentSectionIndex = 1;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: _currentSectionIndex == 1
                              ? Colors.red
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    child: Text(
                      'CATEGORIES',
                      style: TextStyle(
                        color: _currentSectionIndex == 1
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        fontSize: _currentSectionIndex == 1 ? 20 : 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .78,
              child: pageSections,
            ),
          ],
        ),
      ),
    );
  }
}
