import 'package:flutter/material.dart';

class AssignButton extends StatefulWidget {
  @override
  State<AssignButton> createState() => _AssignButtonState();
}

class _AssignButtonState extends State<AssignButton> {
  List changingText = [
    'hello number 1',
    'hello number 2',
    'hello number 3',
    'hello number 4',
    'hello number 5'
  ];

  int listIndex = 0;

  int countIndex() {
    listIndex > changingText.length
        ? print('failed :(')
        : setState(() {
            listIndex = listIndex + 1;
          });
    return listIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(changingText[listIndex]),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange, onPrimary: Colors.white),
                child: Text('A Raised button'),
                onPressed: () {
                  countIndex();
                  print('A raised button pressed');
                }),
          ],
        ),
      ),
    );
  }
}
