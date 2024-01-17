import 'package:flutter/material.dart';
import 'package:manga_reading/support/users_provider.dart';
import 'package:manga_reading/views/blocks/user_friend_block.dart';
import 'package:manga_reading/views/blocks/user_list_block.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';

class FindFriendView extends StatefulWidget {
  const FindFriendView({super.key});

  @override
  State<FindFriendView> createState() => _FindFriendViewState();
}

class _FindFriendViewState extends State<FindFriendView> {
  List<FindUser> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getAllUsers().then((value) {
      setState(() {
        isLoading = false;
        users = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
                'add friend'.toUpperCase(),
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
            color: Color(0xFF23202B),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  child: SizedBox(
                    height: 65,
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 35,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Search anything...',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 70, 70, 70),
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                        ),
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: !isLoading
                      ? Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          margin: const EdgeInsets.only(bottom: 20),
                          child: ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              return UserListBlock(
                                isInFriendList: false,
                                finished: users[index].finishedManga.length,
                                nickname: users[index].nickname,
                                regDate: users[index].regDate,
                              );
                            },
                            scrollDirection: Axis.vertical,
                          ),
                        )
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
