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
  MangaPageFull manga = MangaPageFull();
  int userRate = 0;

  bool isLoading = true;
  bool nullState = false;

  bool isLoadingRating = true;

  bool inFavourites = false;
  bool inPlanned = false;
  bool inFinished = false;

  int totalRating = 0;

  @override
  void initState() {
    super.initState();

    getMangaByName(widget.title).then(
      (value) {
        setState(() {
          manga = value;
        });

        mangaInSection('favourites', widget.title).then((value) {
          setState(() {
            inFavourites = value;
          });

          mangaInSection('planned', widget.title).then((value) {
            setState(() {
              inPlanned = value;
            });

            mangaInSection('finished', widget.title).then((value) {
              setState(() {
                inFinished = value;
              });

              getUserRating(currentUser!.id, widget.title).then((value) {
                setState(() {
                  userRate = value;

                  isLoading = false;
                  if (manga.title == null) {
                    nullState = true;
                  }
                  if ((manga.rates != 0 && manga.rating != 0)) {
                    totalRating = (manga.rating! / manga.rates!).round();
                  }

                  isLoadingRating = false;
                });
              });
            });
          });
        });
      },
    );
  }

  updateRating() {
    getMangaByName(widget.title).then((value) {
      getMangaByName(widget.title).then((value) {
        setState(() {
          manga = value;
        });

        getUserRating(currentUser!.id, widget.title).then((value) {
          setState(() {
            userRate = value;

            print('Rates: ${manga.rates}');
            print('Ratings: ${manga.rating}');
            if (manga.rates != 0) {
              totalRating = (manga.rating! / manga.rates!).round();
            }

            isLoadingRating = false;
          });
        });
      });
    });
  }

  updateMangaSectionStatus(String sectionName) {
    setState(() {
      isLoading = true;
    });

    setState(() {
      if (sectionName.toLowerCase() == 'favourites') {
        inFavourites = !inFavourites;
      } else if (sectionName.toLowerCase() == 'planned') {
        inPlanned = !inPlanned;
      } else if (sectionName.toLowerCase() == 'finished') {
        inFinished = !inFinished;

        if (!inFinished) {
          isLoadingRating = true;
          updateRating();
        }
      }

      isLoading = false;
    });
  }

  placeRating(int amount) {
    setState(() {
      isLoadingRating = true;
    });

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
                  color: const Color.fromRGBO(117, 117, 117, 1), // Colors.white
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Leave your rating!",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
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
          !isLoading
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

                              if (inFavourites) {
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
                                !inFavourites
                                    ? Icons.favorite_border_outlined
                                    : Icons.favorite,
                                color:
                                    !inFavourites ? Colors.black : Colors.red,
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

                              if (inPlanned) {
                                _displaySnackbar('Added manga to planned');
                              } else {
                                _displaySnackbar('Removed manga from planned');
                              }
                            },
                            child: SizedBox(
                              width: 45,
                              height: 45,
                              child: Icon(
                                !inPlanned
                                    ? Icons.access_time_outlined
                                    : Icons.access_time_filled,
                                color: !inPlanned ? Colors.black : Colors.red,
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
      body: isLoading
          ? const FetchingCircle()
          : !nullState
              ? SlidingUpPanel(
                  maxHeight: MediaQuery.of(context).size.height * .8,
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
                          width: MediaQuery.of(context).size.width * .95,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 45,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 25,
                                    child: Text(
                                      manga.author!,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                  !isLoadingRating
                                      ? GestureDetector(
                                          onTap: () {
                                            openDialog(userRate);
                                          },
                                          child: SizedBox(
                                            height: 20,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Icon(
                                                        index < totalRating
                                                            ? Icons.star
                                                            : Icons.star_border,
                                                        color: Colors.yellow,
                                                        size: 20,
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Text(
                                                  '(${manga.rates.toString()})',
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .35,
                                          child:
                                              const LinearProgressIndicator()),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .39,
                              height: 45,
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

                                    if (inFinished) {
                                      openDialog(userRate);
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'finished'.toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Icon(
                                            !inFinished
                                                ? Icons.close
                                                : Icons.check_circle,
                                            color: !inFinished
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
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Text(
                            manga.desc!,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          manga.categories!.toLowerCase(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '${manga.year} | ${manga.chapters!.length} chapters | ${manga.status}',
                          style: const TextStyle(
                              fontSize: 15,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Read Chapters'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Last: 126'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
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
                            itemCount: manga.chapters!.length,
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
                          manga.image!,
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
        style: const TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
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
      backgroundColor: Colors.white,
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
                chapters: manga.chapters,
                index: index,
                filePath: manga.chapters![index]!['link'],
                title: "${manga.title} - v${manga.chapters![index]!['name']}",
                defTitle: "${manga.title}",
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(10),
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
                        "Volume ${manga.chapters![index]!['name']}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Pages: ${manga.chapters![index]!['pages']}",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
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
    );
  }
}
