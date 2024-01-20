import 'package:flutter/material.dart';
import 'package:manga_reading/views/manga_page_view.dart';

class FullMangaBlock extends StatelessWidget {
  final String title;
  final String status;
  final int chapters;
  final String author;
  final String image;
  final String desc;
  final int rates;
  final int ratings;
  final String releaseYear;

  const FullMangaBlock({
    super.key,
    required this.title,
    required this.chapters,
    required this.status,
    required this.author,
    required this.image,
    required this.desc,
    required this.rates,
    required this.ratings,
    required this.releaseYear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border(
          bottom: Theme.of(context).inputDecorationTheme.outlineBorder!,
          top: Theme.of(context).inputDecorationTheme.outlineBorder!,
          left: Theme.of(context).inputDecorationTheme.outlineBorder!,
          right: Theme.of(context).inputDecorationTheme.outlineBorder!,
        ),
      ),
      height: MediaQuery.of(context).size.height * .25,
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
        child: InkWell(
          splashColor: Colors.grey.withOpacity(.3),
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MangaPageView(title: title),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 15,
              left: 15,
              right: 15,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width * .33,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
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
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .48,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  height: 1,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              author,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .17,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.book,
                                        color: Colors.red,
                                        size: 22,
                                      ),
                                      Text(
                                        chapters.toString(),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.red,
                                      size: 22,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      rates != 0
                                          ? (ratings / rates).toStringAsFixed(1)
                                          : '0',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              desc,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 4,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Status: ',
                                style: const TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: status,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
