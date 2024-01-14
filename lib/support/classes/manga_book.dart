class MangaBook {
  String? title;
  String? status;
  int? chapters;
  String? author;
  String? image;
  String? categories;
  String? year;

  MangaBook({
    this.title,
    this.status,
    this.author,
    this.chapters,
    this.image,
    this.categories,
    this.year,
  });
}

class MangaBookT {
  String? title;
  String? status;
  int? chapters;
  String? author;
  String? image;
  String? categories;
  String? year;

  MangaBookT({
    this.title,
    this.status,
    this.author,
    this.chapters,
    this.image,
    this.categories,
    this.year,
  });

  MangaBookT.fromJson(Map<dynamic, dynamic> json) {
    image = json['cover'];
    title = json['title'];
    categories = json['category'];
    chapters = json['chapters'].length;
    status = json['status'];
    author = json['author'];
    year = json['year'].toString();
  }
}
