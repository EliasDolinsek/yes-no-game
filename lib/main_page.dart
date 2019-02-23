import 'package:flutter/material.dart';
import 'question_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {

  int _score = 0;

  @override
  void initState() {
    super.initState();
    _setScore();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 96, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SafeArea(
              child: Center(
                child: Container(
                  width: double.maxFinite,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "YesNoGame",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "Your best score is $_score",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {},
                    child: OutlineButton(
                      child: Text("Start the YesNoGame"),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuestionPage()));
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _setScore() async {
    await SharedPreferences.getInstance().then((sharedPreferences){
      setState(() {
        _score = sharedPreferences.getInt("score");
      });
    });
  }
}
