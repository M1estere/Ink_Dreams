class MangaBook {
  String? title;
  String? status;
  int? chapters;
  String? author;
  String? image;
  String? categories;
  String? year;
  String? desc;
  int? rates;
  int? ratings;

  MangaBook({
    this.title,
    this.status,
    this.author,
    this.chapters,
    this.image,
    this.categories,
    this.year,
    this.rates,
    this.ratings,
    this.desc,
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
  String? desc;
  int? rates;
  int? ratings;

  MangaBookT({
    this.title,
    this.status,
    this.author,
    this.chapters,
    this.image,
    this.categories,
    this.year,
    this.desc,
    this.rates,
    this.ratings,
  });

  MangaBookT.fromJson(Map<dynamic, dynamic> json) {
    image = json['cover'];
    title = json['title'];
    categories = json['category'];
    chapters = json['chapters'].length;
    status = json['status'];
    author = json['author'];
    year = json['year'].toString();

    rates = json['rates'];
    ratings = json['rating'];
    desc = json['description'];
  }
}
