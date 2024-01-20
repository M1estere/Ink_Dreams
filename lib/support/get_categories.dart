import 'package:firebase_database/firebase_database.dart';
import 'package:manga_reading/views/explore_view.dart';

Future<List<Category>> getCategories() async {
  List<Category> result = [];

  DatabaseReference ref =
      FirebaseDatabase.instance.ref().child('categories_titles');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      CategoryBlockT block = CategoryBlockT.fromJson(data[i] as Map);
      Category category = Category(
        name: block.name,
        link: block.link,
        desc: block.desc,
      );

      result.add(category);
    }
  } else {
    print('No data available.');
  }

  return result;
}
