import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class AdaptiveButton extends StatelessWidget {
  final Function handler;
   AdaptiveButton(this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
          ? CupertinoButton(
        child: Icon(Icons.date_range,color: Colors.blue,),
//                  Text(
//                    "Choose date",
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                  ),
        onPressed: handler,
      )
          : FlatButton(
        textColor: Theme.of(context).primaryColor,
        child: Icon(Icons.date_range),
//                  Text(
//                    "Choose date",
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                  ),
        onPressed: handler,
    );
  }
}
