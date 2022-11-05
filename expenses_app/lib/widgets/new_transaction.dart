import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_button.dart';

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
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      AdaptiveFlatButton(text: 'Choose date', onPressed: _presentDatePicker)
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
          )),
    );
  }
}
