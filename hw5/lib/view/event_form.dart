import 'package:flutter/material.dart';
import 'package:event_planner/view_model/event_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../view_model/event.dart';
import 'date_time_selector.dart';
class EventForm extends StatefulWidget {
  final Event? event;

  const EventForm({super.key, this.event});

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: null);
  final _descriptionController = TextEditingController(text: null);
  DateTimeRange _dateTimeRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 1)));

  @override
  void initState() {
    if (widget.event != null) {
      _titleController.text = widget.event!.title;
      _descriptionController.text = widget.event!.description;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  void _onEditDateRange(DateTimeRange dateTimeRange) {
    print('$_dateTimeRange -> $_dateTimeRange');
    setState(() {
      _dateTimeRange = dateTimeRange;
    });
  }

  String? _validateTitle(String? title) {
    if (title == null || title.isEmpty) {
      return 'Please enter a title.';
    }
    return null;
  }

  _submit() async {
    EventViewModel eventViewModel = context.read<EventViewModel>();
    final formState = _formKey.currentState;

    if (formState == null) {
      return;
    }
    if (formState.validate()) {
      int id = DateTime.now().millisecondsSinceEpoch;
      Event event = Event(_titleController.text,_descriptionController.text,_dateTimeRange.start,_dateTimeRange.end,id);
      final navigator = Navigator.of(context);
      if (widget.event == null) {
        if (eventViewModel.usingFireStore) {
          await eventViewModel.addFirestoreEvent(event);
        } else {
          await eventViewModel.addEvent(
              _titleController.text,
              _descriptionController.text,
              _dateTimeRange.start,
              _dateTimeRange.end);
        }
      } else {
        await eventViewModel.editEvent(
            widget.event!.id,
            _titleController.text,
            _descriptionController.text,
            _dateTimeRange.start,
            _dateTimeRange.end);
      }
      _formKey.currentState!.reset();
      _dateTimeRange =
          DateTimeRange(start: DateTime.now(), end: DateTime.now());
      navigator.pop();
    }
  }

  String _dateDisplay(DateTime dateTime) =>
      DateFormat().add_yMd().format(dateTime);

  String _timeDisplay(DateTime dateTime) =>
      DateFormat().add_jm().format(dateTime);

  @override
  Widget build(BuildContext context) {
    EventViewModel eventViewModel = context.read<EventViewModel>();
    return Column(
      children: [
        Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                    validator: _validateTitle,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Description'),
                    controller: _descriptionController,
                  ),
                  Text(
                    '${_dateDisplay(_dateTimeRange.start)} - ${_dateDisplay(_dateTimeRange.end)}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    '${_timeDisplay(_dateTimeRange.start)} - ${_timeDisplay(_dateTimeRange.end)}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  DateTimeSelector(
                      start: _dateTimeRange.start,
                      end: _dateTimeRange.end,
                      dateRangeCallBack: _onEditDateRange),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: _submit,
                            child: eventViewModel.usingFireStore ? const Text("Save to FireStore") :
                            const Text("Save Locally")),
                      ]),
                ]))
      ],
    );
  }
}
