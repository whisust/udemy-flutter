import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final _dateFormat = DateFormat.yMMMd();
  final List<Transaction> transactions;

  TransactionList({super.key, required this.transactions});

  Widget _itemBuilder(BuildContext context, int index) {
    final tx = transactions.elementAt(index);
    return Card(
        child: Row(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 2)),
            padding: const EdgeInsets.all(10),
            child: Text(
              '\$${tx.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.purple,
              ),
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tx.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(_dateFormat.format(tx.date),
                style: const TextStyle(
                  color: Colors.grey,
                ))
          ],
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        child: ListView.builder(
          itemBuilder: _itemBuilder,
          itemCount: transactions.length,
        ));
  }
}
