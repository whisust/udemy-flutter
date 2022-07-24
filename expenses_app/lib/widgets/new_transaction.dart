import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({super.key, required this.addTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  void submitForm() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if (title.isNotEmpty && amount >= 0) {
      widget.addTransaction(title, amount);
    }

    Navigator.of(context).pop();
  }

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
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitForm()),
          TextButton(
            style: TextButton.styleFrom(primary: Colors.purple),
            onPressed: submitForm,
            child: const Text('Create transaction'),
          )
        ],
      ),
    ));
  }
}
