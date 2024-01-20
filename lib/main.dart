import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manga_reading/firebase_options.dart';
import 'package:manga_reading/support/auth_provider.dart';
import 'package:manga_reading/views/auth_page_view.dart';
import 'package:manga_reading/views/crop_page_view.dart';
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
      title: 'Ink Dreams',
      theme: ThemeData(
        primaryColor: Colors.black,
        secondaryHeaderColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red,
          selectedLabelStyle: TextStyle(
            color: Colors.red,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        cardColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            letterSpacing: 0,
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          outlineBorder: BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
          hintStyle: TextStyle(
            color: Color(0xFFA2A2A2),
            fontSize: 22,
            fontWeight: FontWeight.w500,
            letterSpacing: .5,
          ),
          prefixIconColor: Color(0xFFA2A2A2),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          background: Colors.white,
        ).copyWith(
          brightness: Brightness.light,
        ),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.white,
        secondaryHeaderColor: Colors.black,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF252525),
          selectedItemColor: Colors.red,
          selectedLabelStyle: TextStyle(
            color: Colors.red,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        cardColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          foregroundColor: Colors.white,
          actionsIconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            letterSpacing: 0,
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          contentTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
          backgroundColor: Color(0xFF252525),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          outlineBorder: BorderSide.none,
          hintStyle: TextStyle(
            color: Color(0xFFA2A2A2),
            fontSize: 22,
            fontWeight: FontWeight.w500,
            letterSpacing: .5,
          ),
          prefixIconColor: Color(0xFFA2A2A2),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          background: const Color(0xFF121212),
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
