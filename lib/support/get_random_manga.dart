import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

class MangaSearchIntro {
  String? title;
  String? image;
  String? year;

  MangaSearchIntro(
      {required this.title, required this.image, required this.year});
}

class MangaSearchIntroT {
  String? title;
  String? image;
  String? year;

  MangaSearchIntroT(
      {required this.title, required this.image, required this.year});

  MangaSearchIntroT.fromJson(Map<dynamic, dynamic> json) {
    image = json['cover'];
    title = json['title'];
    year = json['year'].toString();
  }
}

class AuthorSearchIntro {
  String? name;
  String? image;

  AuthorSearchIntro({required this.name, required this.image});
}

class AuthorSearchIntroT {
  String? name;
  String? image;

  AuthorSearchIntroT({required this.name, required this.image});

  AuthorSearchIntroT.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }
}

Future<List<MangaSearchIntro>> getRandomManga(int amount) async {
  List<MangaSearchIntro> result = [];

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      MangaSearchIntroT block = MangaSearchIntroT.fromJson(data[i] as Map);

      MangaSearchIntro book = MangaSearchIntro(
        title: block.title,
        image: block.image,
        year: block.year,
      );

      result.add(book);
    }
  } else {
    print('No data available.');
  }

  return processList(amount, result);
}

List<MangaSearchIntro> processList(int amount, List<MangaSearchIntro> data) {
  if (amount > data.length) {
    print('Wrong values');
    return [];
  }

  List<MangaSearchIntro> result = [];

  for (int i = 0; i < amount; i++) {
    int index = Random().nextInt(data.length);
    result.add(data[index]);

    data.removeAt(index);
  }

  return result;
}

List<AuthorSearchIntro> processAuthors(
    int amount, List<AuthorSearchIntro> data) {
  if (amount > data.length) {
    print('Wrong values');
    return [];
  }

  List<AuthorSearchIntro> result = [];

  for (int i = 0; i < amount; i++) {
    int index = Random().nextInt(data.length);
    result.add(data[index]);

    data.removeAt(index);
  }

  return result;
}

Future<List<AuthorSearchIntro>> getRandomAuthor(int amount) async {
  List<AuthorSearchIntro> result = [];

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('authors');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      AuthorSearchIntroT block = AuthorSearchIntroT.fromJson(data[i] as Map);

      AuthorSearchIntro book = AuthorSearchIntro(
        name: block.name,
        image: block.image,
      );

      result.add(book);
    }
  } else {
    print('No data available.');
  }

  return processAuthors(amount, result);
}
