import 'dart:math';

class Question {

  final String question;
  final String imageName;
  final Answer correctAnswer;

  Question({this.question, this.imageName, this.correctAnswer});
}

class QuestionResult {

  static List<QuestionResult> defaultQuestions = [
    QuestionResult(question: Question(question: "Is Hawaii part of the USA?", correctAnswer: Answer.YES, imageName: "hawaii.jpg")),
    QuestionResult(question: Question(question: "Is this the Wingtip of an Lufthansa aircraft?", correctAnswer: Answer.NO, imageName: "aircraft.jpg")),
    QuestionResult(question: Question(question: "Is C++ the first programming language?", correctAnswer: Answer.NO, imageName: "code.jpg")),
    QuestionResult(question: Question(question: "Is it possible to see stars in big cities?", correctAnswer: Answer.NO, imageName: "night-sky.jpg")),
    QuestionResult(question: Question(question: "Has Austria access to the Mediterrnean Sea?", correctAnswer: Answer.NO, imageName: "see.jpg")),
    QuestionResult(question: Question(question: "Is this a beatiful sunset?", correctAnswer: Answer.YES, imageName: "sunset.jpg")),
    QuestionResult(question: Question(question: "Is this a creepy location?", correctAnswer: Answer.YES, imageName: "woods.jpg"))
  ];

  bool answeredCorrectly;
  final Question question;

  QuestionResult({this.answeredCorrectly = false, this.question});

  bool answer(Answer answer){
    answeredCorrectly = question.correctAnswer == answer;
    return answeredCorrectly;
  }

  static List<QuestionResult> getRandomDefaultQuestions() => defaultQuestions;
  static List<QuestionResult> getRandomDefaultQuestionsShuffled(){
    shuffleDefaultQuestions();
    return getRandomDefaultQuestions();
  }

  static void shuffleDefaultQuestions(){
    var random = new Random();

    for (var i = defaultQuestions.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = defaultQuestions[i];
      
      defaultQuestions[i] = defaultQuestions[n];
      defaultQuestions[n] = temp;
    }
  }
}

enum Answer { YES, NO }
