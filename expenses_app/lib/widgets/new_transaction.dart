import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final Function addTransaction;

  NewTransaction({super.key, required this.addTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Title'),
            controller: _titleController,
          ),
          TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController),
          TextButton(
            style: TextButton.styleFrom(primary: Colors.purple),
            onPressed: () {
              addTransaction(
                  _titleController.text, double.parse(_amountController.text));
            },
            child: const Text('Create transaction'),
          )
        ],
      ),
    ));
  }
}
