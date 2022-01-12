import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udemy/chartApp/widgets/adaptive_flat_button.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTX;

  NewTransaction(this.addTX){
    print('Constructor NewTransaction');
  }

  @override
  State<NewTransaction> createState() {
    print('CreateState() NewTransaction');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleConrtoller = TextEditingController();
  final _amountController = TextEditingController();
  DateTime?_selectedDate; // msh ha3melo final 3lshan howa bytghyar 3la 7sab ma el user bykhtar

 _NewTransactionState(){
   print('Constructor New Transaction State');
 }
 @override
  void initState() {
    super.initState();    // it is recommended to call super.initstate() first before any statement, actually it wil not make any difference it just make some checks in parent class (NewTransactionState) that everything is okay and execute print statement.
    print("initState");
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
   print("didUpdateWidget");
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
   print("dispose");
    // TODO: implement dispose
    super.dispose();
  }
  void _submittedData() {
    final String enteredTitle = _titleConrtoller.text;
    final double enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0 || _selectedDate == null) {
      return;
    }

    widget.addTX(enteredTitle, enteredAmount, _selectedDate);
    //widget. i can access the properties in another connected class at the same model like that and only available in state classes

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if (datePicked == null) {
        return;
      }
      setState(() {
        _selectedDate = datePicked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (Platform.isIOS)
            CupertinoTextField(
              placeholder: 'Title',
            ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
              labelStyle: TextStyle(color: Colors.purple),
            ),
            controller: _titleConrtoller,
            onSubmitted: (_) =>
                _submittedData, // 3lshan at2aked eno mdkhal 7orof bs w msh empty
            // el underscore di means didn't care about the parameter but it is required
            // 3lshan on submitted btakhod void fn b parameter string as required
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.purple)),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _submittedData,
          ),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null
                      ? 'No date choosen!'
                      : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                ),

                Platform.isIOS
                    ? CupertinoButton(child: Text('Choose Date'),onPressed: _presentDatePicker,)
                   // ignore: deprecated_member_use
                    : FlatButton(
                        onPressed: _presentDatePicker,
                        textColor: Theme.of(context).primaryColor,
                        child: Text('Choose Date')
                ),

                // AdaptiveFlatButton('ChoosenDate', _presentDatePicker)    //law 3iza astakhdem el adaptive flat button file

              ],
            ),
          ),
          RaisedButton(
              child: Text('Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button!.color,
              // textColor: Colors.white,
              // style: TextButton.styleFrom(primary: Colors.purple),
              onPressed: _submittedData),
        ],
      ),
    );
  }
}
