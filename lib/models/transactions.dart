import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final DateTime date;
  final int amount;
  final String topic;

  Transaction({
    @required this.id,
    @required this.topic,
    @required this.date,
    @required this.amount,
  });
}
