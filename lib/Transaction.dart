import 'dart:ffi';

import 'package:flutter/foundation.dart';

class Transaction {
  
  int? id;
  String? category;
  String? note;
  double? amount;
  String? type;
  String? activity_time;
  String? created_time;
  String? modified_time;

  transactionMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['category'] = category;
    map['note'] = note;
    map['amount'] = amount;
    map['type'] = type;
    map['activity_time'] = activity_time;
    map['created_time'] = created_time;
    map['modified_time'] = modified_time;
    return map;
  }

}
