# Maths App For Practising Relations In Sets

By UP2047589

## Introduction

This project was developed for my Final Year Project as part of the Computer Science course at the University of Portsmouth.
This code creates questions for Reflexive, Transitive and Symmetric relations in sets and allows the user to choose an answer.
The code then will respond to the users answer appropriatly whether a corect or incorrect solution was chosen before displaying the correct solution.

## Requirements

* Python 3.12.0
* Flutter 3.16.9
* Dart 3.2.6
* Windows Device capable of running Flutter
* IDE capable of running Flutter (e.g. Visual Studio Code)

## Dependencies

This program depends on Python Flask

Install Flask using the Command Promt

**Installation Using Pip:**

`pip install Flask`

## Usage

- Download project zip folder and extract the project from the zip folder.
- Open the project folder into the chosen IDE.
- When prompted run `pub get` to download required dependancies inside the project. If not prompted then naviagte to the `pubspec.yaml` and get the packages/run `pub get` from there.
- Set the device Flutter will load the project in to `Windows` as currently the code only functions on Windows devices. In Visual Studio Code, the Windows device option would look similar to <code>Windows <quote>windows - desktop</quote></code>
- Navigate to the Python file named `app.py` and run it, this starts the Flask server which is required for the project to function. The terminal in the IDE should say when if the server is running. The `app.py` file can be located at the file path of `"FYP-main\lib\python_code\app.py"`
- Navigate to the Dart file named `main.dart` and execute it. This will start the Flutter part of the code and display the application visually. The `main.dart` file can be located at the file path of `"FYP-main\lib\main.dart"`
- Should the code ask for a device to use again, choose the `Windows` device option.
- The project should then load and be available for use, currently `Timed Mode` is still in development so `Endless Mode` is the only working option
- Once the mode has been chosen select any combination of the three relations to be tested on before selecting `Start quiz`, the project will then generate question on the chosen relations.
- Questions will be generated and presented, once an answert is selected the project will respond to the answer immediatly, providing appropriate responses to the selected solutions before allowing the `Next Question` button to be selected and the next question to be loaded.
- To return to the Relation selection page from the questions press either of the two back arrow at the top left of the screen.
- To return to the main menu from the Relation selection page press the back arrow at the top left of the screen.
- To close the program simply close the window like any other program using the `X` at the windows to right.
- This does no close the server however, to shut down the Flask server navigate to the Terminal in the IDE it is outputing to and running in and enter the Terminal. Once able to type in the terminal press `CTRL+C`. This will shut down the server.



