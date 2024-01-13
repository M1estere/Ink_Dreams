import 'package:flutter/material.dart';
import 'package:manga_reading/views/author_page_view.dart';
import 'package:page_transition/page_transition.dart';

class SearchAuthorBlock extends StatelessWidget {
  final String author;
  final String image;

  const SearchAuthorBlock({
    super.key,
    required this.author,
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
            child: AuthorPageView(
              authorName: author,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          right: 20,
        ),
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.zero,
                child: CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(360),
                    child: Image.network(
                      width: 135,
                      height: 135,
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
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                textAlign: TextAlign.center,
                author,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
