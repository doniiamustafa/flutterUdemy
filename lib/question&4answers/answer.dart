import 'package:flutter/material.dart';
import '../main.dart';

class Answer extends StatelessWidget {
  final VoidCallback
      selectHandler; // variable to carry the value to the constructor but this value us a function
  // we can put VoidCallback instead of Function because of error
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: deprecated_member_use, prefer_const_constructors
      child: RaisedButton(
        child: Text(
          answerText,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: selectHandler,
      ),
    );
  }
}
