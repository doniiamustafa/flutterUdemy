import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AdaptiveFlatButton extends StatelessWidget {
  final String? text;
  final VoidCallback handler;

  AdaptiveFlatButton(this.text , this.handler);

  @override
  Widget build(BuildContext context) {
    return   Platform.isIOS
        ? CupertinoButton(child: Text(text.toString()) ,onPressed: handler,)
    // ignore: deprecated_member_use
        : FlatButton(
        onPressed: handler,
        textColor: Theme.of(context).primaryColor,
        child: Text(text.toString())
    );
  }
}
