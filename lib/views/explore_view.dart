import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:manga_reading/views/blocks/category_block.dart';
import 'package:manga_reading/views/manga_page_view.dart';
import 'package:page_transition/page_transition.dart';

class Category {
  String? name;
  String? link;

  Category({this.name, this.link});
}

class CategoryBlockT {
  String? name;
  String? link;

  CategoryBlockT({this.name, this.link});

  CategoryBlockT.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    link = json['image_link'];
  }
}

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreView();
}

class _ExploreView extends State<ExploreView> {
  String _currentTitle = 'Attack On Titan';
  String _currentAuthor = 'Hajime Isayama';

  final PageController _mangaPagesController =
      PageController(viewportFraction: .95);
  int _currentSectionIndex = 0;

  List<Category> categories = [];

  DatabaseReference ref =
      FirebaseDatabase.instance.ref().child('categories_titles');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    final pageSections = IndexedStack(
      index: _currentSectionIndex,
      children: [
        // main section
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .65,
                child: PageView.builder(
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
                          factor =
                              1 - (_mangaPagesController.page! - index).abs();
                        }

                        return _buildItem(context, factor);
                      },
                    );
                  },
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _currentTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5,
                  ),
                ),
                Text(
                  _currentAuthor,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        // categories section
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * .75,
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return CategoryBlock(
                  image: categories[index].link!,
                  title: categories[index].name!,
                );
              },
              scrollDirection: Axis.vertical,
            ),
          ),
        ),
      ],
    );

    return SafeArea(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentSectionIndex = 0;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: _currentSectionIndex == 0
                                ? const Color(0xFF9D1515)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      child: const Text(
                        'MAIN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
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
                      setState(() {
                        _currentSectionIndex = 1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: _currentSectionIndex == 1
                                ? Color(0xFF9D1515)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      child: const Text(
                        'CATEGORIES',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .75,
                child: pageSections,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, double factor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: MangaPageView(title: _currentTitle),
          ),
        );
      },
      child: Center(
        child: SizedBox(
          height: 500 + (factor * 75),
          width: 400,
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage('assets/images/attack.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void retrieveData() {
    categories.clear();
    ref.onChildAdded.listen(
      (value) {
        CategoryBlockT block =
            CategoryBlockT.fromJson(value.snapshot.value as Map);
        Category category = Category(name: block.name, link: block.link);
        print(category.name);
        print(category.link);

        categories.add(category);
        print(categories);
      },
    );
  }
}
