import 'package:firebase_database/firebase_database.dart';

class MangaPageFull {
  String? title;
  String? status;
  List<Map?>? chapters;
  String? author;
  String? image;
  String? categories;
  String? year;
  String? desc;

  MangaPageFull({
    this.title,
    this.status,
    this.author,
    this.chapters,
    this.image,
    this.categories,
    this.year,
    this.desc,
  });
}

class MangaPageFullT {
  String? title;
  String? status;
  List<Map?>? chapters;
  String? author;
  String? image;
  String? categories;
  String? year;
  String? desc;

  MangaPageFullT({
    this.title,
    this.status,
    this.author,
    this.chapters,
    this.image,
    this.categories,
    this.year,
    this.desc,
  });

  MangaPageFullT.fromJson(Map<dynamic, dynamic> json) {
    image = json['cover'];

    title = json['Name'];
    categories = json['category'];

    chapters = get_chapters(json['chapters']);

    status = json['status'];
    author = json['author'];

    year = json['year'].toString();
    desc = json['description'];
  }
}

List<Map> get_chapters(List json) {
  List<Map> result = [];

  for (var i = 0; i < json.length; i++) {
    Map temp = {};
    temp[json[i]['name']] = json[i]['name'];
    temp[json[i]['link']] = json[i]['link'];

    result.add(temp);
  }

  return result;
}

Future<MangaPageFull> get_manga_by_name(String name) async {
  MangaPageFull result = MangaPageFull();

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      MangaPageFullT block = MangaPageFullT.fromJson(data[i] as Map);

      if (block.title == name) {
        MangaPageFull book = MangaPageFull(
          title: block.title,
          author: block.author,
          categories: block.categories,
          chapters: block.chapters,
          image: block.image,
          status: block.status,
          year: block.year,
          desc: block.desc,
        );

        result = book;
        break;
      }
    }
  } else {
    print('No data available.');
  }

  return result;
}
