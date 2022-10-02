import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double amount = recentTransactions
          .where((transaction) =>
              (transaction.date.day == weekDay.day) &&
              (transaction.date.month == weekDay.month))
          .fold(0, (amount, transaction) => amount + transaction.amount);

      return {
        'day': DateFormat.E(weekDay),
        'amount': amount,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Row(
          children: [],
        ));
  }
}
