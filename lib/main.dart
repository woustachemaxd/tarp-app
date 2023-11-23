import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navi_app/home_page/home_page.dart';
import 'package:navi_repository/navi_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => NaviRepository(),
        child: MaterialApp(
          title: 'Navi',
          theme: ThemeData(
          progressIndicatorTheme:
              ProgressIndicatorThemeData(color: Colors.black),
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Color(0xFF252525)),
          primaryColor: Color(0xFF252525),
          appBarTheme: AppBarTheme(
            color: Color(0xFF252525),
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 23,
                fontFamily: "VisbyRoundCF"),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.all(12)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  textStyle: MaterialStateProperty.all(TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: "VisbyRoundCF",
                      color: Colors.white,
                      fontSize: 21)),
                  backgroundColor: MaterialStateColor.resolveWith((states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Color(0xFFA7A7A7);
                    }

                    return Color(0xFF252525);
                  }))),
          textTheme: TextTheme(
              subtitle1: TextStyle(fontFamily: "VisbyRoundCF", fontSize: 23)),
          fontFamily: "VisbyRoundCF",
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.black,
          ),
          inputDecorationTheme: InputDecorationTheme(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              floatingLabelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.06, color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.06, color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(6)))),
        ),
          home: const HomePage(),
        ));
  }
}
