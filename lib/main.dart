import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qdart/guessss.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GUESS THE NUMBER',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _controller = TextEditingController();
  var game = Game();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
              //border: Border.all(width: 5.0, color: Colors.blue),
              boxShadow: [
                BoxShadow(
                    color: Colors.teal.withOpacity(1),
                    offset: const Offset(2.0, 5.0),
                    blurRadius: 5.0,
                    spreadRadius: 2.0)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/guess_logo.png',
                        width: 100,
                        height: 100,
                        //fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'GUESS',
                          style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 50.0,
                          ),
                        ),
                        Text(
                          'THE NUMBER',
                          style: TextStyle(
                            color: Colors.orangeAccent,
                            fontSize: 25.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _controller,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.7),
                      border: OutlineInputBorder(),
                      hintText: 'Guess the number between 1 to 100'),
                ),
              ),
              ElevatedButton(
                child: const Text('GUESS'),
                onPressed: () {
                  var input = _controller.text;
                  var number = int.tryParse(input);
                  String title = "Result";
                  String content = "";
                  if (number == null) {
                    title = "Error";
                    content = "invalid input please only enter number";
                  } else {
                    var result = game.doGuess(number);
                    if (result == 1) {
                      content = "> $number is TOO HIGH! , Please try again. <";
                    } else if (result == -1) {
                      content = "> $number is TOO LOW! , Please try again. <";
                    } else if (result == 0) {
                      content =
                          "> $number is CORRECT! you so good la dude <, \ntotal guesses: ${game.guessCount}";
                    }
                  }
                  {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text('Result'),
                              content: Text(content),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('OK'))
                              ]);
                        });
                  }
                  ;
                },
                style: ElevatedButton.styleFrom(primary: Colors.pinkAccent),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
