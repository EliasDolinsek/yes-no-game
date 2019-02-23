import 'package:flutter/material.dart';

import 'main_page.dart';

void main() => runApp(YesNoGameApp());

class YesNoGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "Roboto"),
      home: MainPage()
    );
  }
}
