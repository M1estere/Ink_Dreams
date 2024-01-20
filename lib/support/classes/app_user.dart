import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  String id;
  String nickname;
  String email;
  Timestamp regDate;
  List finishedManga;
  String image;

  AppUser({
    required this.id,
    required this.nickname,
    required this.email,
    required this.finishedManga,
    required this.regDate,
    required this.image,
  });
}
