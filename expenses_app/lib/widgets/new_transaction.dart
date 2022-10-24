import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({super.key, required this.addTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime? _date;

  void _submitForm() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if (title.isNotEmpty && amount >= 0 && _date != null) {
      widget.addTransaction(title, amount, _date);
    }

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _date = pickedDate;
        });
      }
    });
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
              keyboardType: const TextInputType.numberWithOptions(decimal: true)),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(child: Text(_date == null ? 'No date chosen' : DateFormat.yMd().format(_date!))),
                ElevatedButton(
                  child: const Text('Choose date', style: TextStyle(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.button, primary: Theme.of(context).primaryColor),
                  onPressed: _presentDatePicker,
                )
              ],
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(primary: Colors.purple),
            onPressed: _submitForm,
            child: const Text('Create transaction'),
          )
        ],
      ),
    ));
  }
}
