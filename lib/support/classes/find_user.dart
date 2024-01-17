import 'package:cloud_firestore/cloud_firestore.dart';

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
