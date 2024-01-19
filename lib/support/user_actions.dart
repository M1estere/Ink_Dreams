import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:manga_reading/extensions/string_extension.dart';
import 'package:manga_reading/support/auth_provider.dart';
import 'package:manga_reading/support/classes/manga_book.dart';
import 'package:manga_reading/support/classes/manga_book_timed.dart';

// manga interaction
Future addRating(String title, int rating) async {
  bool add = true;
  int prevValue = 0;
  await getUserRating(currentUser!.id, title).then((value) {
    add = value == 0 ? true : false;
    prevValue = value;
  });

  DatabaseReference ref = FirebaseDatabase.instance.ref().child('manga_books');

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List data = snapshot.value as List;

    int index = -1;
    for (int i = 0; i < data.length; i++) {
      if (data[i]['title'].toLowerCase() == title.toLowerCase()) {
        index = i;
      }
    }

    if (index != -1) {
      final snapshot = await ref.child(index.toString()).get();
      Map data = snapshot.value as Map;

      int currentRates = data['rates'];
      int currentRating = data['rating'];

      int increment = 0;
      if (rating < 0) {
        increment = -1;
      } else if (rating > 0) {
        increment = 1;
      }

      if (add) {
        ref.child(index.toString()).update(
          {'rates': currentRates + increment, 'rating': currentRating + rating},
        );
      } else {
        ref.child(index.toString()).update(
          {'rates': currentRates, 'rating': currentRating - prevValue + rating},
        );
      }
    }
  }
}

Future<int> getUserRating(String id, String title) async {
  int result = 0;

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: id)
      .get();
  QueryDocumentSnapshot qSnapshot = snapshot.docs[0];

  List finishedTitles = [];
  var data = qSnapshot.data() as Map<String, dynamic>;
  if (data.containsKey('finished')) {
    finishedTitles = data['finished'];
  }

  for (var manga in finishedTitles) {
    if (manga['name'].toString().toLowerCase() == title.toLowerCase()) {
      result = manga['rating'];
    }
  }

  return result;
}

Future<Timestamp> getFinishTime(String id, String title) async {
  Timestamp result = Timestamp.now();

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: id)
      .get();
  QueryDocumentSnapshot qSnapshot = snapshot.docs[0];

  List finishedTitles = [];
  var data = qSnapshot.data() as Map<String, dynamic>;
  if (data.containsKey('finished')) {
    finishedTitles = data['finished'];
  }

  for (var manga in finishedTitles) {
    if (manga['name'].toString().toLowerCase() == title.toLowerCase()) {
      result = manga['add_time'];
    }
  }

  return result;
}

Future addToFinished(String title, int rating) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: currentUser!.id)
      .get();

  QueryDocumentSnapshot qSnapshot = snapshot.docs[0];

  List finishedTitles = [];
  var data = qSnapshot.data() as Map<String, dynamic>;
  if (data.containsKey('finished')) {
    finishedTitles = data['finished'];

    int index = -1;
    for (int i = 0; i < finishedTitles.length; i++) {
      if (finishedTitles[i]['name'].toString().toLowerCase() ==
          title.toLowerCase()) {
        index = i;
      }
    }

    if (index != -1) {
      finishedTitles[index]['rating'] = rating;
    } else {
      finishedTitles.add({
        'name': title.capitalizeEveryWord(),
        'add_time': DateTime.now().add(const Duration(hours: 3)),
        'rating': rating,
      });
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.id)
        .set(
      {'finished': finishedTitles},
      SetOptions(merge: true),
    );
  } else {
    List res = [
      {
        'name': title.capitalizeEveryWord(),
        'add_time': DateTime.now().add(const Duration(hours: 3)),
        'rating': rating,
      }
    ];
    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.id)
        .set(
      {'finished': res},
      SetOptions(
        merge: true,
      ),
    );
  }
}

Future addToSection(String sectionName, String title) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: currentUser!.id)
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

  List resultTitles = [];
  resultTitles.addAll(currentTitles);
  (bool, int) valuesSet = isInList(resultTitles, title);
  if (valuesSet.$1) {
    if (sectionName == 'finished') {
      int index = valuesSet.$2;
      int userRating = resultTitles[index]['rating'];

      addRating(title, -userRating);
    }
    resultTitles.removeAt(valuesSet.$2);
  } else {
    if (sectionName == 'finished') {
      resultTitles.add(
        {
          'name': title.capitalizeEveryWord(),
          'add_time': DateTime.now().add(
            const Duration(hours: 3),
          ),
          'rating': 0,
        },
      );
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
  }

  await FirebaseFirestore.instance.collection('users').doc(currentUser!.id).set(
    {sectionName: resultTitles},
    SetOptions(
      merge: true,
    ),
  );
}

Future addToReadingSection(String lastChapter, String title) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: currentUser!.id)
      .get();
  List currentTitles = [];

  for (var element in snapshot.docs) {
    if (element.exists) {
      var data = element.data() as Map<String, dynamic>;
      if (data.containsKey('reading')) {
        currentTitles = data['reading'];
      }
    }
  }

  List resultTitles = [];
  resultTitles.addAll(currentTitles);
  (bool, int) valuesSet = isInList(resultTitles, title);
  if (valuesSet.$1) {
    resultTitles.removeAt(valuesSet.$2);
  }
  resultTitles.add(
    {
      'name': title.capitalizeEveryWord(),
      'add_time': DateTime.now().add(
        const Duration(hours: 3),
      ),
      'last': lastChapter,
    },
  );

  await FirebaseFirestore.instance.collection('users').doc(currentUser!.id).set(
    {'reading': resultTitles},
    SetOptions(
      merge: true,
    ),
  );
}

Future removeFromReading(String title) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: currentUser!.id)
      .get();
  List currentTitles = [];

  for (var element in snapshot.docs) {
    if (element.exists) {
      var data = element.data() as Map<String, dynamic>;
      if (data.containsKey('reading')) {
        currentTitles = data['reading'];
      }
    }
  }

  List resultTitles = [];
  resultTitles.addAll(currentTitles);
  (bool, int) valuesSet = isInList(resultTitles, title);
  if (valuesSet.$1) {
    resultTitles.removeAt(valuesSet.$2);

    await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.id)
        .set(
      {'reading': resultTitles},
      SetOptions(
        merge: true,
      ),
    );
  }
}

Future<String> getLastChapter(String title, String id) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: id)
      .get();
  List currentTitles = [];

  for (var element in snapshot.docs) {
    if (element.exists) {
      var data = element.data() as Map<String, dynamic>;
      if (data.containsKey('reading')) {
        currentTitles = data['reading'];
      }
    }
  }

  String result = '';
  for (var manga in currentTitles) {
    if (manga['name'].toString().toLowerCase() == title.toLowerCase()) {
      result = manga['last'];
    }
  }

  return result;
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

  for (var element in snapshot.docs) {
    if (element.exists) {
      var data = element.data() as Map<String, dynamic>;
      if (data.containsKey(sectionName)) {
        currentTitles = data[sectionName];
      }
    }
  }

  List<MangaBookTimed> result = [];
  if (currentTitles.isNotEmpty) {
    result = await _getMangaByName(currentTitles);
  }

  return result;
}

Future<bool> mangaInSection(String sectionName, String mangaTitle) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: currentUser!.id)
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

  for (Map title in currentTitles) {
    if (title['name'].toString().toLowerCase() == mangaTitle.toLowerCase()) {
      return true;
    }
  }

  return false;
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
            desc: block.desc,
            rates: block.rates,
            ratings: block.ratings,
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

// friends interaction
Future addToFriends(String id) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: currentUser!.id)
      .get();
  List currentFriends = [];

  for (var element in snapshot.docs) {
    if (element.exists) {
      var data = element.data() as Map<String, dynamic>;
      if (data.containsKey('friends')) {
        currentFriends = data['friends'];
      }
    }
  }

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

Future<bool> idIsFriend(String id) async {
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: currentUser!.id)
      .get();

  List currentFriends = [];

  for (var element in snapshot.docs) {
    if (element.exists) {
      var data = element.data() as Map<String, dynamic>;
      if (data.containsKey('friends')) {
        currentFriends = data['friends'];
      }
    }
  }

  for (Map title in currentFriends) {
    if (title['id'].toString() == id) {
      return true;
    }
  }

  return false;
}

(bool, int) hasFriend(List list, String id) {
  for (int i = 0; i < list.length; i++) {
    if (list[i]['id'].toString() == id) {
      return (true, i);
    }
  }

  return (false, 0);
}
