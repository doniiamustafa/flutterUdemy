import 'package:flutter/material.dart';
import 'package:flutter_udemy/chartApp/widgets/transaction_item.dart';
import '../models/transactions.dart';

class Circle_Transaction_List extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  Circle_Transaction_List(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    // children: transactions.map((tx) {   // kont 3mla kda lma kan column bdal el listview
    //
    // }).toList(),
    return
        // Container(
        // height: MediaQuery.of(context).size.height * 0.6,    // khaleto yakhod 60% bs mn el size el available lel screen w ha7to makan el call f section4File
        // height: 525, // 7awelto l dynamically size
        transactions.isEmpty
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
                        height: constraints.maxHeight * 0.7,
                        child: Image(
                          image: AssetImage('assets/images/pinguin.png'),
                          fit: BoxFit.cover,
                        )),
                  ],
                );
              })
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return TransactionItem(transaction:transactions[index], deleteTx:deleteTx);
                },
                itemCount: transactions.length,
              );
    // );
  }
}
