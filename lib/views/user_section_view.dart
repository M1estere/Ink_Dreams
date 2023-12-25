import 'package:flutter/material.dart';
import 'package:manga_reading/views/blocks/user_section_block.dart';

class UserSectionView extends StatefulWidget {
  final String sectionName;
  const UserSectionView({super.key, required this.sectionName});

  @override
  State<UserSectionView> createState() => _UserSectionViewState();
}

class _UserSectionViewState extends State<UserSectionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 270,
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
                widget.sectionName.toUpperCase(),
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  margin: const EdgeInsets.only(bottom: 20),
                  height: MediaQuery.of(context).size.height * .7,
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      UserSectionBlock(
                        title: 'Attack On Titan',
                        addDateTime: DateTime.now().add(
                          const Duration(hours: 3),
                        ),
                        chapters: 162,
                        status: 'Finished',
                        author: 'Hajime Isayama',
                        image: 'assets/images/attack.jpg',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
