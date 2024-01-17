import 'package:firebase_database/firebase_database.dart';
import 'package:manga_reading/support/classes/author_manga.dart';

Future<List<AuthorManga>> getMangaByAuthor(String authorName) async {
  List<AuthorManga> result = [];

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      AuthorMangaT block = AuthorMangaT.fromJson(data[i] as Map);

      if (block.author!.toLowerCase() == authorName.toLowerCase()) {
        AuthorManga book = AuthorManga(
          title: block.title,
          chaptersAmount: block.chaptersAmount,
          status: block.status,
          genres: block.genres,
          image: block.image,
        );

        result.add(book);
      }
    }
  } else {
    print('No data available.');
  }

  return result;
}
