import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:manga_reading/extensions/string_extension.dart';
import 'package:manga_reading/support/auth_provider.dart';
import 'package:manga_reading/support/classes/manga_page.dart';
import 'package:manga_reading/support/get_full_manga.dart';
import 'package:manga_reading/support/user_actions.dart';
import 'package:manga_reading/views/reader_view.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';
import 'package:manga_reading/views/support/no_book.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MangaPageView extends StatefulWidget {
  final String title;

  const MangaPageView({
    super.key,
    required this.title,
  });

  @override
  State<MangaPageView> createState() => _MangaPageViewState();
}

class _MangaPageViewState extends State<MangaPageView> {
  MangaPageFull _manga = MangaPageFull();
  int _userRate = 0;

  bool _isLoading = true;
  bool _nullState = false;

  bool _isLoadingRating = true;

  bool _inFavourites = false;
  bool _inPlanned = false;
  bool _inFinished = false;

  int _totalRating = 0;

  bool _hasLastChapter = false;
  String _lastChapter = '';

  int _lastChapterIndex = 0;

  int getLastChapterIndex() {
    for (int i = 0; i < _manga.chapters!.length; i++) {
      if (_manga.chapters![i]!['name'] == _lastChapter) {
        return i;
      }
    }

    return 0;
  }

  @override
  void initState() {
    super.initState();

    getMangaByName(widget.title).then(
      (value) {
        if (mounted) {
          setState(() {
            _manga = value;
          });

          mangaInSection('favourites', widget.title).then((value) {
            if (mounted) {
              setState(() {
                _inFavourites = value;
              });

              mangaInSection('planned', widget.title).then((value) {
                if (mounted) {
                  setState(() {
                    _inPlanned = value;
                  });

                  mangaInSection('finished', widget.title).then((value) {
                    if (mounted) {
                      setState(() {
                        _inFinished = value;
                      });

                      getUserRating(currentUser!.id, widget.title)
                          .then((value) {
                        if (mounted) {
                          setState(() {
                            _userRate = value;

                            _isLoadingRating = false;
                          });

                          getLastChapter(widget.title, currentUser!.id)
                              .then((value) {
                            if (mounted) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  _hasLastChapter = true;
                                  _lastChapter = value;
                                }

                                _isLoading = false;
                                if (_manga.title == null) {
                                  _nullState = true;
                                }
                                if ((_manga.rates != 0 && _manga.rating != 0)) {
                                  _totalRating =
                                      (_manga.rating! / _manga.rates!).round();
                                }

                                _lastChapterIndex = getLastChapterIndex();
                              });
                            }
                          });
                        }
                      });
                    }
                  });
                }
              });
            }
          });
        }
      },
    );
  }

  updateLast() {
    getLastChapter(widget.title, currentUser!.id).then((value) {
      if (mounted) {
        setState(() {
          if (value.isNotEmpty) {
            _hasLastChapter = true;
            _lastChapter = value;
            _lastChapterIndex = getLastChapterIndex();
          } else {
            _hasLastChapter = false;
          }
        });
      }
    });
  }

  updateRating() {
    getMangaByName(widget.title).then((value) {
      getMangaByName(widget.title).then((value) {
        if (mounted) {
          setState(() {
            _manga = value;
          });

          getUserRating(currentUser!.id, widget.title).then((value) {
            if (mounted) {
              setState(() {
                _userRate = value;

                if (_manga.rates != 0) {
                  _totalRating = (_manga.rating! / _manga.rates!).round();
                }

                _isLoadingRating = false;
              });
            }
          });
        }
      });
    });
  }

  updateMangaSectionStatus(String sectionName) {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });

      setState(() {
        if (sectionName.toLowerCase() == 'favourites') {
          _inFavourites = !_inFavourites;
        } else if (sectionName.toLowerCase() == 'planned') {
          _inPlanned = !_inPlanned;
        } else if (sectionName.toLowerCase() == 'finished') {
          _inFinished = !_inFinished;

          if (!_inFinished) {
            _isLoadingRating = true;
            updateRating();
          }
        }

        _isLoading = false;
      });
    }
  }

  placeRating(int amount) {
    if (mounted) {
      setState(() {
        _isLoadingRating = true;
      });
    }

    addRating(widget.title, amount).then((value) {
      updateRating();
    });
  }

  Future openDialog(int value) => showDialog(
        context: context,
        builder: (context) => Dialog(
          alignment: Alignment.bottomCenter,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .13,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .snackBarTheme
                      .backgroundColor, // 0xFF252525
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Leave your rating!",
                      style: TextStyle(
                        fontSize: 24,
                        color: Theme.of(context)
                            .snackBarTheme
                            .contentTextStyle!
                            .color,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .06,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context2, index) {
                          return IconButton(
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              placeRating(index + 1);
                              addToFinished(widget.title, index + 1);

                              if (mounted) {
                                setState(() {
                                  _inFinished = !_inFinished;
                                });
                              }
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              index < value ? Icons.star : Icons.star_border,
                              color: Colors.yellow,
                              size: 50,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 180,
        leading: Container(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
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
            ],
          ),
        ),
        actions: [
          !_isLoading
              ? Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.white, // Button color
                          child: InkWell(
                            splashColor: Colors.grey, // Splash color
                            onTap: () {
                              addToSection('favourites', widget.title);
                              updateMangaSectionStatus('favourites');

                              if (_inFavourites) {
                                _displaySnackbar('Added manga to favourites');
                              } else {
                                _displaySnackbar(
                                    'Removed manga from favourites');
                              }
                            },
                            child: SizedBox(
                              width: 45,
                              height: 45,
                              child: Icon(
                                !_inFavourites
                                    ? Icons.favorite_border_outlined
                                    : Icons.favorite,
                                color:
                                    !_inFavourites ? Colors.black : Colors.red,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ClipOval(
                        child: Material(
                          color: Colors.white, // Button color
                          child: InkWell(
                            splashColor: Colors.grey, // Splash color
                            onTap: () {
                              addToSection('planned', widget.title);
                              updateMangaSectionStatus('planned');

                              if (_inPlanned) {
                                _displaySnackbar('Added manga to planned');
                              } else {
                                _displaySnackbar('Removed manga from planned');
                              }
                            },
                            child: SizedBox(
                              width: 45,
                              height: 45,
                              child: Icon(
                                !_inPlanned
                                    ? Icons.access_time_outlined
                                    : Icons.access_time_filled,
                                color: !_inPlanned ? Colors.black : Colors.red,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(),
        ],
      ),
      body: _isLoading
          ? const FetchingCircle()
          : !_nullState
              ? SlidingUpPanel(
                  maxHeight: MediaQuery.of(context).size.height * .85,
                  minHeight: 200,
                  color: Colors.transparent,
                  backdropOpacity: 0,
                  backdropEnabled: false,
                  panel: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 25,
                                child: Text(
                                  _manga.author!,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                              !_isLoadingRating
                                  ? GestureDetector(
                                      onTap: () {
                                        openDialog(_userRate);
                                      },
                                      child: SizedBox(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .35,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .27,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: 5,
                                                itemBuilder: (context, index) {
                                                  return Icon(
                                                    index < _totalRating
                                                        ? Icons.star
                                                        : Icons.star_border,
                                                    color: Colors.yellow,
                                                    size: 20,
                                                  );
                                                },
                                              ),
                                            ),
                                            Text(
                                              '(${_manga.rates.toString()})',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.only(top: 5),
                                      height: 3,
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      child: const LinearProgressIndicator(),
                                    ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        SizedBox(
                          child: Text(
                            _manga.desc!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          _manga.categories!.toLowerCase(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '${_manga.year} | ${_manga.chapters!.length} chapters | ${_manga.status}',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 61,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Read Chapters'.toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    _hasLastChapter
                                        ? SizedBox(
                                            height: 30,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'LAST: vol.$_lastChapter',
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    removeFromReading(
                                                        widget.title);
                                                    if (mounted) {
                                                      setState(() {
                                                        _hasLastChapter = false;
                                                        _lastChapter = '';
                                                        _lastChapterIndex = 0;
                                                      });
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                    size: 30,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : const Center(),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                width: MediaQuery.of(context).size.width * .29,
                                height: double.infinity,
                                child: Material(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                  child: InkWell(
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomLeft: Radius.circular(12),
                                    ),
                                    splashColor: Colors.grey, // Splash color
                                    onTap: () {
                                      addToSection('finished', widget.title);
                                      updateMangaSectionStatus('finished');

                                      if (_inFinished) {
                                        openDialog(_userRate);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'done'.toUpperCase(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .12,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .12,
                                            child: Icon(
                                              !_inFinished
                                                  ? Icons.close
                                                  : Icons.check_circle,
                                              color: !_inFinished
                                                  ? Colors.black
                                                  : Colors.red,
                                              size: 35,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // chapter block
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.only(
                              top: 0,
                            ),
                            itemCount: _manga.chapters!.length,
                            itemBuilder: (context, index) {
                              return _buildChapterBlock(index);
                            },
                            scrollDirection: Axis.vertical,
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: Stack(
                    children: [
                      ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: 2.5,
                          sigmaY: 2.5,
                        ),
                        child: Image.network(
                          height: double.infinity,
                          _manga.image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(.8),
                              Colors.black.withOpacity(.8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const NoBookAnnounce(),
    );
  }

  _displaySnackbar(String content) {
    var snackBar = SnackBar(
      content: Text(
        content.capitalize(),
        style: Theme.of(context).snackBarTheme.contentTextStyle,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 1,
      duration: const Duration(
        seconds: 3,
      ),
      backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildChapterBlock(int index) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: ReaderView(
                chapters: _manga.chapters,
                index: index,
                filePath: _manga.chapters![index]!['link'],
                confTitle: '${_manga.chapters![index]!['name']}',
                title: "${_manga.title} - v${_manga.chapters![index]!['name']}",
                defTitle: "${_manga.title}",
                updateFunc: updateLast,
              ),
            ),
          ).then((value) {
            updateLast();
          });
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF252525),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _manga.chapters![index]!['name'] == _lastChapter
                  ? Colors.white
                  : const Color(0xFF252525),
              width: 1,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 5, right: 10, left: 5, bottom: 5),
            child: Row(
              children: [
                const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 50,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Volume ${_manga.chapters![index]!['name']}"
                            .toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "PAGES: ${_manga.chapters![index]!['pages']}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                index < _lastChapterIndex
                    ? const Icon(
                        Icons.check_circle_outline,
                        color: Colors.grey,
                        size: 30,
                      )
                    : const Center(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
