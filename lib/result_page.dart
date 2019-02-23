import 'package:flutter/material.dart';

import 'main_page.dart';

class ResultPage extends StatelessWidget {
  final int score, percent;

  ResultPage(this.score, this.percent);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 96, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            score.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 96, fontWeight: FontWeight.bold),
          ),
          Text(
            "Your score",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 48),
          ),
          Expanded(child: Align(
            alignment: Alignment.center,
            child: Text(_getEmojiForPercent(), textAlign: TextAlign.center, style: TextStyle(fontSize: 48),),
          )),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: OutlineButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
              }, child: Text("GO HOME!"),),
            ),
          )
        ],
      ),
    ));
  }

  String _getEmojiForPercent(){
    if(percent < 20){
      return "🤨";
    } else if(percent < 40){
      return "😕";
    } else if(percent < 60){
      return "😊";
    } else if(percent < 80){
      return "😉";
    } else {
      return "😅";
    }
  }
}
