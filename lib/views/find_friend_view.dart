import 'package:flutter/material.dart';
import 'package:manga_reading/support/classes/app_user.dart';
import 'package:manga_reading/support/users_provider.dart';
import 'package:manga_reading/views/blocks/user_list_block.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';
import 'package:manga_reading/views/support/no_books_by_request.dart';

class FindFriendView extends StatefulWidget {
  const FindFriendView({super.key});

  @override
  State<FindFriendView> createState() => _FindFriendViewState();
}

class _FindFriendViewState extends State<FindFriendView> {
  final TextEditingController _searchController = TextEditingController();

  List<AppUser> _users = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    getAllUsers().then((value) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _users = value;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        surfaceTintColor: Theme.of(context).appBarTheme.backgroundColor,
        leadingWidth: MediaQuery.of(context).size.width * .6,
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
                'add friend'.toUpperCase(),
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).snackBarTheme.backgroundColor,
                    border: Border(
                      bottom:
                          Theme.of(context).inputDecorationTheme.outlineBorder!,
                      top:
                          Theme.of(context).inputDecorationTheme.outlineBorder!,
                      left:
                          Theme.of(context).inputDecorationTheme.outlineBorder!,
                      right:
                          Theme.of(context).inputDecorationTheme.outlineBorder!,
                    ),
                  ),
                  child: SizedBox(
                    height: 65,
                    child: TextField(
                      controller: _searchController,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .5,
                      ),
                      decoration: InputDecoration(
                        border: Theme.of(context).inputDecorationTheme.border,
                        focusedBorder: Theme.of(context)
                            .inputDecorationTheme
                            .focusedBorder,
                        enabledBorder: Theme.of(context)
                            .inputDecorationTheme
                            .enabledBorder,
                        errorBorder:
                            Theme.of(context).inputDecorationTheme.errorBorder,
                        disabledBorder: Theme.of(context)
                            .inputDecorationTheme
                            .disabledBorder,
                        prefixIcon: Icon(
                          Icons.search,
                          size: 30,
                          color: Theme.of(context)
                              .inputDecorationTheme
                              .prefixIconColor,
                        ),
                        hintText: 'Search anything...',
                        hintStyle:
                            Theme.of(context).inputDecorationTheme.hintStyle,
                      ),
                      onChanged: (value) {
                        getUsersBySearch(
                                _searchController.text.trim().toLowerCase())
                            .then((value) {
                          if (mounted) {
                            setState(() {
                              _users.clear();
                              _users = value;
                            });
                          }
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: !_isLoading
                      ? _users.isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              margin: const EdgeInsets.only(bottom: 20),
                              child: ListView.builder(
                                itemCount: _users.length,
                                itemBuilder: (context, index) {
                                  return UserListBlock(
                                    id: _users[index].id,
                                    finished:
                                        _users[index].finishedManga.length,
                                    nickname: _users[index].nickname,
                                    regDate: _users[index].regDate,
                                    imagePath: _users[index].image,
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
