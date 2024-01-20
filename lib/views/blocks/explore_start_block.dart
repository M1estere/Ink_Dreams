import 'package:flutter/material.dart';
import 'package:manga_reading/views/manga_page_view.dart';

class ExploreStartBlock extends StatefulWidget {
  final String title;
  final String image;
  final double factor;

  const ExploreStartBlock({
    super.key,
    required this.title,
    required this.factor,
    required this.image,
  });

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
          MaterialPageRoute(
            builder: (context) => MangaPageView(title: widget.title),
          ),
        );
      },
      child: Center(
        child: SizedBox(
          height: 500 + (widget.factor * 85),
          width: 400,
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                fit: BoxFit.cover,
                widget.image,
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
      ),
    );
  }
}
