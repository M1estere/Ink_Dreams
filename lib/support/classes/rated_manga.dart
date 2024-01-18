import 'package:cloud_firestore/cloud_firestore.dart';

class RatedMangaBook {
  String? title;
  String? status;
  int? chapters;
  String? author;
  String? image;
  String? categories;
  Timestamp? addTime;
  int? userRate;
  String? desc;

  RatedMangaBook({
    this.title,
    this.status,
    this.author,
    this.chapters,
    this.image,
    this.categories,
    this.addTime,
    this.userRate,
    this.desc,
  });
}
