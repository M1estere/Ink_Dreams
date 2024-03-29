import 'package:cloud_firestore/cloud_firestore.dart';

class MangaBookTimed {
  String? title;
  String? status;
  int? chapters;
  String? author;
  String? image;
  String? categories;
  String? year;
  Timestamp? addTime;
  int? rates;
  int? ratings;
  String? desc;

  MangaBookTimed({
    this.title,
    this.status,
    this.author,
    this.chapters,
    this.image,
    this.categories,
    this.year,
    this.addTime,
    this.rates,
    this.ratings,
    this.desc,
  });
}
