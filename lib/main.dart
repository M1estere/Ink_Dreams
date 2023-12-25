import 'package:flutter/material.dart';
import 'package:manga_reading/views/main_app_wrapper.dart';

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
          seedColor: const Color(0xFF9D1515),
        ),
        scaffoldBackgroundColor: const Color(0xFF23202B),
        useMaterial3: true,
      ),
      home: const MainWrapper(),
    );
  }
}
