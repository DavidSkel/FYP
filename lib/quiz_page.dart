import 'package:flutter/material.dart';
import 'dart:math';
import 'package:quiz_app/reflexive_multiple_choice.dart';
import 'package:quiz_app/reflexive_true_false.dart';
import 'package:quiz_app/symmetric_multiple_choice.dart';
import 'package:quiz_app/symmetric_true_false.dart';
import 'package:quiz_app/transitive_multiple_choice.dart';
import 'package:quiz_app/transitive_true_false.dart';

class QuizPage extends StatefulWidget {
  final bool includeTransitive;
  final bool includeReflexive;
  final bool includeSymmetric;

  QuizPage({
    required this.includeTransitive,
    required this.includeReflexive,
    required this.includeSymmetric,
  });

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Widget quizContent;

  @override
  void initState() {
    super.initState();
    loadQuizContent();
  }

  void loadQuizContent() {
  final Random random = Random();
  List<Widget> possibleContents = [];

  if (widget.includeReflexive) {
    if (random.nextBool()) {
      possibleContents.add(ReflexiveMultipleChoice(onNextQuestion: nextQuestion));
    } else {
      possibleContents.add(ReflexiveTrueFalse(nextQuestionCallback: nextQuestion));
    }
  }
  if (widget.includeSymmetric) {
    if (random.nextBool()) {
      possibleContents.add(SymmetricMultipleChoice(onNextQuestion: nextQuestion));
    } else {
      possibleContents.add(SymmetricTrueFalse(nextQuestionCallback: nextQuestion));
    }
  }
  if (widget.includeTransitive) {
    if (random.nextBool()) {
      possibleContents.add(TransitiveMultipleChoice(onNextQuestion: nextQuestion));
    } else {
      possibleContents.add(TransitiveTrueFalse(nextQuestionCallback: nextQuestion));
    }
  }

  if (possibleContents.isEmpty) {
    quizContent = Center(
      child: Text('Please select at least one option to start the quiz.'),
    );
  } else {
    quizContent = possibleContents[random.nextInt(possibleContents.length)];
  }
}

  void nextQuestion() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => QuizPage(
          includeTransitive: widget.includeTransitive,
          includeReflexive: widget.includeReflexive,
          includeSymmetric: widget.includeSymmetric,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Page'),
      ),
      body: quizContent,
      //floatingActionButton: FloatingActionButton(
        //onPressed: nextQuestion,
        //tooltip: 'Next Question',
        //child: Icon(Icons.arrow_forward),
      //),
    );
  }
}






