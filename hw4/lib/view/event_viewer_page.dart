import 'package:event_planner/view/event_form_button.dart';
import 'package:event_planner/view/event_viewer.dart';
import 'package:event_planner/view/event_viewer_app_bar.dart';
import 'package:flutter/material.dart';

class EventViewerPage extends StatelessWidget {
  const EventViewerPage({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: EventViewerAppBar(),
        body: EventViewer(),
        floatingActionButton: EventFormButton());
  }

}

