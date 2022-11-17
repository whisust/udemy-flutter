import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor = Colors.black;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];

    _bgColor = availableColors[Random.secure().nextInt(availableColors.length)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: _bgColor,
            radius: 30,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: FittedBox(
                child: Text(
                  '\$${widget.transaction.amount.toStringAsFixed(2)}',
                ),
              ),
            )),
        title: Text(widget.transaction.title, style: Theme.of(context).textTheme.titleLarge),
        subtitle: Text(DateFormat.yMMMd().format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 450
            ? TextButton.icon(
                style: TextButton.styleFrom(primary: Theme.of(context).errorColor),
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget.deleteTransaction(widget.transaction.id);
                },
                label: Text('Delete'))
            : IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget.deleteTransaction(widget.transaction.id);
                },
                color: Theme.of(context).errorColor),
      ),
    );
  }
}
