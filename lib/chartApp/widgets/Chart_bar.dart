import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double? spendingPercentOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text(
                '\$${spendingAmount.toStringAsFixed(0)}',
                // style: TextStyle(fontSize: 10.0),
              ))),
          // container bel height 3lshan el amount yb2a fixed f height mo3ian w aligned mayt7raksh law el rakam kber aw soghyar
          // AsFixed=no decimal places ,
          // FittedBox 3lshan  el el child eli howa el text maykhrogsh bara wla y3mel break lines
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentOfTotal,
                  // byakhod height between 0 and 1 ya3ne 7aga %
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),   //5%
          Container(
              height: constraints.maxHeight * 0.15,  //15%
              child: FittedBox(child: Text(label))
            // 3lshan law el screen soghyra awi w el text tla3 bra el height el fitted box y3melo rearrange
          ),
        ],
      );
    });
  }
}
