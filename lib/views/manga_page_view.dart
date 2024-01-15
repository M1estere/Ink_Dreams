import 'package:flutter/material.dart';
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
  bool isLoading = true;
  bool nullState = false;

  bool inFavourites = false;
  bool inPlanned = false;

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

            isLoading = false;
            if (manga.title == null) {
              nullState = true;
            }
          });
        });
      },
    );
  }

  updateMangaSectionStatus(String sectionName) {
    setState(() {
      if (sectionName.toLowerCase() == 'favourites') {
        inFavourites = !inFavourites;
      } else if (sectionName.toLowerCase() == 'later') {
        inPlanned = !inPlanned;
      }
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
        leadingWidth: 180,
        leading: Container(
          padding: const EdgeInsets.only(left: 10, top: 10),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .55,
                              child: Text(
                                manga.title!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipOval(
                                  child: Material(
                                    color: Colors.white, // Button color
                                    child: InkWell(
                                      splashColor: Colors.grey, // Splash color
                                      onTap: () {
                                        addToSection(
                                            'favourites', widget.title);
                                        updateMangaSectionStatus('favourites');
                                      },
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Icon(
                                          !inFavourites
                                              ? Icons.favorite_border_outlined
                                              : Icons.favorite,
                                          color: !inFavourites
                                              ? Colors.black
                                              : const Color(0xFF8E1617),
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                ClipOval(
                                  child: Material(
                                    color: Colors.white, // Button color
                                    child: InkWell(
                                      splashColor: Colors.grey, // Splash color
                                      onTap: () {
                                        addToSection('later', widget.title);
                                        updateMangaSectionStatus('later');
                                      },
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Icon(
                                          !inPlanned
                                              ? Icons.access_time_outlined
                                              : Icons.access_time_filled,
                                          color: !inPlanned
                                              ? Colors.black
                                              : const Color(0xFF8E1617),
                                          size: 35,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          child: Text(
                            manga.desc!,
                            style: TextStyle(
                              color: Colors.grey[500],
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
                              color: Colors.grey),
                        ),
                        Text(
                          '${manga.year} | ${manga.chapters!.length} chapters | ${manga.status}',
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Read Chapters',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
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
                      Image.network(
                        height: double.infinity,
                        manga.image!,
                        fit: BoxFit.cover,
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
                title: "${manga.title} [${manga.chapters![index]!['name']}]",
                defTitle: "${manga.title}",
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF23202B),
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
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
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
