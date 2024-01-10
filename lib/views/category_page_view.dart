import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:manga_reading/support/get_by_category.dart';
import 'package:manga_reading/views/blocks/category_result_block.dart';

class CategoryPageView extends StatefulWidget {
  final String categoryTitle;
  const CategoryPageView({super.key, required this.categoryTitle});

  @override
  State<CategoryPageView> createState() => _CategoryPageViewState();
}

class _CategoryPageViewState extends State<CategoryPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 250,
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
                widget.categoryTitle.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
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
                  child: FutureBuilder(
                    future: get_by_cat(widget.categoryTitle),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      Widget displayWidget;
                      if (snapshot.hasData) {
                        displayWidget = ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return CategoryResultBlock(
                              title: snapshot.data[index].title!,
                              chapters: snapshot.data[index].chapters!,
                              status: snapshot.data[index].status!,
                              author: snapshot.data[index].author!,
                              image: snapshot.data[index].image!,
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        displayWidget = Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        displayWidget = Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Text('Awaiting result...'),
                        );
                      }
                      return Center(
                        child: displayWidget,
                      );
                    },
                  ),

                  //   child: ListView.builder(
                  //     itemCount: manga_books.length,
                  //     itemBuilder: (context, index) {
                  //       return CategoryResultBlock(
                  //         title: manga_books[index].title!,
                  //         chapters: manga_books[index].chapters!,
                  //         status: manga_books[index].status!,
                  //         author: manga_books[index].author!,
                  //         image: manga_books[index].image!,
                  //       );
                  //     },
                  //     scrollDirection: Axis.vertical,
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
