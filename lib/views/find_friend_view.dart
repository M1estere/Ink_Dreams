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
  TextEditingController searchController = TextEditingController();

  List<AppUser> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getAllUsers().then((value) {
      if (mounted) {
        setState(() {
          isLoading = false;
          users = value;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 55,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
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
                    color: const Color(0xFF252525),
                  ),
                  child: SizedBox(
                    height: 65,
                    child: TextField(
                      controller: searchController,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .5,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          size: 35,
                          color: Color(0xFFA2A2A2),
                        ),
                        hintText: 'Search anything...',
                        hintStyle: TextStyle(
                          color: Color(0xFFA2A2A2),
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          letterSpacing: .5,
                        ),
                      ),
                      onChanged: (value) {
                        getUsersBySearch(
                                searchController.text.trim().toLowerCase())
                            .then((value) {
                          if (mounted) {
                            setState(() {
                              users.clear();
                              users = value;
                            });
                          }
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: !isLoading
                      ? users.isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              margin: const EdgeInsets.only(bottom: 20),
                              child: ListView.builder(
                                itemCount: users.length,
                                itemBuilder: (context, index) {
                                  return UserListBlock(
                                    id: users[index].id,
                                    finished: users[index].finishedManga.length,
                                    nickname: users[index].nickname,
                                    regDate: users[index].regDate,
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
