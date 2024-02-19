import 'package:ambatuapp/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeModel = ThemeModel();
  await themeModel.loadDarkModePreference();
  await dotenv.load(fileName: ".env");
  String supabaseUrl = dotenv.get('SUPABASE_URL');
  String supabaseAnonKey = dotenv.get('SUPABASE_ANON_KEY');

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);

  runApp(ChangeNotifierProvider.value(
    value: themeModel,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<InitializationStatus> _initGoogleMobileAds() {
    // TODO: Initialize Google Mobile Ads SDK
    return MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, _) {
          final isDarkMode = themeModel.isDarkMode;

          return SkeletonTheme(
            shimmerGradient: isDarkMode
                ? themeModel.darkShimmerGradient
                : themeModel.lightShimmerGradient,
            darkShimmerGradient: const LinearGradient(
              colors: [
                Colors.deepPurple,
                Color.fromARGB(255, 91, 51, 160),
                Color.fromARGB(255, 79, 44, 139),
                Color.fromARGB(255, 91, 51, 160),
                Colors.deepPurple
              ],
              stops: [
                0.0,
                0.2,
                0.5,
                0.8,
                1,
              ],
              begin: Alignment(-2.4, -0.2),
              end: Alignment(2.4, 0.2),
              tileMode: TileMode.clamp,
            ),
            child: MaterialApp(
              title: 'AmbatuApp',
              theme: themeModel.getThemeData(),
              home: AuthTree(themeModel: themeModel),
              // initialRoute: '/',
              // routes: {
              //   '/': (context) => const HomePage(),
              //   '/stats': (context) => const StatsPage(),
              //   '/characters': (context) => const CharacterListPage(),
              //   '/characters/dreamy': (context) => const DreamyPage(),
              //   '/characters/ankaming': (context) => const AnkamingPage(),
              //   '/characters/bunda': (context) => const BundaPage(),
              //   '/characters/kakangku': (context) => const KakangkuPage(),
              //   '/characters/nissan': (context) => const NissanPage(),
              //   '/characters/ampassing': (context) => const AmpassingPage(),
              //   '/characters/yesKing': (context) => const YesKingPage(),
              //   '/characters/turbulenceMan': (context) =>
              //       const TurbulenceManPage(),
              //   '/characters/daddyAmkaming': (context) =>
              //       const DaddyAmkamingPage(),
              //   '/characters/viktor': (context) => const ViktorPage(),
              //   '/characters/busSoldier': (context) => const BusSoldierPage(),
              //   '/characters/axel': (context) => const AxelPage(),
              //   '/characters/humpDay': (context) => const HumpDayPage(),
              //   '/soundboard': (context) => const SoundboardPage(),
              //   '/ambatuwatch': (context) => const AmbatuWatchPage(),
              //   '/ambatugames': (context) => const AmbatuGamesPage(),
              //   '/games/ambatugame': (context) => const AmbatugamePage(),
              //   '/games/ambatusnake': (context) => const AmbatuSnakePage(),
              //   '/games/ambatublou': (context) =>
              //       const AmbatublouSelectDifficulty(),
              //   '/games/flappyBus': (context) => const FlappyBusPage(),
              //   // Add routes for other pages in your app
              // },
            ),
          );
        },
      ),
    );
  }
}

class ThemeModel extends ChangeNotifier {
  final darkShimmerGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 52, 31, 107),
      Color.fromARGB(255, 35, 21, 73),
      Color.fromARGB(255, 52, 31, 107),
    ],
    stops: [
      0.1,
      0.5,
      0.9,
    ],
  );

  final darkTheme = ThemeData(
    // Define your dark mode theme data here
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(255, 31, 17, 73),
    primaryColorLight: Colors.deepPurple[100],
    primaryColorDark: Colors.deepPurple[900],
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 15, 8, 44),
    ),
    canvasColor: const Color.fromARGB(255, 31, 17, 73),
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontFamily: "Kanit", fontSize: 16.0),
      bodyMedium: TextStyle(fontFamily: "Kanit", fontSize: 18.0),
      bodyLarge: TextStyle(fontFamily: "Kanit", fontSize: 20.0),
      displaySmall: TextStyle(
        fontFamily: "Kanit",
        fontWeight: FontWeight.w100,
      ),
      displayMedium: TextStyle(
        fontFamily: "Kanit",
        fontWeight: FontWeight.w100,
      ),
      displayLarge: TextStyle(
        fontFamily: "Kanit",
        fontWeight: FontWeight.w100,
      ),
      headlineSmall: TextStyle(
        fontFamily: "Kanit",
      ),
      headlineMedium: TextStyle(
        fontFamily: "Kanit",
      ),
      headlineLarge: TextStyle(
        fontFamily: "Kanit",
      ),
      titleSmall: TextStyle(
        fontFamily: "Kanit",
      ),
      titleMedium: TextStyle(
        fontFamily: "Kanit",
      ),
      titleLarge: TextStyle(
        fontFamily: "Kanit",
      ),
      labelSmall: TextStyle(
        fontFamily: "Kanit",
      ),
      labelMedium: TextStyle(
        fontFamily: "Kanit",
      ),
      labelLarge: TextStyle(
        fontFamily: "Kanit",
      ),
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
    dialogBackgroundColor: const Color.fromARGB(255, 31, 17, 73),
  );

  final lightShimmerGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 179, 168, 199),
      Color.fromARGB(255, 158, 148, 175),
      Color.fromARGB(255, 179, 168, 199),
    ],
    stops: [
      0.1,
      0.5,
      0.9,
    ],
  );

  final lightTheme = ThemeData(
    // Define your light mode theme data here
    brightness: Brightness.light,
    primaryColor: Colors.deepPurple[100],
    primaryColorLight: Colors.deepPurple,
    primaryColorDark: Colors.deepPurple[200],
    primarySwatch: Colors.deepPurple,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepPurple,
    ),
    canvasColor: Colors.deepPurple[100],
    textTheme: const TextTheme(
      bodySmall: TextStyle(fontFamily: "Kanit", fontSize: 16.0),
      bodyMedium: TextStyle(fontFamily: "Kanit", fontSize: 18.0),
      bodyLarge: TextStyle(fontFamily: "Kanit", fontSize: 20.0),
      displaySmall: TextStyle(
        fontFamily: "Kanit",
        fontWeight: FontWeight.w100,
      ),
      displayMedium: TextStyle(
        fontFamily: "Kanit",
        fontWeight: FontWeight.w100,
      ),
      displayLarge: TextStyle(
        fontFamily: "Kanit",
        fontWeight: FontWeight.w100,
      ),
      headlineSmall: TextStyle(
        fontFamily: "Kanit",
      ),
      headlineMedium: TextStyle(
        fontFamily: "Kanit",
      ),
      headlineLarge: TextStyle(
        fontFamily: "Kanit",
      ),
      titleSmall: TextStyle(
        fontFamily: "Kanit",
      ),
      titleMedium: TextStyle(
        fontFamily: "Kanit",
      ),
      titleLarge: TextStyle(
        fontFamily: "Kanit",
        fontWeight: FontWeight.w100,
      ),
      labelSmall: TextStyle(
        fontFamily: "Kanit",
      ),
      labelMedium: TextStyle(
        fontFamily: "Kanit",
      ),
      labelLarge: TextStyle(
        fontFamily: "Kanit",
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurple[800],
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.deepPurple,
    ),
    dialogBackgroundColor: Colors.deepPurple[100],
  );

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  Future<void> loadDarkModePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }

  ThemeData getThemeData() {
    return _isDarkMode ? darkTheme : lightTheme;
  }
}
