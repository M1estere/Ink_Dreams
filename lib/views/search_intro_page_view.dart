import 'package:flutter/material.dart';
import 'package:manga_reading/views/blocks/search_author_block.dart';
import 'package:manga_reading/views/blocks/search_manga_block.dart';

class SearchIntroPageView extends StatefulWidget {
  const SearchIntroPageView({super.key});

  @override
  State<SearchIntroPageView> createState() => _SearchIntroPageViewState();
}

class _SearchIntroPageViewState extends State<SearchIntroPageView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Popular',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w400),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 360,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SearchMangaBlock(
                    title: 'Attack On Titan',
                    releaseYear: '2023',
                    image: 'assets/images/attack.jpg',
                  ),
                  SearchMangaBlock(
                    title: 'Attack 2 Titan',
                    releaseYear: '2023',
                    image: 'assets/images/attack.jpg',
                  ),
                  SearchMangaBlock(
                    title: 'Attack On Titan',
                    releaseYear: '2023',
                    image: 'assets/images/attack.jpg',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Hottest',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w400),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 360,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SearchMangaBlock(
                    title: 'Attack On Titan',
                    releaseYear: '2023',
                    image: 'assets/images/attack.jpg',
                  ),
                  SearchMangaBlock(
                    title: 'Attack On Titan',
                    releaseYear: '2023',
                    image: 'assets/images/attack.jpg',
                  ),
                  SearchMangaBlock(
                    title: 'Attack On Titan',
                    releaseYear: '2023',
                    image: 'assets/images/attack.jpg',
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Best Authors',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w400),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SearchAuthorBlock(
                    author: 'Hidetaka Babadzaki',
                    image: 'assets/images/attack.jpg',
                  ),
                  SearchAuthorBlock(
                    author: 'Hidetaka Babadzaki 2',
                    image: 'assets/images/attack.jpg',
                  ),
                  SearchAuthorBlock(
                    author: 'Hidetaka Babadzaki 3',
                    image: 'assets/images/attack.jpg',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
