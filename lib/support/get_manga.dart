import 'package:firebase_database/firebase_database.dart';
import 'package:manga_reading/support/classes/category_block.dart';
import 'package:manga_reading/support/classes/manga_book.dart';

Future<List<MangaBook>> getMangaByAuthor(String authorName) async {
  List<MangaBook> result = [];

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      MangaBookT block = MangaBookT.fromJson(data[i] as Map);

      if (block.author!.toLowerCase() == authorName.toLowerCase()) {
        MangaBook book = MangaBook(
          title: block.title,
          status: block.status,
          image: block.image,
          author: block.author,
          categories: block.categories,
          chapters: block.chapters,
          desc: block.desc,
          rates: block.rates,
          ratings: block.ratings,
          year: block.year,
        );

        result.add(book);
      }
    }
  } else {
    print('No data available.');
  }

  return result;
}

Future<List<MangaBook>> getMangaByCategory(String searchCategory) async {
  List<MangaBook> result = [];

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      MangaBookT block = MangaBookT.fromJson(data[i] as Map);

      if (block.categories!.toLowerCase().contains(searchCategory)) {
        MangaBook book = MangaBook(
          title: block.title,
          author: block.author,
          categories: block.categories,
          chapters: block.chapters,
          image: block.image,
          status: block.status,
          rates: block.rates,
          ratings: block.ratings,
          desc: block.desc,
          year: block.year,
        );
        result.add(book);
      }
    }
  } else {
    print('No data available.');
  }

  return result;
}

Future<List<MangaBook>> getMangaBySearch(String query) async {
  query = query.toLowerCase();

  List<MangaBook> result = [];

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      MangaBookT block = MangaBookT.fromJson(data[i] as Map);

      if (block.title!.toLowerCase().contains(query) ||
          block.author!.toLowerCase().contains(query)) {
        MangaBook book = MangaBook(
          title: block.title,
          status: block.status,
          image: block.image,
          author: block.author,
          categories: block.categories,
          chapters: block.chapters,
          year: block.year,
          desc: block.desc,
          rates: block.rates,
          ratings: block.ratings,
        );

        result.add(book);
      }
    }
  } else {
    print('No data available.');
  }

  return result;
}

Future<List<Category>> getCategories() async {
  List<Category> result = [];

  DatabaseReference ref =
      FirebaseDatabase.instance.ref().child('categories_titles');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      CategoryBlockT block = CategoryBlockT.fromJson(data[i] as Map);
      Category category = Category(
        name: block.name,
        link: block.link,
        desc: block.desc,
      );

      result.add(category);
    }
  } else {
    print('No data available.');
  }

  return result;
}
