import 'package:event_planner/view/event_form.dart';
import 'package:flutter/material.dart';

class EventFormPage extends StatelessWidget {
  const EventFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const EventForm(),
    );
  }
}
