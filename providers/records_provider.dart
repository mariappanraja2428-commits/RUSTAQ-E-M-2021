import 'package:flutter/material.dart';
import '../models/record.dart';

class RecordsProvider extends ChangeNotifier {
  List<Record> records = [];

  void addRecord(Record record) {
    records.add(record);
    notifyListeners();
  }

  List<Record> getRecordsByArea(String area) {
    return records.where((r) => r.area == area).toList();
  }
}
