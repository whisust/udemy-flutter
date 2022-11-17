import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final _dateFormat = DateFormat.yMMMd();
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList({
    super.key,
    required this.transactions,
    required this.deleteTransaction,
  });

  Widget _itemBuilder(BuildContext context, int index) {
    final tx = transactions.elementAt(index);
    return Card(
        child: Row(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(border: Border.all(color: Theme.of(context).primaryColorDark, width: 2)),
            padding: const EdgeInsets.all(10),
            child: Text(
              '\$${tx.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ),
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tx.title, style: Theme.of(context).textTheme.titleLarge),
            Text(_dateFormat.format(tx.date), style: Theme.of(context).textTheme.titleSmall)
          ],
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(children: [
              Text('No transactions added yet!', style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 20),
              Container(
                height: constraints.maxHeight * 0.6,
                child: Image.asset('resources/assets/images/waiting.png', fit: BoxFit.cover),
              )
            ]);
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return TransactionItem(transaction: transactions[index], deleteTransaction: deleteTransaction);
            },
            itemCount: transactions.length,
          );
  }
}
