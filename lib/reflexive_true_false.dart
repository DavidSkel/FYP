import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReflexiveTrueFalse extends StatefulWidget {
  final Function nextQuestionCallback; // Add the nextQuestionCallback argument

  ReflexiveTrueFalse({required this.nextQuestionCallback}); // Update the constructor

  @override
  _ReflexiveTrueFalseState createState() => _ReflexiveTrueFalseState();
}

class _ReflexiveTrueFalseState extends State<ReflexiveTrueFalse> {
  Map<String, dynamic>? questionData;
  bool answerSubmitted = false;
  bool? isReflexive;
  bool? userChoice;

  @override
  void initState() {
    super.initState();
    fetchQuestion();
  }

  void fetchQuestion() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/quiz?question_type=6'));
    if (response.statusCode == 200) {
      setState(() {
        questionData = json.decode(response.body);
        answerSubmitted = false;
        isReflexive = questionData?['is_reflexive']; // Assuming this is the reflexive indicator
      });
    } else {
      throw Exception('Failed to load question');
    }
  }

  void checkAnswer(bool userAnswer) {
    setState(() {
      answerSubmitted = true;
      userChoice = userAnswer;
    });

    if ((userAnswer && isReflexive == true) || (!userAnswer && isReflexive == false)) {
      // Correct answer
      print('Correct!');
    } else {
      // Incorrect answer
      print('Incorrect!');
    }
  }

  void nextQuestion() {
    widget.nextQuestionCallback(); // Call the nextQuestionCallback function passed from QuizPage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: questionData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The Relation R = ${_convertToSet(questionData!['relation'])} on the Set {1, 2, 3, 4, 5, 6} is Reflexive.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: answerSubmitted || userChoice == true
                              ? null
                              : () => checkAnswer(true), // Handle True button press
                          child: Text('True'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return userChoice == true
                                      ? isReflexive == true ? Colors.green : Colors.red
                                      : Colors.grey; // Gray color for disabled button
                                }
                                return Colors.blue; // Default color when not selected
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: answerSubmitted || userChoice == false
                              ? null
                              : () => checkAnswer(false), // Handle False button press
                          child: Text('False'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return userChoice == false
                                      ? isReflexive == false ? Colors.green : Colors.red
                                      : Colors.grey; // Gray color for disabled button
                                }
                                return Colors.blue; // Default color when not selected
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  answerSubmitted
                      ? Text(
                          userChoice == isReflexive
                              ? 'Correct!'
                              : 'Incorrect! The correct answer is: ${isReflexive!}',
                          style: TextStyle(
                            color: userChoice == isReflexive ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: answerSubmitted ? nextQuestion : null,
                    child: Text('Next Question'),
                  ),
                ],
              ),
            ),
    );
  }

  Set<Tuple> _convertToSet(List<dynamic> relationList) {
    return relationList.map((pair) => Tuple(pair[0], pair[1])).toSet();
  }
}

class Tuple {
  final int x;
  final int y;

  Tuple(this.x, this.y);

  @override
  String toString() {
    return '($x, $y)';
  }
}















