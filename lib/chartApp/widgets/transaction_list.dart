import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';


// list 3la shakl squares

class Transaction_List extends StatelessWidget {
  final List<Transaction> transactions;

  Transaction_List(this.transactions);

  @override
  Widget build(BuildContext context) {
    // children: transactions.map((tx) {   // kont 3mla kda lma kan column bdal el listview
    //
    // }).toList(),
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No transactions yet, waiting!',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image(
                        image: AssetImage('assets/images/pinguin.png'),
                        fit: BoxFit.cover,
                      )),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) => Card(
                elevation: 5,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 14.0),
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2.0)),
                      child: Text(
                        '\$${transactions[index].amount}',
                        // kan tx.amount lma kan column w map
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transactions[index].title.toString(),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          DateFormat('yMMMMd').format(transactions[index].date),
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              itemCount: transactions.length,
            ),
    );
  }
}
