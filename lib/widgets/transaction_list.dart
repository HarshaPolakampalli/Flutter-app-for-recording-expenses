import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/Transaction.dart';

class TransactionsList extends StatelessWidget {
  List<Transaction> transactions;

  Function deleteTx;
  TransactionsList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text("No transaction found",
                      style: Theme.of(context).textTheme.subtitle1),
                  Container(
                      height: 200,
                      child: Image.asset(
                        "assets/images/empty.png",
                        fit: BoxFit.cover,
                      ))
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                                child: Text(
                                    '\u{20B9}${transactions[index].transactionvalue}'))),
                      ),
                      title: Text(
                        transactions[index].transactiontitle,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMd()
                            .format(transactions[index].transactiontime),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transactions[index].transactionid),),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
