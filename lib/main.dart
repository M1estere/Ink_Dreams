import 'package:flutter/material.dart';
import 'package:manga_reading/views/category_page_view.dart';
import 'package:manga_reading/views/explore_view.dart';
import 'package:manga_reading/views/manga_page_view.dart';
import 'package:manga_reading/views/search_intro_page_view.dart';
import 'package:manga_reading/views/search_results_view.dart';

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
          seedColor: Color(0xFF9D1515),
        ),
        scaffoldBackgroundColor: const Color(0xFF23202B),
        useMaterial3: true,
      ),
      home: const SearchResultsView(),
    );
  }
}
