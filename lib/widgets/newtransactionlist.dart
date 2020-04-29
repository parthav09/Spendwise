import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = int.parse(_amountController.text);

    if (_amountController.text.isEmpty) {
      return;
    }

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              Row(
                children: <Widget>[
                  Text(
                    _selectedDate == null
                        ? "No Date chosen"
                        : DateFormat.yMd().format(_selectedDate),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.date_range),
//                  Text(
//                    "Choose date",
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                  ),
                    onPressed: _datePicker,
                  ),
                ],
              ),
              FloatingActionButton(
                child: Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                ),
                //child: Text('Add Transaction'),
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
