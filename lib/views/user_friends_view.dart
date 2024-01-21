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
  List<FriendUser> _friends = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    getFriends().then((value) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _friends = value;
        });
      }
    });
  }

  refresh() {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });

      getFriends().then((value) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _friends = value;
          });
        }
      });
    }
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
                    child: const FindFriendView(),
                    type: PageTransitionType.rightToLeft),
              ).then((value) => refresh());
            },
            icon: Icon(
              Icons.add,
              size: 40,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
        leadingWidth: MediaQuery.of(context).size.width * .75,
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
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 35,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                'friends'.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              children: [
                Expanded(
                  child: !_isLoading
                      ? _friends.isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              margin: const EdgeInsets.only(bottom: 20),
                              child: ListView.builder(
                                itemCount: _friends.length,
                                itemBuilder: (context, index) {
                                  return UserFriendBlock(
                                    id: _friends[index].id,
                                    addDate: _friends[index].addDate,
                                    finished:
                                        _friends[index].finishedManga.length,
                                    nickname: _friends[index].nickname,
                                    regDate: _friends[index].regDate,
                                    imagePath: _friends[index].image,
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
