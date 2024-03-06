import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransitiveTrueFalse extends StatefulWidget {
  final Function nextQuestionCallback;

  TransitiveTrueFalse({required this.nextQuestionCallback});

  @override
  _TransitiveTrueFalseState createState() => _TransitiveTrueFalseState();
}

class _TransitiveTrueFalseState extends State<TransitiveTrueFalse> {
  Map<String, dynamic>? questionData;
  bool answerSubmitted = false;
  bool? isTransitive;
  bool? userChoice;

  @override
  void initState() {
    super.initState();
    fetchQuestion();
  }

  void fetchQuestion() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/quiz?question_type=2'));
    if (response.statusCode == 200) {
      setState(() {
        questionData = json.decode(response.body);
        answerSubmitted = false;
        isTransitive = questionData?['is_transitive'];
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

    if ((userAnswer && isTransitive == true) || (!userAnswer && isTransitive == false)) {
      print('Correct!');
    } else {
      print('Incorrect!');
    }
  }

  void nextQuestion() {
    widget.nextQuestionCallback();
  }

  Set<Tuple> _convertToSet(List<dynamic> relationList) {
    return relationList.map((pair) => Tuple(pair[0], pair[1])).toSet();
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
                    'The Relation R ${_convertToSet(questionData!['relation'])} on the Set {1, 2, 3, 4, 5, 6} is Transitive.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: answerSubmitted || userChoice == true
                              ? null
                              : () => checkAnswer(true),
                          child: Text('True'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return userChoice == true
                                      ? isTransitive == true ? Colors.green : Colors.red
                                      : Colors.grey;
                                }
                                return Colors.blue;
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
                              : () => checkAnswer(false),
                          child: Text('False'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return userChoice == false
                                      ? isTransitive == false ? Colors.green : Colors.red
                                      : Colors.grey;
                                }
                                return Colors.blue;
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
                          userChoice == isTransitive
                              ? 'Correct!'
                              : 'Incorrect! The correct answer is: ${isTransitive!}',
                          style: TextStyle(
                            color: userChoice == isTransitive ? Colors.green : Colors.red,
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
}

class Tuple {
  final int first;
  final int second;

  Tuple(this.first, this.second);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Tuple && runtimeType == other.runtimeType && first == other.first && second == other.second;

  @override
  int get hashCode => first.hashCode ^ second.hashCode;

  @override
  String toString() {
    return '($first, $second)';
  }
}
