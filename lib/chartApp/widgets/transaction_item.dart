import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function deleteTx;
  const TransactionItem({required this.transaction , required this.deleteTx});
  // improvements; put const infront of constructor in the classes which have final variables
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        // shal el card w 3mal ListTitle w fl akher 3amlha wrap bel card 3lshan tedi shakl a7san
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          transaction.title.toString(),
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
          style: Theme.of(context).textTheme.subtitle2,
        ),
        trailing: MediaQuery.of(context).size.width > 360    // 3la 7sab 7agm el screen law kbeer y3red el icon gambha el text
            ? FlatButton.icon(
          onPressed: () => deleteTx(transaction.id),
          icon: Icon(Icons.delete), label: Text('Delete'),
          textColor: Theme.of(context).errorColor,
        )
            : IconButton(
          onPressed: () => deleteTx(transaction.id),
          //di tare2t ktabet call el function eli leha argument
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }
}
