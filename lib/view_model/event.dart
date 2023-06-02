import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Event {

  final int id;
  final String title;
  final String description;
  final DateTime _startDate;
  final DateTime _endDate;
  late final DateTimeRange dateRange = DateTimeRange(start:_startDate,end:_endDate);
  Event(this.title, this.description,this._startDate, this._endDate, this.id);

  String get strStartDateTime => DateFormat.yMd().add_jm().format(_startDate);
  String get strEndDateTime=> DateFormat.yMd().add_jm().format(_endDate);
  String get strStartDate => DateFormat().add_yMd().format(_startDate);
  String get strEndDate => DateFormat().add_yMd().format(_endDate);
  String get strStartTime => DateFormat().add_jm().format(_startDate);
  String get strEndTime => DateFormat().add_jm().format(_endDate);

  @override
  bool operator ==(Object other)  => other is Event && other.id == id;

  @override
  int get hashCode => id;
  @override
  String toString() {
    return '$title:\t$description\t${_monthDayYear(startDate)} - ${_monthDayYear(endDate)}';
  }
  DateTime get startDate => dateRange.start;
  DateTime get endDate => dateRange.end;

  String _monthDayYear(DateTime date) {
    String month = date.month.toString();
    String day = date.day.toString();
    String year = date.year.toString();
    return '$month/$day/$year';
  }
}
