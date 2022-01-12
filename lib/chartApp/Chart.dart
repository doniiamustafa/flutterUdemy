import 'package:flutter/material.dart';
import 'package:flutter_udemy/chartApp/models/transactions.dart';
import 'package:flutter_udemy/chartApp/widgets/Chart_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(
          days:
              index)); //3aiz ageb yesterday fa hy3mel subtract lel index=1 - datetime.now

      double totalSum =
          0.0; // each bar : we want to find all the transactions which happened in this day and sum them up
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date!.day == weekDay.day &&
            recentTransactions[i].date!.month == weekDay.month &&
            recentTransactions[i].date!.year == weekDay.year) {
          totalSum += recentTransactions[i].amount!;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1), // awel 7arf bs
        'amount': totalSum
      }; // shortcut for weekdays ex: S M T W T F S
    }).reversed.toList();
    // 3amlt reversed 3lshan 3iza el older days 3la el shemal w el now day 3la el yemen
  }

  double get totalSpending {
    // to calculate the percentage
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            // data refers to the selected item in the list, i.e: any variable passed in the parameter bsameeh ay 7aga
            // return Text('${data['day']}: ${data['amount']}'); }).toList(),  // before chartbars
            return Flexible(
              fit: FlexFit.tight,  // 3lshan tzbat el masafat ben el bars mahma el rakam yekbar tb2a el masafat equal ben el bars
              child: ChartBar(
                  data['day'].toString(),
                  data['amount'] as double,
                  totalSpending == 0.0 ? 0.0 : ( data['amount'] as double) / totalSpending
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
