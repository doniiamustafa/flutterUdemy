import 'package:flutter/material.dart';

class buttonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.orange, onPrimary: Colors.white),
                child: Text('A Raised button'),
                onPressed: () {
                  print('A raised button pressed');
                }),
            TextButton(
                child: Text('A Flat button'),
                style: TextButton.styleFrom(primary: Colors.orange),
                onPressed: (){
                  print('A Flat button pressed');
                },
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  primary: Colors.orange,
                  side: BorderSide(color: Colors.orange)
              ),
              child: Text('An Outline button'),
              onPressed: () {print('An Outlined button pressed');},
            ),
          ],
        ),
      ),
    );
  }
}
