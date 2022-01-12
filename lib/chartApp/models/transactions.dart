import 'package:flutter/cupertino.dart';

class Transaction {
  final String? id;              // this variable can hold null or its main datatype which is string
  final String? title;
  final double? amount;
  final DateTime? date;

  Transaction({
      @required this.id,             // @required user must fill this data
      @required this.title,
      @required this.amount,
      @required this.date
      });
}
