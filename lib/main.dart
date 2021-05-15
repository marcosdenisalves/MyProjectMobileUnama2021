import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import './components/transaction_form.dart';
import './components/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'components/login.dart';
import 'models/transaction.dart';
import 'dart:math';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.blueGrey,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.w200,
            ),
            button: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [

  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
          Duration(days: 7),
      ));
    }).toList();
  }
  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
     setState(() {
       _transactions.removeWhere((tr) {
        return tr.id == id;
      });
     });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Despesas Pessoais'),
        actions: [
          IconButton(
            icon: Hero(
              tag: 'hero',
                child: Icon(Icons.logout)),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          Chart(_recentTransactions),
          TransactionList(_transactions, _removeTransaction),
        ],
      ),
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Theme.of(context).accentColor,
      onPressed: () => _openTransactionFormModal(context),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
