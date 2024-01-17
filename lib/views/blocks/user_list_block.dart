import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manga_reading/support/user_actions.dart';

class UserListBlock extends StatefulWidget {
  final String id;
  final String nickname;
  final int finished;
  final Timestamp regDate;

  const UserListBlock({
    super.key,
    required this.id,
    required this.nickname,
    required this.finished,
    required this.regDate,
  });

  @override
  State<UserListBlock> createState() => _UserListBlockState();
}

class _UserListBlockState extends State<UserListBlock> {
  bool isInFriendList = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    idIsFriend(widget.id).then((value) {
      setState(() {
        isLoading = false;
        isInFriendList = value;
      });
    });
  }

  refresh() {
    setState(() {
      isLoading = true;
    });

    idIsFriend(widget.id).then((value) {
      setState(() {
        isLoading = false;
        isInFriendList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.rightToLeftWithFade,
        //     child: MangaPageView(title: title),
        //   ),
        // ).then((value) {
        //   updateParent();
        // });
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                            widget.nickname,
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
                              '${widget.finished} finished',
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
                              DateFormat('dd/MM/yyyy')
                                  .format(widget.regDate.toDate()),
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
              !isLoading
                  ? IconButton(
                      onPressed: () {
                        addToFriends(widget.id).then((value) {
                          setState(() {
                            refresh();
                          });
                        });
                      },
                      icon: Icon(
                        !isInFriendList ? Icons.add : Icons.check,
                        size: 55,
                        color: Colors.white,
                      ),
                    )
                  : const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
