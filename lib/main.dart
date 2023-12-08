import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rock_paper_scissors/game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Taş Kağıt Makas",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            appBarTheme: const AppBarTheme(
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          elevation: 0,
        )),
        home: const GamePage());
  }
}
