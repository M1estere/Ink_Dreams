import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:manga_reading/extensions/string_extension.dart';
import 'package:manga_reading/support/auth_provider.dart';
import 'package:manga_reading/support/classes/manga_book.dart';
import 'package:manga_reading/support/classes/manga_book_timed.dart';

Future addToSection(String sectionName, String title) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: currentUser!.id)
      .get();
  List currentTitles = [];

  snapshot.docs.forEach((element) {
    if (element.exists) {
      var data = element.data() as Map<String, dynamic>;
      if (data.containsKey(sectionName)) {
        currentTitles = data[sectionName];
      }
    }
  });

  List resultTitles = [];
  resultTitles.addAll(currentTitles);
  (bool, int) valuesSet = isInList(resultTitles, title);
  if (valuesSet.$1) {
    resultTitles.removeAt(valuesSet.$2);
  } else {
    resultTitles.add(
      {
        'name': title.capitalizeEveryWord(),
        'add_time': DateTime.now().add(
          const Duration(hours: 3),
        ),
      },
    );
  }

  await FirebaseFirestore.instance.collection('users').doc(currentUser!.id).set(
    {'favourites': resultTitles},
    SetOptions(
      merge: true,
    ),
  );
}

Future addToFriends(String id) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: currentUser!.id)
      .get();
  List currentFriends = [];

  snapshot.docs.forEach((element) {
    if (element.exists) {
      var data = element.data() as Map<String, dynamic>;
      if (data.containsKey('friends')) {
        currentFriends = data['friends'];
      }
    }
  });

  List resultFriends = [];
  resultFriends.addAll(currentFriends);
  (bool, int) valuesSet = hasFriend(resultFriends, id);
  if (valuesSet.$1) {
    resultFriends.removeAt(valuesSet.$2);
  } else {
    resultFriends.add(
      {
        'id': id,
        'add_time': DateTime.now().add(
          const Duration(hours: 3),
        ),
      },
    );
  }

  await FirebaseFirestore.instance.collection('users').doc(currentUser!.id).set(
    {'friends': resultFriends},
    SetOptions(
      merge: true,
    ),
  );
}

(bool, int) hasFriend(List list, String id) {
  for (int i = 0; i < list.length; i++) {
    if (list[i]['id'].toString() == id) {
      return (true, i);
    }
  }

  return (false, 0);
}

(bool, int) isInList(List list, String title) {
  for (int i = 0; i < list.length; i++) {
    if (list[i]['name'].toString().toLowerCase() == title.toLowerCase()) {
      return (true, i);
    }
  }

  return (false, 0);
}

Future<List<MangaBookTimed>> getMangaByUserSection(
    String id, String sectionName) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: id)
      .get();

  List currentTitles = [];

  snapshot.docs.forEach((element) {
    if (element.exists) {
      var data = element.data() as Map<String, dynamic>;
      if (data.containsKey(sectionName)) {
        currentTitles = data[sectionName];
      }
    }
  });

  List<MangaBookTimed> result = [];
  if (currentTitles.isNotEmpty) {
    result = await _getMangaByName(currentTitles);
  }

  return result;
}

Future<List<MangaBookTimed>> _getMangaByName(List titles) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  List<MangaBookTimed> result = [];

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;
    for (var i = 0; i < data.length; i++) {
      MangaBookT block = MangaBookT.fromJson(data[i] as Map);

      for (Map<String, dynamic> title in titles) {
        if (title['name'].toString().toLowerCase() ==
            block.title!.toLowerCase()) {
          MangaBookTimed book = MangaBookTimed(
            title: block.title,
            status: block.status,
            image: block.image,
            author: block.author,
            categories: block.categories,
            chapters: block.chapters,
            year: block.year,
            addTime: title['add_time'],
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

Future<bool> mangaInSection(String sectionName, String mangaTitle) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: currentUser!.id)
      .get();

  List currentTitles = [];

  snapshot.docs.forEach((element) {
    if (element.exists) {
      var data = element.data() as Map<String, dynamic>;
      if (data.containsKey(sectionName)) {
        currentTitles = data[sectionName];
      }
    }
  });

  for (Map title in currentTitles) {
    if (title['name'].toString().toLowerCase() == mangaTitle.toLowerCase()) {
      return true;
    }
  }

  return false;
}

Future<bool> idIsFriend(String id) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: currentUser!.id)
      .get();

  List currentFriends = [];

  snapshot.docs.forEach((element) {
    if (element.exists) {
      var data = element.data() as Map<String, dynamic>;
      if (data.containsKey('friends')) {
        currentFriends = data['friends'];
      }
    }
  });

  for (Map title in currentFriends) {
    if (title['id'].toString() == id) {
      return true;
    }
  }

  return false;
}
