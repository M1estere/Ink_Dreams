import 'package:flutter/material.dart';

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
    return Container(
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
                child: CircleAvatar(
                  foregroundImage: AssetImage(image),
                  radius: 65,
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
    );
  }
}
