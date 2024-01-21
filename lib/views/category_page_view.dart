import 'package:flutter/material.dart';
import 'package:manga_reading/support/classes/manga_book.dart';
import 'package:manga_reading/support/get_manga.dart';
import 'package:manga_reading/views/blocks/full_manga_block.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';

class CategoryPageView extends StatefulWidget {
  final String categoryTitle;
  const CategoryPageView({super.key, required this.categoryTitle});

  @override
  State<CategoryPageView> createState() => _CategoryPageViewState();
}

class _CategoryPageViewState extends State<CategoryPageView> {
  List<MangaBook> _mangaBooks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    getMangaByCategory(widget.categoryTitle).then(
      (value) {
        if (mounted) {
          setState(
            () {
              _mangaBooks = value;
              _isLoading = false;
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
        leadingWidth: MediaQuery.of(context).size.width * .8,
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
                widget.categoryTitle.toUpperCase(),
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
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .88,
                  child: !_isLoading
                      ? ListView.builder(
                          itemCount: _mangaBooks.length,
                          itemBuilder: (context, index) {
                            return FullMangaBlock(
                              title: _mangaBooks[index].title!,
                              chapters: _mangaBooks[index].chapters!,
                              status: _mangaBooks[index].status!,
                              author: _mangaBooks[index].author!,
                              image: _mangaBooks[index].image!,
                              rates: _mangaBooks[index].rates!,
                              ratings: _mangaBooks[index].ratings!,
                              desc: _mangaBooks[index].desc!,
                              releaseYear: _mangaBooks[index].year!,
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
