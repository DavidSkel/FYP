import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransitiveMultipleChoice extends StatefulWidget {
  final void Function() onNextQuestion; // Callback function

  TransitiveMultipleChoice({required this.onNextQuestion});

  @override
  _TransitiveMultipleChoiceState createState() => _TransitiveMultipleChoiceState();
}

class _TransitiveMultipleChoiceState extends State<TransitiveMultipleChoice> {
  List<Set<Tuple>>? relationsList;
  int? correctRelationIndex;
  bool answerSubmitted = false;
  int? selectedButtonIndex;

  @override
  void initState() {
    super.initState();
    fetchQuestion(); // Call fetchQuestion when the widget is initialized
  }

  void fetchQuestion() async {
    // Fetch a new question
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/quiz?question_type=3'));
    if (response.statusCode == 200) {
      setState(() {
        // Update state with new question data
        Map<String, dynamic> responseData = json.decode(response.body);
        relationsList = List<dynamic>.from(responseData['relations']).map((relation) => _convertToSet(relation)).toList();
        correctRelationIndex = responseData['transitive_index'];
        answerSubmitted = false;
        selectedButtonIndex = null;
      });
    } else {
      throw Exception('Failed to load question');
    }
  }

  Set<Tuple> _convertToSet(List<dynamic> relationList) {
    return relationList.map((pair) => Tuple(pair[0], pair[1])).toSet();
  }

  void submitAnswer(int choice) {
    setState(() {
      answerSubmitted = true;
      selectedButtonIndex = choice;
    });
    // You can implement logic to check if the user's choice is correct here
  }

  void nextQuestion() {
    widget.onNextQuestion(); // Call the callback function
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: relationsList == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Which of the given Relations on the Set {1, 2, 3, 4, 5, 6} is Transitive:'),
            SizedBox(height: 16),
            // Display the relations as buttons
            Column(
              children: List.generate(
                relationsList!.length,
                    (index) => Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (!answerSubmitted) {
                          submitAnswer(index);
                        }
                      },
                      child: Text('Relation ${index + 1}: ${relationsList![index]}'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey;
                            } else if (selectedButtonIndex == index) {
                              return selectedButtonIndex == correctRelationIndex
                                  ? Colors.green
                                  : Colors.red;
                            } else {
                              return Colors.blue;
                            }
                          },
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        ),
                      ),
                    ),
                    SizedBox(height: 8), // Add some vertical space between buttons
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Show feedback after answer submission
            answerSubmitted
                ? Text(
              correctRelationIndex == null
                  ? 'Correct relation index not provided'
                  : selectedButtonIndex == correctRelationIndex
                  ? 'Correct!'
                  : 'Incorrect! Correct relation is: Relation ${correctRelationIndex! + 1}',
              style: TextStyle(
                color: selectedButtonIndex == correctRelationIndex ? Colors.green : Colors.red,
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
  final int x;
  final int y;

  Tuple(this.x, this.y);

  @override
  String toString() {
    return '($x, $y)';
  }
}
