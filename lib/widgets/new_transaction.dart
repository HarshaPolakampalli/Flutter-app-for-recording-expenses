import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function interactionFunction;

  NewTransaction(this.interactionFunction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final expenseController = TextEditingController();

  DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                  decoration: InputDecoration(labelText: "Title"),
                  controller: titleController,
                  textInputAction: TextInputAction.next),
              TextField(
                decoration: InputDecoration(labelText: "Expense"),
                controller: expenseController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => onsubmitTransaction,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(selectedDate == null
                            ? "No Date Choosen!"
                            : 'Picked Date ${DateFormat.yMd().format(selectedDate)}')),
                    FlatButton(
                        onPressed: pickUpDate,
                        textColor: Theme.of(context).primaryColor,
                        child: Text("Choose Date",
                            style: TextStyle(fontWeight: FontWeight.bold)))
                  ],
                ),
              ),
              RaisedButton(
                  onPressed: onsubmitTransaction,
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: Text("Add Transaction"))
            ]));
  }

  void onsubmitTransaction() {


    if(expenseController.text.isEmpty){
      return;
    }

    String title = titleController.text;

    double amount = double.parse(expenseController.text);

    if (title.isEmpty || amount <= 0||selectedDate==null) {
      return;
    }
    widget.interactionFunction(title, amount,selectedDate);

    Navigator.pop(context);
  }

  void pickUpDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((selecteddate) {
      if (selecteddate == null) {
        return;
      } else {
        setState(() {
          selectedDate = selecteddate;
        });
      }
    });
  }
}
