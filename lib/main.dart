import 'package:flutter/material.dart';
import 'package:movie_app/colors.dart';
import 'package:movie_app/layout.dart';
import 'package:movie_app/services/tmdb_service.dart';
import 'package:movie_app/themes.dart';

void main() async{
  // await dotenv.load(fileName: '.env');
  await TmdbService.initialize();
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movie Application",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Lato',
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: MColors.themeBlack,
        navigationBarTheme: MThemes.navigationBarThemeData,
        searchBarTheme: MThemes.searchBarThemeData
      ),
      home: const MLayout(),
    );
  }

}