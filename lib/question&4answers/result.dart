import 'package:flutter/material.dart';

class resultScreen extends StatelessWidget {
  final int score;
  final Function resetHandler;                 // function carrier
  resultScreen(this.score , this.resetHandler);

  String get resultPhrase {
    String resultText;
    if (score == 12) {
      resultText = 'Hard Luck :(';
    } else if (15 >= score) {
      resultText = 'Welcome to the safe zone';
    } else {
      resultText = 'FULL MARK *';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Column(
        children: [
          Text(
            resultPhrase.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          TextButton(
            child: Text('Restart Quiz' , style: TextStyle(color: Colors.blue),),
            style: TextButton.styleFrom(primary: Colors.orange),
            onPressed: () {
              resetHandler();
            },
          ),
        ],
      )),
    );
  }
}
