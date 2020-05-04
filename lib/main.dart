import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spendwise/intropage.dart';
import 'package:spendwise/models/transactions.dart';
import 'package:spendwise/widgets/chart.dart';
import 'package:spendwise/widgets/newtransactionlist.dart';
import 'package:spendwise/widgets/transaction_list.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
        defaultBrightness: Brightness.dark,
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
                    color: Colors.lightBlue,
                  ),
                ),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.dark().textTheme.copyWith(
                    title: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            )),
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
            title: 'Flutter App',
            home: MyHomePage(),
            theme: theme,
            debugShowCheckedModeBanner: false,
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

  void _selectpage(BuildContext ctx){
    Navigator.of(ctx).push(CupertinoPageRoute(builder: (_){
      return IntroPage();
    }));
  }

//  void _selectcategory(BuildContext ctx) {
//    Navigator.of(ctx).push(CupertinoPageRoute(builder: (_) {
//      return CategoryMealsScreen();
//    }));
//  }

  final List<Transaction> _usertransactions = [];
  bool _showchart = false;

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

  void _deleteTransaction(String id) {
    setState(() {
      _usertransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startNewTransactions(BuildContext ctx) {
    showModalBottomSheet(
      //backgroundColor: Theme.of(context).primaryColor,
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
    final mediaquery = MediaQuery.of(context);
    final islandscape = mediaquery.orientation == Orientation.landscape;
    final PreferredSizeWidget appbar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Spendwise"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startNewTransactions(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text("Spendwise"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.wb_sunny),
                onPressed: () {
                  changeBrightness();
                },
              ),
              IconButton(
                icon: Icon(Icons.add),
                color: Theme.of(context).accentColor,
                onPressed: () => _startNewTransactions(context),
              ),
            ],
          );
    final bottomnavbar = BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Colors.blue,
      child: Container(
        height: (mediaquery.size.height -
                appbar.preferredSize.height -
                mediaquery.padding.top) *
            0.08,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                size: 26,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.info,
                size: 26,
              ),
              onPressed: ()=> _selectpage(context),
            ),
          ],
        ),
      ),
    );

    final txListwidget = Container(
        height: (mediaquery.size.height -
                appbar.preferredSize.height -
                mediaquery.padding.top) *
            0.62,
        child: TransactionList(_usertransactions, _deleteTransaction));

    final appbody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (islandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Show chart',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Switch.adaptive(
                    value: _showchart,
                    onChanged: (val) {
                      setState(() {
                        _showchart = val;
                      });
                    },
                  ),
                ],
              ),
            if (!islandscape)
              Container(
                  height: (mediaquery.size.height -
                          appbar.preferredSize.height -
                          mediaquery.padding.top) *
                      0.3,
                  child: Chart(_recentTransactions)),
            if (!islandscape) txListwidget,
            if (islandscape)
              _showchart
                  ? Container(
                      height: (mediaquery.size.height -
                              appbar.preferredSize.height -
                              mediaquery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions))
                  : txListwidget
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: appbody,
            navigationBar: appbar,
          )
        : Scaffold(
            appBar: appbar,
            bottomNavigationBar: bottomnavbar,
            body: appbody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: Platform.isIOS
                ? SizedBox()
                : FloatingActionButton(
                    child: Icon(Icons.add_circle),
                    onPressed: () => _startNewTransactions(context),
                  ),
          );
  }
}
