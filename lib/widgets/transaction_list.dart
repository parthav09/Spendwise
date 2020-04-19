import 'package:flutter/material.dart';
import 'package:spendwise/models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;

  TransactionList(this.transactions,this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "You have no expenses!!",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/zzz-sleep-png-6.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                            child: Text('\$${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].id,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: IconButton(
                        icon: Icon(
                      Icons.delete_outline,
                      color: Theme.of(context).errorColor,
                    ),
                    onPressed: () {_deleteTransaction(transactions[index].id);}
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            );
  }
}
