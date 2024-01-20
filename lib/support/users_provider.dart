import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manga_reading/support/auth_provider.dart';
import 'package:manga_reading/support/classes/app_user.dart';
import 'package:manga_reading/support/classes/friend_user.dart';

Future<List<AppUser>> getAllUsers() async {
  List<AppUser> result = [];

  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').get();

  for (var element in snapshot.docs) {
    if (element['id'] == currentUser!.id) continue;
    AppUser user = await _getUser(element['id'], '');

    if (user.id.isNotEmpty) {
      result.add(user);
    }
  }

  return result;
}

Future<List<AppUser>> getUsersBySearch(String query) async {
  List<AppUser> result = [];

  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').get();

  for (var element in snapshot.docs) {
    if (element['id'] == currentUser!.id) continue;
    AppUser user = await _getUser(element['id'], query);

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

Future<AppUser> _getUser(String id, String seqToCheck) async {
  AppUser result;

  String nickname = '';
  String email = '';
  Timestamp regDate = Timestamp.fromDate(DateTime.now());
  List finished = [];
  String image = '';
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: id)
      .get();

  for (var element in snapshot.docs) {
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
      if (data.containsKey('image')) {
        image = data['image'];
      }
    }
  }

  if (nickname.toLowerCase().contains(seqToCheck)) {
    result = AppUser(
      id: id,
      email: email,
      nickname: nickname,
      regDate: regDate,
      finishedManga: finished,
      image: image,
    );

    return result;
  }

  return AppUser(
    id: '',
    nickname: '',
    email: '',
    finishedManga: List.empty(),
    regDate: regDate,
    image: '',
  );
}

Future<FriendUser> _getFriend(String id, Timestamp addDate) async {
  FriendUser result;

  String nickname = '';
  Timestamp regDate = Timestamp.fromDate(DateTime.now());
  List finished = [];
  String image = '';
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('id', isEqualTo: id)
      .get();

  for (var element in snapshot.docs) {
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
      if (data.containsKey('image')) {
        image = data['image'];
      }
    }
  }

  result = FriendUser(
    id: id,
    nickname: nickname,
    regDate: regDate,
    addDate: addDate,
    finishedManga: finished,
    image: image,
  );

  return result;
}
