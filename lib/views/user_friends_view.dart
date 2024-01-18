import 'package:flutter/material.dart';
import 'package:manga_reading/support/classes/friend_user.dart';
import 'package:manga_reading/support/users_provider.dart';
import 'package:manga_reading/views/blocks/user_friend_block.dart';
import 'package:manga_reading/views/find_friend_view.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';
import 'package:manga_reading/views/support/no_books_by_request.dart';
import 'package:page_transition/page_transition.dart';

class UserFriendsView extends StatefulWidget {
  const UserFriendsView({
    super.key,
  });

  @override
  State<UserFriendsView> createState() => _UserFriendsViewState();
}

class _UserFriendsViewState extends State<UserFriendsView> {
  List<FriendUser> friends = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getFriends().then((value) {
      setState(() {
        isLoading = false;
        friends = value;
      });
    });
  }

  refresh() {
    setState(() {
      isLoading = true;
    });

    getFriends().then((value) {
      setState(() {
        isLoading = false;
        friends = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                    child: FindFriendView(),
                    type: PageTransitionType.rightToLeft),
              ).then((value) => refresh());
            },
            icon: const Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
          ),
        ],
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 370,
        leading: Container(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                  color: Colors.white,
                ),
              ),
              Text(
                'friends'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFF121212),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              children: [
                Expanded(
                  child: !isLoading
                      ? friends.isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              margin: const EdgeInsets.only(bottom: 20),
                              child: ListView.builder(
                                itemCount: friends.length,
                                itemBuilder: (context, index) {
                                  return UserFriendBlock(
                                    id: friends[index].id,
                                    addDate: friends[index].addDate,
                                    finished:
                                        friends[index].finishedManga.length,
                                    nickname: friends[index].nickname,
                                    regDate: friends[index].regDate,
                                  );
                                },
                                scrollDirection: Axis.vertical,
                              ),
                            )
                          : const NoBooksByRequest()
                      : const FetchingCircle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
