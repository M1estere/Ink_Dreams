import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manga_reading/support/user_actions.dart';
import 'package:manga_reading/views/user_account_page_view.dart';

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
      if (mounted) {
        setState(() {
          isLoading = false;
          isInFriendList = value;
        });
      }
    });
  }

  refresh() {
    if (mounted) {
      setState(() {
        isLoading = true;
      });

      idIsFriend(widget.id).then((value) {
        if (mounted) {
          setState(() {
            isLoading = false;
            isInFriendList = value;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          splashColor: Colors.grey.withOpacity(.3),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserAccountPageView(id: widget.id),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border(
                bottom: Theme.of(context).inputDecorationTheme.outlineBorder!,
                top: Theme.of(context).inputDecorationTheme.outlineBorder!,
                left: Theme.of(context).inputDecorationTheme.outlineBorder!,
                right: Theme.of(context).inputDecorationTheme.outlineBorder!,
              ),
            ),
            height: 132,
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
                        width: MediaQuery.of(context).size.width * .2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.red,
                              child: CircleAvatar(
                                radius: 27,
                                backgroundColor: Colors.white,
                              ),
                            ),
                            FittedBox(
                              child: Text(
                                widget.nickname,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
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
                        width: MediaQuery.of(context).size.width * .38,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.book,
                                  color: Colors.red,
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
                                  color: Colors.red,
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
                              if (mounted) {
                                setState(() {
                                  refresh();
                                });
                              }
                            });
                          },
                          icon: Icon(
                            !isInFriendList ? Icons.add : Icons.check,
                            size: 50,
                            color: Theme.of(context).primaryColor,
                          ),
                        )
                      : const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
