import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/transaction.dart';
import './new_transaction.dart';
import './transaction_list.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final uuid = Uuid();
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 'id1', title: 'New stuff', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 'id2', title: 'New stuff2', amount: 19.99, date: DateTime.now()),
    Transaction(
        id: 'id3', title: 'New stuff3', amount: 100, date: DateTime.now()),
    Transaction(
        id: 'id4', title: 'New stuff4', amount: 10.01, date: DateTime.now()),
    Transaction(
        id: 'id5', title: 'New stuff5', amount: 11.11, date: DateTime.now()),
    Transaction(
        id: 'id6', title: 'New stuff6', amount: 11.11, date: DateTime.now()),
  ];

  void _addTransaction(String title, double amount) {
    final newTransaction = Transaction(
        id: uuid.v4().toString(),
        title: title,
        amount: amount,
        date: DateTime.now());
    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      NewTransaction(addTransaction: _addTransaction),
      TransactionList(transactions: _userTransactions),
    ]);
  }
}
