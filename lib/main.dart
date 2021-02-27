import 'package:flutter/material.dart';

import 'pages/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'b{G}r{AY}nfuckIDE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.red,
  
        visualDensity: VisualDensity.adaptivePlatformDensity,

        textTheme: TextTheme(
          // Заголовки
          headline1: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
          // Предупреждения
          headline2: TextStyle(
            fontSize: 26
          ),
          headline3: TextStyle(
            fontSize: 26,
            color: Colors.white
          ),
          // Текст кода
          bodyText1: TextStyle(
            fontSize: 20
          ),
          // Цвет кнопок ввода
          bodyText2: TextStyle(
            fontSize: 24,
            color: Colors.white
          )
        )
      ),
      home: HomePage(),
    );
  }
}