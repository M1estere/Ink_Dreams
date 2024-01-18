import 'package:firebase_database/firebase_database.dart';
import 'package:manga_reading/support/classes/manga_book.dart';

Future<List<MangaBook>> getMangaByAuthor(String authorName) async {
  List<MangaBook> result = [];

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      MangaBookT block = MangaBookT.fromJson(data[i] as Map);

      if (block.author!.toLowerCase() == authorName.toLowerCase()) {
        MangaBook book = MangaBook(
          title: block.title,
          status: block.status,
          image: block.image,
          author: block.author,
          categories: block.categories,
          chapters: block.chapters,
          desc: block.desc,
          rates: block.rates,
          ratings: block.ratings,
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
