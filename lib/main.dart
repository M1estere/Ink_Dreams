import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manga_reading/firebase_options.dart';
import 'package:manga_reading/support/app_theme.dart';
import 'package:manga_reading/support/auth_provider.dart';
import 'package:manga_reading/views/auth_page_view.dart';
import 'package:manga_reading/views/main_app_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  prefs = await SharedPreferences.getInstance();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appTheme = AppTheme();

  @override
  void initState() {
    super.initState();
    _appTheme.addListener(() => setState(() {}));
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ],
    );

    if (prefs.getString('theme') != null) {
      switch (prefs.getString('theme')) {
        case 'dark':
          AppTheme().enableTheme('dark', context);
          break;
        case 'light':
          AppTheme().enableTheme('light', context);
          break;
        case 'system':
          AppTheme().enableTheme('system', context);
          break;
      }
    } else {
      AppTheme().enableTheme('system', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ink Dreams',
      theme: _appTheme.lightTheme,
      darkTheme: _appTheme.darkTheme,
      themeMode: _appTheme.themeMode,
      home: userLogged() ? const MainWrapper() : const AuthPageView(),
    );
  }
}
