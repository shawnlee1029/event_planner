import 'package:event_planner/view/event_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/event_view_model.dart';

class EventFormPage extends StatelessWidget {
  final int? eventId;
  const EventFormPage({Key? key, this.eventId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eventViewModel = context.read<EventViewModel>();
    final eventsFuture = eventViewModel.events;
    return Scaffold(
        appBar: AppBar(),
        body: eventId == null ? const EventForm() : FutureBuilder(
            future: eventsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final events = snapshot.data!;
                final index = events.indexWhere((event) => event.id == eventId);
                return EventForm(event: events[index]);
              }
              return const CircularProgressIndicator();
            })
    );
  }
}