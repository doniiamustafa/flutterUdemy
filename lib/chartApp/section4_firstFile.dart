import 'dart:io'; // lazem 3lshan a7aded el platform android / ios

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_udemy/chartApp/widgets/transactionListUsingListTitle.dart';
import 'package:flutter_udemy/chartApp/widgets/new_transaction.dart';
import 'package:flutter_udemy/chartApp/Chart.dart';
import 'package:flutter_udemy/chartApp/models/transactions.dart';
import 'package:flutter_udemy/chartApp/widgets/transaction_list.dart';

class ChartScreen extends StatefulWidget {
  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> with WidgetsBindingObserver {
  final List<Transaction> userTransactions = [
    // if you want to add a list manually
    // Transaction(
    //     id: '0000A', title: 'Groceries', amount: 19.99, date: DateTime.now()),
    // Transaction(
    //     id: '0001A', title: 'Fishers', amount: 10.51, date: DateTime.now()),
    // Transaction(
    //     id: '0002A', title: 'Hammers', amount: 12.99, date: DateTime.now()),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);   // create listener
  }

  @override
  void didChangedAppLifecycleState(AppLifecycleState state){
    //3lshan ashof el phases eli bymor beha el app lazem a3mel listener fl initState w a3melo remove b3d ma akhlas fl dispose
    print(state);
  }

  @override
  dispose(){
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);   // remove listener
  }

  bool showChart = false;

  List<Transaction> get recentTransactions {
    //function dynamically calculated something and didn't have parameters just have body
    return userTransactions.where((tx) {
      return tx.date!.isAfter(DateTime.now().subtract(
          Duration(days: 7))); //! refers to null checker el compiler 3amlha
      //ya3ne hatrga3li el date eli akbar men > now - 7 days 3lshan a7seb el amount f kol yom fl asbo3
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosenDate) {
    final newtx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: choosenDate,
    );
    setState(() {
      userTransactions.add(newtx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    //_became private fn to chartscreen class
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior
                .opaque, //lma ados 3la el background hy3mel close lel bottomsheet
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      userTransactions.removeWhere(
          (tx) => tx.id == id); //leh bool 3lshan el removeAt fn btkhod bool
    });
  }

  // Builder Method *******************************************************************************************

  List<Widget> _buildPortraitScreen(AppBar appBar , Widget circleTransactionList) {
    return [Container(
        // if button is enabled , == true
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.3,
        // hashel el height bta3 el appbar w el status bar w adrab el ba2i f 40% mn m2as el screen
        child: Chart(userTransactions)), circleTransactionList,];
  }

  List<Widget> _buildLandscapeScreen(AppBar appBar, Widget circleTransactionList) {
    return [
      Row(
        // 3lshan ana msh 3iza( : else )fa lazem akteb el if bel tare2a di , el : optional fl tare2a di t7oteha aw la
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Switch.adaptive(
              // adaptive hena 7atetha 3lshan el ios platform y3mel el design as default lel ios , adjust the look based on the platform
              value: showChart,
              onChanged: (val) {
                setState(() {
                  showChart =
                      val; //eli el user hykhtaro h7oto fl variable showChart
                });
              })
        ],
      ),
      showChart
          ? Container(
              // if button is enabled , == true
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              // hashel el height bta3 el appbar w el status bar w adrab el ba2i f 40% mn m2as el screen
              child: Chart(userTransactions))
            // Transaction_List(userTransactions), // law 3iza shakl el list squares
          : circleTransactionList,
    ];
  }

  Widget _buildIosAppBar(){
    return CupertinoNavigationBar(
      middle: Text('Daily Expenses'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Icon(
              CupertinoIcons.add,
            ),
            onTap: () => _startAddNewTransaction(context),
          ),
        ],
      ),
    );
  }
  Widget _buildAndroidAppBar(){
    return AppBar(
      title: Text('Daily Expenses'),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add)),
      ],
    );
  }

  // end Builder Method *******************************************************************************************


  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final dynamic appBar = Platform
            .isIOS // 3amlt el appbar dynamic 3lshan el cupertino byakhod obstractingPreferedSize
        // w el appbar btakhod preferedSize fa bytla3 error
        ? _buildIosAppBar()
        : _buildAndroidAppBar();

    final circleTransactionList = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: Circle_Transaction_List(userTransactions, _deleteTransaction));

    final pageBody = SafeArea(
      //safeArea respects reserved areas on the screen
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandScape)
              ..._buildLandscapeScreen(appBar,circleTransactionList ),    // (...) Spread Operator ba7otha 3lshan el children bta3et el col 3ebara 3an list of widgets w el return type bta3 el function list of widgets

              if (!isLandScape)
                ..._buildPortraitScreen(appBar , circleTransactionList),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            // ha7ot el app bar fy variable/object 3lshan hastakhdem el var da f calculating dynamic size
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
