import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manga_reading/support/auth_provider.dart';

class FindUser {
  String id;
  String nickname;
  String email;
  Timestamp regDate;
  List finishedManga;

  FindUser({
    required this.id,
    required this.nickname,
    required this.email,
    required this.finishedManga,
    required this.regDate,
  });
}

Future<List<FindUser>> getAllUsers() async {
  List<FindUser> result = [];

  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').get();

  for (var element in snapshot.docs) {
    if (element['id'] == currentUser!.id) continue;
    result.add(await _getUser(element['id']));
  }

  return result;
}

Future<FindUser> _getUser(String id) async {
  FindUser result;

  String nickname = '';
  String email = '';
  Timestamp regDate = Timestamp.fromDate(DateTime.now());
  List finished = [];
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: id)
      .get();

  snapshot.docs.forEach((element) {
    if (element.exists) {
      var data = element.data() as Map<String, dynamic>;
      if (data.containsKey('nickname')) {
        nickname = data['nickname'];
      }
      if (data.containsKey('email')) {
        email = data['email'];
      }
      if (data.containsKey('reg_date')) {
        regDate = data['reg_date'];
      }
      if (data.containsKey('finished')) {
        finished = data['finished'];
      }
    }
  });

  result = FindUser(
    id: id,
    email: email,
    nickname: nickname,
    regDate: regDate,
    finishedManga: finished,
  );

  return result;
}

class FriendUser {
  String id;
  String nickname;
  Timestamp regDate;
  Timestamp addDate;
  List finishedManga;

  FriendUser({
    required this.id,
    required this.nickname,
    required this.finishedManga,
    required this.regDate,
    required this.addDate,
  });
}

Future<List<FriendUser>> getFriends() async {
  List<FriendUser> result = [];

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: currentUser!.id)
      .get();

  List friends = [];
  for (var element in snapshot.docs) {
    friends = element['friends'];
  }
  for (var element in friends) {
    result.add(
      await _getFriend(element['id'], element['add_date']),
    );
  }

  return result;
}

Future<FriendUser> _getFriend(String id, Timestamp addDate) async {
  FriendUser result;

  String nickname = '';
  Timestamp regDate = Timestamp.fromDate(DateTime.now());
  List finished = [];
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: id)
      .get();

  snapshot.docs.forEach((element) {
    if (element.exists) {
      var data = element.data() as Map<String, dynamic>;
      if (data.containsKey('nickname')) {
        nickname = data['nickname'];
      }
      if (data.containsKey('reg_date')) {
        regDate = data['reg_date'];
      }
      if (data.containsKey('finished')) {
        finished = data['finished'];
      }
    }
  });

  result = FriendUser(
    id: id,
    nickname: nickname,
    regDate: regDate,
    addDate: addDate,
    finishedManga: finished,
  );

  return result;
}
