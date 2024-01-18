import 'package:flutter/material.dart';
import 'package:manga_reading/views/manga_page_view.dart';
import 'package:page_transition/page_transition.dart';

class SearchMangaBlock extends StatelessWidget {
  final String title;
  final String releaseYear;
  final String image;

  const SearchMangaBlock({
    super.key,
    required this.title,
    required this.releaseYear,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: MangaPageView(title: title),
          ),
        );
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .45,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 280,
              margin: const EdgeInsets.only(right: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  fit: BoxFit.cover,
                  image,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Center(
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 2.5,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.5,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    releaseYear,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.5,
                      height: 1.2,
                    ),
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
