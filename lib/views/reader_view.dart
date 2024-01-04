import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class Category {
  String? name;
  String? link;

  Category({this.name, this.link});
}

class CategoryBlock {
  String? name;
  String? link;

  CategoryBlock({this.name, this.link});

  CategoryBlock.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    link = json['link'];
  }
}

class ReaderView extends StatefulWidget {
  final String filePath;

  const ReaderView({super.key, required this.filePath});

  @override
  State<ReaderView> createState() => _ReaderViewState();
}

class _ReaderViewState extends State<ReaderView> {
  int startPage = 0;
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: MediaQuery.of(context).size.width,
        leading: Container(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  // Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              Text(
                'Attack On Titan [1]'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: GestureDetector(
          child: PdfDocumentLoader.openAsset(
            widget.filePath,
            documentBuilder: (context, pdfDocument, pageCount) => LayoutBuilder(
              builder: (context, constraints) => ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: pageCount,
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  color: Colors.black12,
                  child: PdfPageView(
                    pdfDocument: pdfDocument,
                    pageNumber: index + 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void retrieveData() {
    ref.onChildAdded.listen(
      (value) {
        CategoryBlock block =
            CategoryBlock.fromJson(value.snapshot.value as Map);
        Category category = Category(name: block.name, link: block.link);

        categories.add(category);
        print(categories);
      },
    );
  }
}
