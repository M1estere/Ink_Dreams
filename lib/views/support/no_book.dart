import 'package:flutter/material.dart';

class NoBookAnnounce extends StatelessWidget {
  const NoBookAnnounce({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.remove_circle_outline_outlined,
            color: Color(0xFF9D1515),
            size: 80,
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: Text(
              textAlign: TextAlign.center,
              'Sorry, a requested book was not found!',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
