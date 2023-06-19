import 'package:ambatuapp/pages/ambatugame.dart';
import 'package:ambatuapp/pages/ambatuwatch.dart';
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
            '/stats': (context) => const StatsPage(),
            '/characters': (context) => const CharacterListPage(),
            '/characters/dreamy': (context) => const DreamyPage(),
            '/characters/ankaming': (context) => const AnkamingPage(),
            '/characters/bunda': (context) => const BundaPage(),
            '/characters/kakangku': (context) => const KakangkuPage(),
            '/characters/nissan': (context) => const NissanPage(),
            '/characters/ampassing': (context) => const AmpassingPage(),
            '/characters/yesKing': (context) => const YesKingPage(),
            '/characters/turbulenceMan': (context) => const TurbulenceManPage(),
            '/soundboard': (context) => const SoundboardPage(),
            '/ambatuwatch': (context) => const AmbatuWatchPage(),
            '/ambatugame': (context) => const AmbatugamePage(),
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
    primaryColorLight: Colors.deepPurple,
    primarySwatch: Colors.deepPurple,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepPurple,
    ),
    canvasColor: Colors.deepPurple[100],
    textTheme: const TextTheme(
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
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurple[800],
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.deepPurple,
    ),
    // ...
  );

  final darkTheme = ThemeData(
    // Define your dark mode theme data here
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(255, 31, 17, 73),
    primaryColorLight: Colors.deepPurple[100],
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 15, 8, 44),
    ),
    canvasColor: const Color.fromARGB(255, 31, 17, 73),
    textTheme: const TextTheme(
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
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.deepPurple,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color.fromARGB(255, 15, 8, 44),
      foregroundColor: Colors.white,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: const MaterialStatePropertyAll(Colors.deepPurple),
      trackColor: MaterialStatePropertyAll(Colors.deepPurple[100]),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(Colors.deepPurple[200]),
      ),
    ),
    // ...
  );
}
