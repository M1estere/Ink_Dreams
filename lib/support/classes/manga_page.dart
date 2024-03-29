import 'package:manga_reading/support/get_full_manga.dart';

class MangaPageFull {
  String? title;
  String? status;
  List<Map?>? chapters;
  String? author;
  String? image;
  String? categories;
  String? year;
  String? desc;
  int? rating;
  int? rates;

  MangaPageFull({
    this.title,
    this.status,
    this.author,
    this.chapters,
    this.image,
    this.categories,
    this.year,
    this.desc,
    this.rating,
    this.rates,
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
  int? rating;
  int? rates;

  MangaPageFullT({
    this.title,
    this.status,
    this.author,
    this.chapters,
    this.image,
    this.categories,
    this.year,
    this.desc,
    this.rating,
    this.rates,
  });

  MangaPageFullT.fromJson(Map<dynamic, dynamic> json) {
    image = json['cover'];

    title = json['title'];
    categories = json['category'];

    chapters = getChapters(json['chapters']);

    status = json['status'];
    author = json['author'];

    year = json['year'].toString();
    desc = json['description'];

    rating = json['rating'];
    rates = json['rates'];
  }
}
