import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manga_reading/views/account_page_view.dart';
import 'package:manga_reading/views/user_account_page_view.dart';
import 'package:page_transition/page_transition.dart';

class UserFriendBlock extends StatelessWidget {
  final String id;
  final String nickname;
  final int finished;
  final Timestamp regDate;
  final Timestamp addDate;

  const UserFriendBlock({
    super.key,
    required this.id,
    required this.nickname,
    required this.finished,
    required this.regDate,
    required this.addDate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: UserAccountPageView(id: id),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        height: 130,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .22,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 27,
                        backgroundColor: Colors.red,
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        nickname,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .05,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.book,
                          color: Color(0xFF8E1617),
                          size: 25,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '$finished finished',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Color(0xFF8E1617),
                          size: 25,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy').format(addDate.toDate()),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.person,
                          color: Color(0xFF8E1617),
                          size: 25,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy').format(regDate.toDate()),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
