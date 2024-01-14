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
