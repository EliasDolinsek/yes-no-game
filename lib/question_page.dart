import 'package:flutter/material.dart';
import 'core/question.dart';
import 'result_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionPage extends StatefulWidget {
  List<QuestionResult> _questions = QuestionResult.getRandomDefaultQuestionsShuffled();

  @override
  State<StatefulWidget> createState() {
    return _QuestionPageState();
  }
}

class _QuestionPageState extends State<QuestionPage> {
  //in ms
  static const int CORRECT_TEXT_ANIMATION_DURATION = 400;

  int _currentQuestionIndex = 0;
  bool _correctTextVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "images/${widget._questions.elementAt(_currentQuestionIndex).question.imageName}"),
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop)
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 96, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                widget._questions
                    .elementAt(_currentQuestionIndex)
                    .question
                    .question,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 48, color: Colors.black),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedOpacity(
                    opacity: _correctTextVisible ? 1 : 0,
                    duration:
                        Duration(milliseconds: CORRECT_TEXT_ANIMATION_DURATION),
                    child: Text(
                      "CORRECT!",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        child: Text(
                          "YES!",
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        onPressed: () {
                          _answerCurrentQuestion(Answer.YES);
                        },
                      ),
                      MaterialButton(
                        child: Text(
                          "NO!",
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        onPressed: () {
                          _answerCurrentQuestion(Answer.NO);
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _answerCurrentQuestion(Answer answer) async {
    if (widget._questions.elementAt(_currentQuestionIndex).answer(answer)) {
      _updateBestScoreIfNecessary(_currentQuestionIndex + 1);
      if (_currentQuestionIndex + 1 == widget._questions.length) {
        _showResult(_currentQuestionIndex + 1);
      } else {
        setState(() {
          _correctTextVisible = true;
        });

        Future.delayed(
          Duration(milliseconds: CORRECT_TEXT_ANIMATION_DURATION + 200),
        ).then((v) {
          _currentQuestionIndex++;
          setState(() {
            _correctTextVisible = false;
          });
        });
      }
    } else {
      _showResult(_currentQuestionIndex);
    }
  }

  void _showResult(int correctAnswers) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => ResultPage(
            correctAnswers, _getAnsweredQuestionsInPercent(correctAnswers))));
  }

  int _getAnsweredQuestionsInPercent(int correctAnswers) {
    return 100 ~/ widget._questions.length * correctAnswers;
  }

  void _updateBestScoreIfNecessary(int correctAnswers) async {
    await SharedPreferences.getInstance().then((sharedPreferences) {
      var bestScore = sharedPreferences.getInt("score");

      if (bestScore == null) {
        bestScore = 0;
      }

      if (bestScore < correctAnswers) {
        sharedPreferences.setInt("score", correctAnswers);
      }
    });
  }
}
