import 'package:flutter/material.dart';
import 'package:manga_reading/support/get_friend_manga.dart';
import 'package:manga_reading/support/user_actions.dart';
import 'package:manga_reading/views/blocks/rated_manga_block.dart';
import 'package:manga_reading/views/blocks/user_section_block.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';
import 'package:manga_reading/views/support/no_books_by_request.dart';

class UserSectionView extends StatefulWidget {
  final String sectionName;
  final String userName;
  final String id;

  const UserSectionView({
    super.key,
    required this.id,
    required this.sectionName,
    required this.userName,
  });

  @override
  State<UserSectionView> createState() => _UserSectionViewState();
}

class _UserSectionViewState extends State<UserSectionView> {
  List _mangaBooks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    if (widget.sectionName.contains('finished')) {
      getFriendManga(widget.id, widget.sectionName).then((value) {
        if (mounted) {
          setState(() {
            _mangaBooks = value;
            _isLoading = false;
          });
        }
      });
    } else {
      getMangaByUserSection(widget.id, widget.sectionName).then((value) {
        if (mounted) {
          setState(() {
            _mangaBooks = value;
            _isLoading = false;
          });
        }
      });
    }
  }

  refresh() {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });

      if (widget.sectionName.contains('finished')) {
        getFriendManga(widget.id, widget.sectionName).then((value) {
          if (mounted) {
            setState(() {
              _mangaBooks = value;
              _isLoading = false;
            });
          }
        });
      } else {
        getMangaByUserSection(widget.id, widget.sectionName).then((value) {
          if (mounted) {
            setState(() {
              _mangaBooks = value;
              _isLoading = false;
            });
          }
        });
      }
    }
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
        leadingWidth: MediaQuery.of(context).size.width * .9,
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
              SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: FittedBox(
                  child: Text(
                    '${widget.sectionName} [${widget.userName}]'.toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      letterSpacing: 0,
                    ),
                  ),
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
            child: !_isLoading
                ? _mangaBooks.isNotEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              margin: const EdgeInsets.only(bottom: 20),
                              child: ListView.builder(
                                itemCount: _mangaBooks.length,
                                itemBuilder: (context, index) {
                                  return !widget.sectionName
                                          .contains('finished')
                                      ? UserSectionBlock(
                                          title: _mangaBooks[index].title!,
                                          desc: _mangaBooks[index].desc!,
                                          addDate: _mangaBooks[index].addTime!,
                                          chapters:
                                              _mangaBooks[index].chapters!,
                                          status: _mangaBooks[index].status!,
                                          author: _mangaBooks[index].author!,
                                          updateFunc: refresh,
                                          image: _mangaBooks[index].image!,
                                        )
                                      : RatedMangaBlock(
                                          finishDate:
                                              _mangaBooks[index].addTime!,
                                          title: _mangaBooks[index].title!,
                                          chapters:
                                              _mangaBooks[index].chapters!,
                                          status: _mangaBooks[index].status!,
                                          author: _mangaBooks[index].author!,
                                          image: _mangaBooks[index].image!,
                                          userRate:
                                              _mangaBooks[index].userRate!,
                                          desc: _mangaBooks[index].desc!,
                                          updateFunc: refresh,
                                        );
                                },
                                scrollDirection: Axis.vertical,
                              ),
                            ),
                          ),
                        ],
                      )
                    : const NoBooksByRequest()
                : const FetchingCircle(),
          ),
        ),
      ),
    );
  }
}
