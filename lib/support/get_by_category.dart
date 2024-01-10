import 'package:firebase_database/firebase_database.dart';

class MangaBook {
  String? title;
  String? status;
  int? chapters;
  String? author;
  String? image;
  String? categories;

  MangaBook(
      {this.title,
      this.status,
      this.author,
      this.chapters,
      this.image,
      this.categories});
}

class MangaBookT {
  String? title;
  String? status;
  int? chapters;
  String? author;
  String? image;
  String? categories;

  MangaBookT(
      {this.title,
      this.status,
      this.author,
      this.chapters,
      this.image,
      this.categories});

  MangaBookT.fromJson(Map<dynamic, dynamic> json) {
    image = json['cover'];
    title = json['Name'];
    categories = json['category'];
    chapters = 10;
    status = 'Done';
    author = 'Babadzaki';
  }
}

Future<List<MangaBook>> get_by_cat(String search_category) async {
  List<MangaBook> result = [];

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      MangaBookT block = MangaBookT.fromJson(data[i] as Map);
      if (block.categories!.toLowerCase().contains(search_category)) {
        MangaBook book = MangaBook(
          title: block.title,
          author: block.author,
          categories: block.categories,
          chapters: block.chapters,
          image: block.image,
          status: block.status,
        );
        result.add(book);
      }
    }
  } else {
    print('No data available.');
  }

  return result;
}
