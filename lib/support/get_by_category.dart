import 'package:firebase_database/firebase_database.dart';
import 'package:manga_reading/support/classes/manga_book.dart';

Future<List<MangaBook>> getMangaByCategory(String searchCategory) async {
  List<MangaBook> result = [];

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      MangaBookT block = MangaBookT.fromJson(data[i] as Map);

      if (block.categories!.toLowerCase().contains(searchCategory)) {
        MangaBook book = MangaBook(
          title: block.title,
          author: block.author,
          categories: block.categories,
          chapters: block.chapters,
          image: block.image,
          status: block.status,
          rates: block.rates,
          ratings: block.ratings,
          desc: block.desc,
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
