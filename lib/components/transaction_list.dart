import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: transactions.isEmpty ? Column(
        children: [
          SizedBox(height: 15),
          Text(
            'Nenhuma Transação Cadastrada!',
             style: AppBarTheme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 30),
          Container(
            height: 200,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ) : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          final tr = transactions[index];
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text(
                      'R\$${tr.value}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              title: Text(
                tr.title,
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                DateFormat('d MMM y').format(tr.date)
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  onRemove(tr.id);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
