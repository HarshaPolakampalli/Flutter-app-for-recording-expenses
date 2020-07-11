import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';

import './models/Transaction.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Recorder',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          errorColor: Colors.red,
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
              headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 16),button:TextStyle(color: Colors.white)),

          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    /*Transaction("1", "Weekly Expense", 20.89, DateTime.now()),
    Transaction("2", "Monthly Expense", 50.89, DateTime.now())*/
  ];

  List<Transaction> get recentTransaction {
    return transactions.where((tx){
      return tx.transactiontime.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addTransaction(String txName, double txAmount,DateTime selectedTime) {
    final newTransaction = Transaction(
        new DateTime.now().toString(), txName, txAmount, selectedTime);

    setState(() {
      transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Recorder"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => showbottomSheetAddTransaction(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Chart(recentTransaction),
            TransactionsList(transactions,deleteTransaction)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showbottomSheetAddTransaction(context)),
    );
  }

  void showbottomSheetAddTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewTransaction(addTransaction);
        });
  }
  void deleteTransaction(String id){
    setState(() {
      transactions.removeWhere((tx){
        return tx.transactionid==id;
      });
    });

  }

  void encryptData(String stringToBeEncrypted) {
    final plainText = stringToBeEncrypted;
    final key = Encrypted.fromUtf8('mabzwENTsmb82605');
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
    print(encrypted.base64);
  }
}
