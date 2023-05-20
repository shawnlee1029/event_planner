import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeSelector extends StatefulWidget {
  DateTime? start;
  DateTime? end;
  Function dateRangeCallBack;

  DateTimeSelector({this.start, this.end, required this.dateRangeCallBack, Key? key}) : super(key: key);

  @override
  State<DateTimeSelector> createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  late DateTimeRange _dateTimeRange;
  @override
  void initState() {
    widget.start ??= DateTime.now();
    widget.end ??= widget.start?.add(const Duration(days: 1));
    _dateTimeRange = DateTimeRange(start: widget.start!, end: widget.end!);
    super.initState();
  }

  _selectDateRange() async {
    print('Edit date range');
    final DateTimeRange? dateRangePicked = await showDateRangePicker(
        context: context,
        initialDateRange: _dateTimeRange,
        firstDate: DateTime(2023),
        lastDate: DateTime(2123));
    if (dateRangePicked != null) {
      setState(() {
        _dateTimeRange = DateTimeRange(
            start: dateRangePicked.start.copyWith(
                hour: _dateTimeRange.start.hour,
                minute: _dateTimeRange.start.minute),
            end: dateRangePicked.end.copyWith(
                hour: _dateTimeRange.end.hour,
                minute: _dateTimeRange.end.minute));
        widget.dateRangeCallBack(_dateTimeRange);
      });
    }
  }

  _selectTimeRange() async {
    DateTime start = await _selectStartTime();
    DateTime end = await _selectEndTime(start);
    print('Edit time range');
    setState(() {
      _dateTimeRange = DateTimeRange(start: start, end: end);
      widget.dateRangeCallBack(_dateTimeRange);
    });
  }

  Future<DateTime> _selectStartTime() async {
    DateTime startDate = _dateTimeRange.start;
    final TimeOfDay? timeOfDayPicked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_dateTimeRange.start));
    if (timeOfDayPicked != null) {
      startDate = _dateTimeRange.start
          .copyWith(hour: timeOfDayPicked.hour, minute: timeOfDayPicked.minute);
    }
    return startDate;
  }

  Future<DateTime> _selectEndTime(DateTime start) async {
    DateTime endDate = _dateTimeRange.end;
    final TimeOfDay? timeOfDayPicked = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(endDate));
    if (timeOfDayPicked != null) {
      endDate = _dateTimeRange.end
          .copyWith(hour: timeOfDayPicked.hour, minute: timeOfDayPicked.minute);
    }
    return endDate;
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        OutlinedButton(
            onPressed: () => _selectDateRange(),
            child: const Text('Edit Date Range')),
        OutlinedButton(
            onPressed: () => _selectTimeRange(),
            child: const Text('Edit Time Range'))
      ]),
    ],);
  }
}
