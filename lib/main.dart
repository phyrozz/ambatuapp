import 'package:ambatuapp/pages/characters.dart';
import 'package:ambatuapp/pages/characters/ampassing.dart';
import 'package:ambatuapp/pages/characters/ankaming.dart';
import 'package:ambatuapp/pages/characters/bunda.dart';
import 'package:ambatuapp/pages/characters/dreamy.dart';
import 'package:ambatuapp/pages/characters/kakangku.dart';
import 'package:ambatuapp/pages/characters/nissan.dart';
import 'package:ambatuapp/pages/characters/turbulence_man.dart';
import 'package:ambatuapp/pages/characters/yes_king.dart';
import 'package:ambatuapp/pages/soundboard.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/stats.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => ThemeModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, themeModel, _) {
        return MaterialApp(
          title: 'AmbatuApp',
          theme: themeModel.getThemeData(),
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(),
            '/stats': (context) => StatsPage(),
            '/characters': (context) => CharacterListPage(),
            '/characters/dreamy': (context) => const DreamyPage(),
            '/characters/ankaming': (context) => AnkamingPage(),
            '/characters/bunda': (context) => BundaPage(),
            '/characters/kakangku': (context) => KakangkuPage(),
            '/characters/nissan': (context) => NissanPage(),
            '/characters/ampassing': (context) => AmpassingPage(),
            '/characters/yesKing': (context) => YesKingPage(),
            '/characters/turbulenceMan': (context) => TurbulenceManPage(),
            '/soundboard': (context) => SoundboardPage(),
            // Add routes for other pages in your app
          },
        );
      },
    );
  }
}

class ThemeModel extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData getThemeData() {
    return _isDarkMode ? darkTheme : lightTheme;
  }

  final lightTheme = ThemeData(
    // Define your light mode theme data here
    brightness: Brightness.light,
    primaryColor: Colors.deepPurple[100],
    primarySwatch: Colors.deepPurple,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepPurple,
    ),
    canvasColor: Colors.deepPurple[100],
    textTheme: TextTheme(
      bodySmall: TextStyle(fontSize: 16.0),
      bodyMedium: TextStyle(fontSize: 18.0),
      bodyLarge: TextStyle(fontSize: 20.0),
      displaySmall: TextStyle(),
      displayMedium: TextStyle(),
      displayLarge: TextStyle(),
      headlineSmall: TextStyle(),
      headlineMedium: TextStyle(),
      headlineLarge: TextStyle(),
      titleSmall: TextStyle(),
      titleMedium: TextStyle(),
      titleLarge: TextStyle(),
      labelSmall: TextStyle(),
      labelMedium: TextStyle(),
      labelLarge: TextStyle(),
    ).merge(GoogleFonts.latoTextTheme()),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple[300],
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.deepPurple,
    ),
    // ...
  );

  final darkTheme = ThemeData(
    // Define your dark mode theme data here
    brightness: Brightness.dark,
    primaryColor: Color.fromARGB(255, 31, 17, 73),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 15, 8, 44),
    ),
    canvasColor: Color.fromARGB(255, 31, 17, 73),
    textTheme: TextTheme(
      bodySmall: TextStyle(fontSize: 16.0),
      bodyMedium: TextStyle(fontSize: 18.0),
      bodyLarge: TextStyle(fontSize: 20.0),
      displaySmall: TextStyle(),
      displayMedium: TextStyle(),
      displayLarge: TextStyle(),
      headlineSmall: TextStyle(),
      headlineMedium: TextStyle(),
      headlineLarge: TextStyle(),
      titleSmall: TextStyle(),
      titleMedium: TextStyle(),
      titleLarge: TextStyle(),
      labelSmall: TextStyle(),
      labelMedium: TextStyle(),
      labelLarge: TextStyle(),
    ).merge(GoogleFonts.latoTextTheme()).apply(
          displayColor: Colors.white,
          bodyColor: Colors.white,
        ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
      ),
    ),
    cardColor: Colors.deepPurple[900],
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.deepPurple,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStatePropertyAll(Colors.deepPurple),
      trackColor: MaterialStatePropertyAll(Colors.deepPurple[100]),
    ),
    // ...
  );
}
