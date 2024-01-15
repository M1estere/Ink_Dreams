import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manga_reading/firebase_options.dart';
import 'package:manga_reading/views/auth_page_view.dart';
import 'package:manga_reading/views/main_app_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manga Reader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8E1617),
        ),
        scaffoldBackgroundColor: const Color(0xFF23202B),
        useMaterial3: true,
      ),
      home: const AuthPageView(),
    );
  }
}
