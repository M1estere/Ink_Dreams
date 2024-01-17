import 'package:firebase_database/firebase_database.dart';
import 'package:manga_reading/support/classes/manga_book.dart';

Future<List<MangaBook>> getMangaBySearch(String query) async {
  query = query.toLowerCase();

  List<MangaBook> result = [];

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      MangaBookT block = MangaBookT.fromJson(data[i] as Map);

      if (block.title!.toLowerCase().contains(query) ||
          block.author!.toLowerCase().contains(query)) {
        MangaBook book = MangaBook(
          title: block.title,
          status: block.status,
          image: block.image,
          author: block.author,
          categories: block.categories,
          chapters: block.chapters,
          year: block.year,
        );

        result.add(book);
      }
    }
  } else {
    print('No data available.');
  }

  return result;
}
