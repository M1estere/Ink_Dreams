import 'package:flutter/material.dart';
import 'package:manga_reading/support/get_full_manga.dart';
import 'package:manga_reading/views/reader_view.dart';
import 'package:manga_reading/views/support/fetching_circle.dart';
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

  @override
  void initState() {
    super.initState();

    get_manga_by_name(widget.title).then(
      (value) {
        setState(() {
          manga = value;
          isLoading = false;
        });
      },
    );
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
          : SlidingUpPanel(
              maxHeight: MediaQuery.of(context).size.height * .7,
              minHeight: 250,
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
                          width: MediaQuery.of(context).size.width * .75,
                          child: Text(
                            manga.title!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.read_more_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
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
                          return _buildChapterBlock();
                        },
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                  ],
                ),
              ),
              body: Container(
                child: Stack(children: [
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
                ]),
              ),
            ),
    );
  }

  Widget _buildChapterBlock() {
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
              child: ReaderView(filePath: 'test'),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF23202B),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 5, right: 10, left: 5, bottom: 5),
            child: Row(
              children: [
                Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 50,
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chapter 1',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '16 pages',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '2023',
                            style: TextStyle(
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
