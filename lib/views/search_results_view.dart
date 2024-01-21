import 'package:flutter/material.dart';
import 'package:manga_reading/support/classes/manga_book.dart';
import 'package:manga_reading/support/get_manga.dart';
import 'package:manga_reading/views/blocks/full_manga_block.dart';
import 'package:manga_reading/views/support/no_books_by_request.dart';

class SearchResultsView extends StatefulWidget {
  const SearchResultsView({super.key});

  @override
  State<SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  final TextEditingController _searchController = TextEditingController();

  List<MangaBook> _searchResults = [];
  bool _canDisplay = false;

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
        leadingWidth: MediaQuery.of(context).size.width * .4,
        leading: Container(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).snackBarTheme.backgroundColor,
                  border: Border(
                    bottom:
                        Theme.of(context).inputDecorationTheme.outlineBorder!,
                    top: Theme.of(context).inputDecorationTheme.outlineBorder!,
                    left: Theme.of(context).inputDecorationTheme.outlineBorder!,
                    right:
                        Theme.of(context).inputDecorationTheme.outlineBorder!,
                  ),
                ),
                child: SizedBox(
                  height: 65,
                  child: TextField(
                    controller: _searchController,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      letterSpacing: .5,
                    ),
                    decoration: InputDecoration(
                      border: Theme.of(context).inputDecorationTheme.border,
                      focusedBorder:
                          Theme.of(context).inputDecorationTheme.focusedBorder,
                      enabledBorder:
                          Theme.of(context).inputDecorationTheme.enabledBorder,
                      errorBorder:
                          Theme.of(context).inputDecorationTheme.errorBorder,
                      disabledBorder:
                          Theme.of(context).inputDecorationTheme.disabledBorder,
                      prefixIcon: Icon(
                        Icons.search,
                        size: 30,
                        color: Theme.of(context)
                            .inputDecorationTheme
                            .prefixIconColor,
                      ),
                      hintText: 'Search anything...',
                      hintStyle:
                          Theme.of(context).inputDecorationTheme.hintStyle,
                    ),
                    onChanged: (value) {
                      getMangaBySearch(value).then((res) {
                        if (value.isEmpty) {
                          if (mounted) {
                            setState(() {
                              _canDisplay = false;
                            });
                          }
                        } else {
                          if (mounted) {
                            setState(() {
                              _searchResults = res;
                              _canDisplay = true;
                            });
                          }
                        }
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _canDisplay
                  ? (_searchResults.isNotEmpty &&
                          _searchController.text.isNotEmpty)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Results'.toUpperCase(),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .7,
                              child: ListView.builder(
                                itemCount: _searchResults.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return FullMangaBlock(
                                    title: _searchResults[index].title!,
                                    chapters: _searchResults[index].chapters!,
                                    status: _searchResults[index].status!,
                                    author: _searchResults[index].author!,
                                    image: _searchResults[index].image!,
                                    desc: _searchResults[index].desc!,
                                    rates: _searchResults[index].rates!,
                                    ratings: _searchResults[index].ratings!,
                                    releaseYear: _searchResults[index].year!,
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : const NoBooksByRequest()
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * .75,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.article_outlined,
                              color: Colors.green,
                              size: 80,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .8,
                              child: Text(
                                textAlign: TextAlign.center,
                                'Type something to find!',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
