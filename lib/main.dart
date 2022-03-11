import 'package:banking_project/pages/addCardPage.dart';
import 'package:banking_project/pages/cardList.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: CardList(),
      routes: {
      CardList.id:(context) =>CardList(),
      AddCardPage .id: (context) => AddCardPage(),
      },
    );
  }
}
