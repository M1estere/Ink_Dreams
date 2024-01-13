import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

import 'package:manga_reading/support/get_by_category.dart';

class AuthorBlock {
  String? name;
  String? image;

  AuthorBlock({required this.name, required this.image});
}

class AuthorBlockT {
  String? name;
  String? image;

  AuthorBlockT({required this.name, required this.image});

  AuthorBlockT.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }
}

Future<List<MangaBook>> getRandomManga(int amount) async {
  List<MangaBook> result = [];

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      MangaBookT block = MangaBookT.fromJson(data[i] as Map);

      MangaBook book = MangaBook(
        title: block.title,
        image: block.image,
        year: block.year,
        author: block.author,
      );

      result.add(book);
    }
  } else {
    print('No data available.');
  }

  return processList(amount, result).cast<MangaBook>();
}

Future<List<AuthorBlock>> getRandomAuthor(int amount) async {
  List<AuthorBlock> result = [];

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('authors');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      AuthorBlockT block = AuthorBlockT.fromJson(data[i] as Map);

      AuthorBlock book = AuthorBlock(
        name: block.name,
        image: block.image,
      );

      result.add(book);
    }
  } else {
    print('No data available.');
  }

  return processList(amount, result).cast<AuthorBlock>();
}

List processList(int amount, List data) {
  if (amount > data.length || amount <= 0) {
    print('Wrong values');
    return [];
  }

  List result = [];

  for (int i = 0; i < amount; i++) {
    int index = Random().nextInt(data.length);
    result.add(data[index]);

    data.removeAt(index);
  }

  return result;
}
