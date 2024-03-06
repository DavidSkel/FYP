import 'package:flutter/material.dart';
import 'quiz_options_page.dart'; // Importing the QuizOptionsPage file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizModeSelection(), // Set QuizModeSelection as the main page
    );
  }
}

class QuizModeSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Quiz Mode'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity, // Make button width match parent
              height: 100, // Set button height to 100
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the QuizOptionsPage for endless quiz
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizOptionsPage()),
                  );
                },
                child: Text(
                  'Endless Mode',
                  style: TextStyle(fontSize: 20), // Adjust text size
                ),
              ),
            ),
            SizedBox(height: 20), // Add spacing between buttons
            SizedBox(
              width: double.infinity, // Make button width match parent
              height: 100, // Set button height to 100
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the page for timed quiz (to be implemented later)
                },
                child: Text(
                  'Timed Mode',
                  style: TextStyle(fontSize: 20), // Adjust text size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


