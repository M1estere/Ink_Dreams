class AuthorManga {
  String? title;
  int? chaptersAmount;
  String? status;
  String? genres;
  String? image;

  AuthorManga({
    required this.title,
    required this.chaptersAmount,
    required this.status,
    required this.genres,
    required this.image,
  });
}

class AuthorMangaT {
  String? title;
  int? chaptersAmount;
  String? status;
  String? genres;
  String? image;
  String? author;

  AuthorMangaT({
    required this.title,
    required this.chaptersAmount,
    required this.status,
    required this.genres,
    required this.image,
    required this.author,
  });

  AuthorMangaT.fromJson(Map<dynamic, dynamic> json) {
    author = json['author'];
    title = json['title'];
    chaptersAmount = json['chapters'].length;
    status = json['status'];
    genres = json['category'];
    image = json['cover'];
  }
}
