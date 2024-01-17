import 'package:firebase_database/firebase_database.dart';
import 'package:manga_reading/support/classes/manga_page.dart';

List<Map> getChapters(List json) {
  List<Map> result = [];

  for (var i = 0; i < json.length; i++) {
    Map temp = {};
    temp['name'] = json[i]['name'];
    temp['link'] = json[i]['link'];
    temp['pages'] = json[i]['pages'];

    result.add(temp);
  }

  return result;
}

Future<MangaPageFull> getMangaByName(String name) async {
  MangaPageFull result = MangaPageFull();

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      MangaPageFullT block = MangaPageFullT.fromJson(data[i] as Map);

      if (block.title!.toLowerCase() == name.toLowerCase()) {
        MangaPageFull book = MangaPageFull(
          title: block.title,
          author: block.author,
          categories: block.categories,
          chapters: block.chapters,
          image: block.image,
          status: block.status,
          year: block.year,
          desc: block.desc,
          rates: block.rates,
          rating: block.rating,
        );

        result = book;
        break;
      }
    }
  } else {
    print('No data available.');
  }

  return result;
}
