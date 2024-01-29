import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manga_reading/views/user_account_page_view.dart';

class UserFriendBlock extends StatelessWidget {
  final String id;
  final String nickname;
  final int finished;
  final int favourites;
  final Timestamp regDate;
  final Timestamp addDate;
  final String imagePath;

  const UserFriendBlock({
    super.key,
    required this.id,
    required this.nickname,
    required this.finished,
    required this.regDate,
    required this.addDate,
    required this.imagePath,
    required this.favourites,
  });

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
                builder: (context) => UserAccountPageView(id: id),
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
            height: 134,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.red,
                          child: CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.red,
                            backgroundImage: Image.network(
                              imagePath,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const Center(
                                    child: SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              },
                            ).image,
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            nickname,
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
                    width: MediaQuery.of(context).size.width * .6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.add,
                                  color: Colors.red,
                                  size: 25,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(addDate.toDate()),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
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
                                  '$finished',
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
                        const SizedBox(
                          height: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
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
                                      .format(regDate.toDate()),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 25,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '$favourites',
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
