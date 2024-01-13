import 'package:firebase_database/firebase_database.dart';

class AuthorManga {
  String? title;
  int? chaptersAmount;
  String? status;
  String? genres;
  String? image;

  AuthorManga(
      {required this.title,
      required this.chaptersAmount,
      required this.status,
      required this.genres,
      required this.image});
}

class AuthorMangaT {
  String? title;
  int? chaptersAmount;
  String? status;
  String? genres;
  String? image;
  String? author;

  AuthorMangaT(
      {required this.title,
      required this.chaptersAmount,
      required this.status,
      required this.genres,
      required this.image,
      required this.author});

  AuthorMangaT.fromJson(Map<dynamic, dynamic> json) {
    author = json['author'];
    title = json['title'];
    chaptersAmount = json['chapters'].length;
    status = json['status'];
    genres = json['category'];
    image = json['cover'];
  }
}

Future<List<AuthorManga>> getAuthorManga(String authorName) async {
  List<AuthorManga> result = [];

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      AuthorMangaT block = AuthorMangaT.fromJson(data[i] as Map);

      if (block.author!.toLowerCase() == authorName.toLowerCase()) {
        AuthorManga book = AuthorManga(
          title: block.title,
          chaptersAmount: block.chaptersAmount,
          status: block.status,
          genres: block.genres,
          image: block.image,
        );

        result.add(book);
      }
    }
  } else {
    print('No data available.');
  }

  return result;
}
