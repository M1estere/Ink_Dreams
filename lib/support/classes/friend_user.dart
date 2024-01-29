import 'package:cloud_firestore/cloud_firestore.dart';

class FriendUser {
  String id;
  String nickname;
  Timestamp regDate;
  Timestamp addDate;
  List finishedManga;
  int favouriteManga;
  String image;

  FriendUser({
    required this.id,
    required this.nickname,
    required this.finishedManga,
    required this.regDate,
    required this.addDate,
    required this.image,
    required this.favouriteManga,
  });
}
