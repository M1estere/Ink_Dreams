import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manga_reading/support/auth_provider.dart';
import 'package:manga_reading/support/classes/find_user.dart';
import 'package:manga_reading/support/classes/friend_user.dart';

Future<List<FindUser>> getAllUsers() async {
  List<FindUser> result = [];

  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').get();

  for (var element in snapshot.docs) {
    if (element['id'] == currentUser!.id) continue;
    FindUser user = await _getUser(element['id'], '');

    if (user.id.isNotEmpty) {
      result.add(user);
    }
  }

  return result;
}

Future<List<FindUser>> getUsersBySearch(String query) async {
  List<FindUser> result = [];

  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').get();

  for (var element in snapshot.docs) {
    if (element['id'] == currentUser!.id) continue;
    FindUser user = await _getUser(element['id'], query);

    if (user.id.isNotEmpty) {
      result.add(user);
    }
  }

  return result;
}

Future<List<FriendUser>> getFriends() async {
  List<FriendUser> result = [];

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: currentUser!.id)
      .get();

  List friends = [];
  for (var element in snapshot.docs) {
    if ((element.data() as Map).containsKey('friends')) {
      friends = element['friends'];
    }
  }

  for (var element in friends) {
    result.add(
      await _getFriend(element['id'], element['add_time']),
    );
  }

  return result;
}

Future<FindUser> _getUser(String id, String seqToCheck) async {
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

  if (nickname.toLowerCase().contains(seqToCheck)) {
    result = FindUser(
      id: id,
      email: email,
      nickname: nickname,
      regDate: regDate,
      finishedManga: finished,
    );

    return result;
  }

  return FindUser(
      id: '',
      nickname: '',
      email: '',
      finishedManga: List.empty(),
      regDate: regDate);
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
