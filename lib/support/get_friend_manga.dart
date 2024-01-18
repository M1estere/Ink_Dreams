import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:manga_reading/support/classes/manga_book.dart';
import 'package:manga_reading/support/classes/rated_manga.dart';

Future<List<RatedMangaBook>> getFriendManga(
    String id, String sectionName) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: id)
      .get();

  List currentTitles = [];

  for (var element in snapshot.docs) {
    if (element.exists) {
      var data = element.data() as Map<String, dynamic>;
      if (data.containsKey(sectionName)) {
        currentTitles = data[sectionName];
      }
    }
  }

  List<RatedMangaBook> result = [];
  if (currentTitles.isNotEmpty) {
    result = await _getMangaByName(id, currentTitles);
  }

  return result;
}

Future<List<RatedMangaBook>> _getMangaByName(String id, List titles) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  List<RatedMangaBook> result = [];

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      MangaBookT block = MangaBookT.fromJson(data[i] as Map);

      for (Map<String, dynamic> title in titles) {
        if (title['name'].toString().toLowerCase() ==
            block.title!.toLowerCase()) {
          RatedMangaBook book = RatedMangaBook(
            title: block.title,
            status: block.status,
            image: block.image,
            author: block.author,
            categories: block.categories,
            chapters: block.chapters,
            addTime: title['add_time'],
            desc: block.desc,
            userRate: title['rating'],
          );
          result.add(book);
        }
      }
    }
  } else {
    print('No data available.');
  }

  return result;
}
