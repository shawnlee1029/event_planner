import 'package:flutter/material.dart';

class Event {
  final int id;
  final String title;
  final String description;
  final DateTime _startDate;
  final DateTime _endDate;
  late final DateTimeRange dateRange = DateTimeRange(start:_startDate,end:_endDate);
  Event(this.title, this.description,this._startDate, this._endDate, this.id);


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
