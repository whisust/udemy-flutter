import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          // primarySwatch: Colors.purple,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple, accentColor: Colors.amber),
          fontFamily: 'Quicksand',
          appBarTheme:
              AppBarTheme(titleTextStyle: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w700, fontSize: 18)),
          textTheme: ThemeData.light().textTheme.copyWith(
                button: TextStyle(color: Colors.white),
              )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final uuid = Uuid();
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    return _userTransactions.where((transaction) => transaction.date.isAfter(sevenDaysAgo)).toList();
  }

  void _addTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(id: uuid.v4().toString(), title: title, amount: amount, date: date);
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
              onTap: () {}, behavior: HitTestBehavior.opaque, child: NewTransaction(addTransaction: _addTransaction));
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
        title: const Text('Personal Expenses'),
        actions: [IconButton(onPressed: () => _startAddNewTransaction(context), icon: const Icon(Icons.add))]);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransactions)),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.7,
                child: TransactionList(transactions: _userTransactions, deleteTransaction: _deleteTransaction)),
          ])),
      floatingActionButton:
          FloatingActionButton(onPressed: () => _startAddNewTransaction(context), child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
