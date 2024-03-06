import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Map<String, dynamic>? questionData;
  String? userChoice;
  int? correctChoiceIndex;
  bool answerSubmitted = false;
  bool nextQuestionEnabled = false;

  @override
  void initState() {
    super.initState();
    fetchQuestion();
  }

  void fetchQuestion() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/quiz'));
    if (response.statusCode == 200) {
      setState(() {
        questionData = json.decode(response.body);
        answerSubmitted = false; // Reset answer submission status
        userChoice = null; // Reset user choice
        correctChoiceIndex = questionData?['relation_type'] == 'reflexive' ? 0
            : questionData?['relation_type'] == 'symmetric' ? 1 : 2;
        nextQuestionEnabled = false; // Disable Next Question button
      });
    } else {
      throw Exception('Failed to load question');
    }
  }

  void submitAnswer(int choice) async {
    setState(() {
      userChoice = choice.toString(); // Set user choice
      answerSubmitted = true; // Set answer submission status to true
      nextQuestionEnabled = true; // Enable Next Question button
    });

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/check_answer'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, int>{
        'user_choice': choice,
        'correct_choice': correctChoiceIndex ?? -1,
      }),
    );

    if (response.statusCode != 200) {
      // Handle error response from the server
      print('Failed to submit answer. Error code: ${response.statusCode}');
    }
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
                  Text('Given the relation: ${questionData!['relation']}'),
                  SizedBox(height: 16),
                  Text('What type of relation is it?'),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ElevatedButton(
                        onPressed: answerSubmitted && userChoice != '0' ? null : () => submitAnswer(0),
                        child: Text('Reflexive'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          primary: userChoice == '0'
                              ? (answerSubmitted && userChoice != correctChoiceIndex.toString())
                                  ? Colors.red // Incorrect answer pressed
                                  : (answerSubmitted && userChoice == correctChoiceIndex.toString())
                                      ? Colors.green // Correct answer pressed
                                      : Colors.blue // Not pressed yet
                              : Colors.blue,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: answerSubmitted && userChoice != '1' ? null : () => submitAnswer(1),
                        child: Text('Symmetric'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          primary: userChoice == '1'
                              ? (answerSubmitted && userChoice != correctChoiceIndex.toString())
                                  ? Colors.red // Incorrect answer pressed
                                  : (answerSubmitted && userChoice == correctChoiceIndex.toString())
                                      ? Colors.green // Correct answer pressed
                                      : Colors.blue // Not pressed yet
                              : Colors.blue,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: answerSubmitted && userChoice != '2' ? null : () => submitAnswer(2),
                        child: Text('Transitive'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          primary: userChoice == '2'
                              ? (answerSubmitted && userChoice != correctChoiceIndex.toString())
                                  ? Colors.red // Incorrect answer pressed
                                  : (answerSubmitted && userChoice == correctChoiceIndex.toString())
                                      ? Colors.green // Correct answer pressed
                                      : Colors.blue // Not pressed yet
                              : Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  answerSubmitted
                      ? Text(
                          userChoice == correctChoiceIndex?.toString()
                              ? 'Correct!'
                              : 'Incorrect! The correct answer is: ${['Reflexive', 'Symmetric', 'Transitive'][correctChoiceIndex!]}',
                          style: TextStyle(
                            color: userChoice == correctChoiceIndex?.toString()
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: nextQuestionEnabled ? fetchQuestion : null, // Disable button if next question is not enabled
                    child: Text('Next Question'),
                  ),
                ],
              ),
            ),
    );
  }
}













