import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manga_reading/firebase_options.dart';
import 'package:manga_reading/support/auth_provider.dart';
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
        primaryColor: Colors.black,
        secondaryHeaderColor: Colors.white,
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Color(0xFF121212),
          shadowColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ).copyWith(
          brightness: Brightness.light,
        ),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.white,
        secondaryHeaderColor: const Color(0xFF121212),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
          shadowColor: Colors.black,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
        ).copyWith(
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: userLogged() ? const MainWrapper() : const AuthPageView(),
    );
  }
}
