import 'package:flutter/material.dart';
import 'package:manga_reading/support/classes/manga_book.dart';
import 'package:manga_reading/views/blocks/full_manga_block.dart';
import 'package:manga_reading/support/get_by_search.dart';
import 'package:manga_reading/views/support/no_books_by_request.dart';

class SearchResultsView extends StatefulWidget {
  const SearchResultsView({super.key});

  @override
  State<SearchResultsView> createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  TextEditingController searchController = TextEditingController();

  List<MangaBook> searchResults = [];
  bool canDisplay = false;

  @override
  void dispose() {
    super.dispose();

    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
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
                  color: const Color(0xFF252525),
                ),
                child: SizedBox(
                  height: 65,
                  child: TextField(
                    controller: searchController,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      letterSpacing: .5,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        size: 35,
                        color: Color(0xFFA2A2A2),
                      ),
                      hintText: 'Search anything...',
                      hintStyle: TextStyle(
                        color: Color(0xFFA2A2A2),
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .5,
                      ),
                    ),
                    onChanged: (value) {
                      getMangaBySearch(value).then((res) {
                        if (value.isEmpty) {
                          if (mounted) {
                            setState(() {
                              canDisplay = false;
                            });
                          }
                        } else {
                          if (mounted) {
                            setState(() {
                              searchResults = res;
                              canDisplay = true;
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
              canDisplay
                  ? (searchResults.isNotEmpty &&
                          searchController.text.isNotEmpty)
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
                                itemCount: searchResults.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return FullMangaBlock(
                                    title: searchResults[index].title!,
                                    chapters: searchResults[index].chapters!,
                                    status: searchResults[index].status!,
                                    author: searchResults[index].author!,
                                    image: searchResults[index].image!,
                                    desc: searchResults[index].desc!,
                                    rates: searchResults[index].rates!,
                                    ratings: searchResults[index].ratings!,
                                    releaseYear: searchResults[index].year!,
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
