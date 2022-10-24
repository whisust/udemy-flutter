import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double amount = recentTransactions
          .where((transaction) => (transaction.date.day == weekDay.day) && (transaction.date.month == weekDay.month))
          .fold(0, (amount, transaction) => amount + transaction.amount);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': amount,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, group) {
      return (group['amount'] as double) + sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((group) {
              final spendingPct = totalSpending > 0 ? (group['amount'] as double) / totalSpending : 0.0;
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    label: (group['day'] as String),
                    spendingAmount: (group['amount'] as double),
                    spendingPctTotal: spendingPct),
              );
            }).toList(),
          ),
        ));
  }
}
