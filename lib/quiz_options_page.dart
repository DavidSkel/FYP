import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_page.dart'; // Import QuizPage.dart

class QuizOptionsPage extends StatefulWidget {
  @override
  _QuizOptionsPageState createState() => _QuizOptionsPageState();
}

class _QuizOptionsPageState extends State<QuizOptionsPage> {
  // Define variables to keep track of selected options
  bool includeTransitive = false;
  bool includeReflexive = false;
  bool includeSymmetric = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Quiz Options'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select types of questions to include:',
              style: TextStyle(fontSize: 18.0),
            ),
            CheckboxListTile(
              title: Text('Transitive'),
              value: includeTransitive,
              onChanged: (value) {
                setState(() {
                  includeTransitive = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Reflexive'),
              value: includeReflexive,
              onChanged: (value) {
                setState(() {
                  includeReflexive = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Symmetric'),
              value: includeSymmetric,
              onChanged: (value) {
                setState(() {
                  includeSymmetric = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the QuizPage and pass selected options
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizPage(
                      includeTransitive: includeTransitive,
                      includeReflexive: includeReflexive,
                      includeSymmetric: includeSymmetric,
                    ),
                  ),
                );
              },
              child: Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}




