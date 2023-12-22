import 'package:flutter/material.dart';
import 'package:manga_reading/views/explore_view.dart';
import 'package:manga_reading/views/manga_page_view.dart';
import 'package:manga_reading/views/search_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.redAccent,
        ),
        useMaterial3: true,
      ),
      home: const SearchPageView(),
    );
  }
}
