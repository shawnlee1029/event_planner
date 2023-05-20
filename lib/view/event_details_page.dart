import 'package:event_planner/view_model/event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/event.dart';
import 'event_details_viewer.dart';

class EventDetailsPage extends StatelessWidget {
  final int? eventId;
  const EventDetailsPage({ this.eventId, super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: eventId == null ?
      const Text('No events here') : EventDetailsViewer(eventId!),
    );
  }
}
