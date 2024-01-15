import 'package:flutter/material.dart';
import 'package:manga_reading/support/classes/manga_book.dart';
import 'package:manga_reading/views/blocks/search_result_block.dart';
import 'package:manga_reading/support/get_by_search.dart';
import 'package:manga_reading/views/support/no_books_by_reques.dart';

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
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 180,
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
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                  color: Colors.white,
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
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: SizedBox(
                  height: 65,
                  child: TextField(
                    controller: searchController,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 35,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Search anything...',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 70, 70, 70),
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                    ),
                    onChanged: (value) {
                      getSearchResult(value).then((res) {
                        if (value.isEmpty) {
                          print('empty');
                          setState(() {
                            canDisplay = false;
                          });
                        } else {
                          setState(() {
                            searchResults = res;
                            canDisplay = true;
                          });
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
                            const Text(
                              'Results',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w400),
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
                                  return SearchResultBlock(
                                    title: searchResults[index].title!,
                                    chapters: searchResults[index].chapters!,
                                    status: searchResults[index].status!,
                                    author: searchResults[index].author!,
                                    image: searchResults[index].image!,
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
                              width: MediaQuery.of(context).size.width * .7,
                              child: const Text(
                                textAlign: TextAlign.center,
                                'Type something to find!',
                                style: TextStyle(
                                  color: Colors.white,
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
