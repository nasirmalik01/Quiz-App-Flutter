import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

void main() => (runApp(Quizzler())) ;

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: quizzler(),
          ),
        ),
      ),
    );
  }
}

class quizzler extends StatefulWidget {
  @override
  _quizzlerState createState() => _quizzlerState();
}

class _quizzlerState extends State<quizzler> {
  List<Icon> scoreBoard = [];

  /*List<String> questions = [
    'You can lead a cow down stairs but not up stairs',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.',
    'My Name is Nasir Mehmood',
    'I am in 7th semester',
    'I am good in web',
    'I am good in mobile development ALHAMDOLILLAH'
  ];

  List<bool> correctAnswers =[
    false,
    true,
    true,
    true,
    false,
    false,
    true,
  ];*/

  /*List<questions> questionAnswers = [
    questions(question: 'You can lead a cow down stairs but not up stairs', answer:false),
    questions(question: 'Approximately one quarter of human bones are in the feet.',answer:true),
    questions(question: 'A slug\'s blood is green.',answer:true),
    questions(question: 'My Name is Nasir Mehmood',answer:true),
    questions(question: 'I am in 7th semester',answer:false),
    questions(question: 'I am good in web',answer:false),
    questions(question: 'I am good in mobile development ALHAMDOLILLAH',answer:true),

  ];*/

  //int questionNumber = 0;
  bool correctAns;
  QuizBrain quizBrain = QuizBrain();
  int totalQuestions = 0;
  int trueAnswers = 0;

  void checkAnswers(bool expectedAnswer) {
    setState(() {
      //quizBrain.questionAnswers[questionNumber].answer = false;
      if (quizBrain.isFinished() == true) {
        print('Alert need to be shown at this point');

        Alert(
          context: context,
          type: AlertType.error,
          title: "Finished!",
          desc: "You\'ve reached the end of the quiz.",
          buttons: [
            DialogButton(
              child: Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();

        quizBrain.reset();

        scoreBoard = [];
      }
      else {
        correctAns = quizBrain.encapsulatedAnswer();
        if (expectedAnswer == correctAns) {
          scoreBoard.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreBoard.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestionNumber();
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    int current = quizBrain.currentQuestion();
    return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    'Question No: $current : \n\n' +
                        quizBrain.encapsulatedQuestion(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: FlatButton(
                  color: Colors.green,
                  child: Text(
                    'True',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    // print('Question No : $questionNumber');
                    // questionNumber++;
                    /* totalQuestions = quizBrain.encapsulateTotal();
                    print(totalQuestions);
                    if(questionNumber > totalQuestions){
                      questionNumber=0;
                    }*/
                    checkAnswers(true);
                    trueAnswers = trueAnswers+1;
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FlatButton(
                  color: Colors.red,
                  child: Text(
                    'False',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    checkAnswers(false);
                  },
                ),
              ),
            ),
            // TODO: we are going to set scorekeeper for our quiz app
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: scoreBoard
              ),
            )
          ],
        );
  }
}
