import 'package:event_planner/view/event_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_planner/view_model/event_view_model.dart';

class EventViewer extends StatelessWidget {
  final bool usingFireStore;
  const EventViewer({super.key, this.usingFireStore = true});

  @override
  Widget build(BuildContext context) {
    final eventViewModel = context.watch<EventViewModel>();
    final eventListFuture = usingFireStore ? eventViewModel.fireStoreEvents : eventViewModel.dbEvents;
    return FutureBuilder(
        future: eventListFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final eventList = snapshot.data!;
            return ListView.builder(
                itemCount: eventList.length,
                itemBuilder: (context, index) => EventCard(eventList[index]));
          }
          return const CircularProgressIndicator();
        }
    );
  }
}
