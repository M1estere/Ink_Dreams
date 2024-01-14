import 'package:flutter/material.dart';
import 'package:manga_reading/extensions/string_extension.dart';
import 'package:manga_reading/views/category_page_view.dart';
import 'package:page_transition/page_transition.dart';

class CategoryBlock extends StatelessWidget {
  final String image;
  final String title;

  const CategoryBlock({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: CategoryPageView(
                categoryTitle: title,
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 25),
          child: Stack(children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.75),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title.capitalize(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
