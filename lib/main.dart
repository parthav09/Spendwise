import 'package:flutter/material.dart';
import 'package:spendwise/models/transactions.dart';
import 'package:spendwise/widgets/chart.dart';
import 'package:spendwise/widgets/newtransactionlist.dart';
import 'package:spendwise/widgets/transaction_list.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:dynamic_theme/theme_switcher_widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
          primaryColor: Colors.blue,
          accentColor: Colors.orange,
          brightness: brightness,
          primarySwatch: Colors.purple,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
        ),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
            title: 'Flutter App',
            home: MyHomePage(),
            theme: theme,
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  final List<Transaction> _usertransactions = [];

  List<Transaction> get _recentTransactions {
    return _usertransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txtitle, int txamount, DateTime chosendate) {
    final newTx = Transaction(
        topic: DateTime.now().toString(),
        amount: txamount,
        date: chosendate,
        id: txtitle);

    setState(() {
      _usertransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _usertransactions.removeWhere((tx){
        return tx.id == id;
      });
    });
  }

  void _startNewTransactions(BuildContext ctx) {
    showModalBottomSheet(
      //backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0))),
      context: ctx,
      builder: (_) {
        return GestureDetector(
          //onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spendwise"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.wb_sunny),
            onPressed: (){
              changeBrightness();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            color: Theme.of(context).accentColor,
            onPressed: () => _startNewTransactions(context),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Chart(_recentTransactions),
          TransactionList(_usertransactions,_deleteTransaction),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle),
        onPressed: () => _startNewTransactions(context),
      ),
    );
  }
}
