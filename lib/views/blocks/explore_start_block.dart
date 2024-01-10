import 'package:flutter/material.dart';
import 'package:manga_reading/views/manga_page_view.dart';
import 'package:page_transition/page_transition.dart';

class ExploreStartBlock extends StatefulWidget {
  final String title;
  final double factor;

  const ExploreStartBlock(
      {super.key, required this.title, required this.factor});

  @override
  State<ExploreStartBlock> createState() => _ExploreStartBlockState();
}

class _ExploreStartBlockState extends State<ExploreStartBlock> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: MangaPageView(title: widget.title),
          ),
        );
      },
      child: Center(
        child: SizedBox(
          height: 500 + (widget.factor * 75),
          width: 400,
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage('assets/images/attack.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
