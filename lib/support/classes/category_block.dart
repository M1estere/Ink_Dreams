class Category {
  String? name;
  String? link;
  String? desc;

  Category({
    this.name,
    this.link,
    this.desc,
  });
}

class CategoryBlockT {
  String? name;
  String? link;
  String? desc;

  CategoryBlockT({
    this.name,
    this.link,
    this.desc,
  });

  CategoryBlockT.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    link = json['image_link'];
    desc = json['description'];
  }
}
