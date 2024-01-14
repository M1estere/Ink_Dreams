import 'package:flutter/material.dart';

class AuthorMangaBlock extends StatelessWidget {
  final String title;
  final String status;
  final int chapters;
  final String author;
  final String image;
  final String genres;

  const AuthorMangaBlock({
    super.key,
    required this.title,
    required this.chapters,
    required this.status,
    required this.author,
    required this.image,
    required this.genres,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          bottom: 15,
          left: 15,
          right: 3,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 170,
              width: 120,
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
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      author,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Chapters: ',
                        style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: chapters.toString(),
                            style: const TextStyle(
                              color: Color(0xFF9D1515),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Status: ',
                        style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: status,
                            style: const TextStyle(
                                color: Color(0xFF9D1515),
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Genres: ',
                        style: const TextStyle(
                          fontSize: 15,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: genres,
                            style: const TextStyle(
                                color: Color(0xFF9D1515),
                                letterSpacing: 1,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 170,
              width: 80,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite),
                    iconSize: 40,
                    color: Colors.white,
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
