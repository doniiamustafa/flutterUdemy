import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udemy/question&4answers/answer.dart';
import 'question&4answers/result.dart';
import 'chartApp/section4_firstFile.dart';
import 'package:flutter/cupertino.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();    // 3amlt el goz2 da 3lshan law 3iza el app myt3mlsh landscape mode
  // SystemChrome.setPreferredOrientations(
  //     [ DeviceOrientation.portraitUp,           //khaleto yb2a up and down 3lshan lw el zeft user masek el mobile bel metsha2leb
  //       DeviceOrientation.portraitDown
  //     ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(home: ChartScreen(),)
        : MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.purple,
                // errorColor: Colors.red,     // red as default
                // accentColor: Colors.amberAccent
                fontFamily: 'Overlock',
                textTheme: ThemeData.light().textTheme.copyWith(
                      headline5:
                          TextStyle(color: Colors.grey[600], fontSize: 22),
                      // huge text
                      headline6: TextStyle(
                          color: Colors.black87,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                      //title
                      subtitle2: TextStyle(color: Colors.grey),
                      //date
                      caption: TextStyle(color: Colors.black38),
                      //chart
                      button: TextStyle(color: Colors.white),
                    )),
            home: ChartScreen(),
            // const MyHomePage(title: 'Flutter Demo Home Page'),
            debugShowCheckedModeBanner: false,
          );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int countIndex =
      0; // m3rfthash fl build 3lshan kol ma y3mel rebuild hykhali el variable = 0
  int totalScore = 0;

  void resetQuiz() {
    setState(() {
      countIndex = 0;
      totalScore = 0;
    });
  }

  void answerQuestions(int score) {
    setState(() {
      countIndex = countIndex + 1;
      totalScore += score;
    });
    print("choosen answer");
  }

  @override
  Widget build(BuildContext context) {
    var Questions = [
      // lma agi bel mouse 3la Questions hala2i el type list of map of strings and object
      // leh object ?? 3lshan el key 3ebara 3an string w el value 3ebara 3an list fa da combination between datatypes
      // fa by2ol 3la enha 7aga general fa yb2a object
      {
        'QuestionText': 'What is your favourite animal ?',
        'Answer': [
          {'text': 'Cat', 'score': 4},
          {'text': 'Dog', 'score': 5},
          {'text': 'Panda', 'score': 8}
        ]
      },
      {
        'QuestionText': 'What is your favourite color ?',
        'Answer': [
          {'text': 'Red', 'score': 4},
          {'text': 'Green', 'score': 5},
          {'text': 'Purple', 'score': 8}
        ]
      },
      {
        'QuestionText': 'What is your favourite weather ?',
        'Answer': [
          {'text': 'Summer', 'score': 4},
          {'text': 'Autumn', 'score': 5},
          {'text': 'Winter', 'score': 8}
        ]
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Questions.length > countIndex
          ? Center(
              child: Column(
                children: [
                  Text(Questions[countIndex]['QuestionText'] as String),
                  // ignore: deprecated_member_use
                  ...(Questions[countIndex]['Answer']
                          as List<Map<String, Object>>)
                      .map((answer) {
                    // da goz2 el answer bb3at  el answer eli fl Questions as string 3lshan el error
                    return Answer(() => answerQuestions(answer['score'] as int),
                        answer['text'] as String); //
                  }).toList()
                  // ... three dots separator means that this line of lists and variables goes out the brackets of widget" children" to execute and goes back again to avoid errors
                  //
                ],
              ),
            )
          : resultScreen(totalScore, resetQuiz), //result
    );
  }
}
