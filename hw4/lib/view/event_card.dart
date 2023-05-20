import 'package:event_planner/view_model/event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_planner/view/event_details_view_button.dart';
import 'package:event_planner/view_model/event.dart';

class EventCard extends StatelessWidget {
  // final int index;
  // final List<String> titles;
  // final List<String> descriptions;
  // final List<String> durations;
  final Event event;

  const EventCard(this.event, {super.key});


  void _onEdit(EventViewModel eventViewModel) async{

    eventViewModel.editDateTimeRange(DateTime(11), DateTime(12), event.id);
  }

  _onDelete(EventViewModel eventViewModel) async {
    eventViewModel.removeEvent(event);
  }

  @override
  Widget build(BuildContext context) {
    final eventViewModel = context.watch<EventViewModel>();

    return Card(
        child: ListTile(
      title: Text(event.title),
      subtitle: Text(
          '${event.description}\n${event.startDate}\t ${event.endDate}'),
      trailing: Wrap(
        spacing: 5,
        children: [
          // Text('$index'),
          EventDetailsViewButton(index: event.id),
          ElevatedButton(onPressed: () => _onEdit(eventViewModel), child: const Text('Edit')),
          ElevatedButton(
            onPressed: () {
              _onDelete(eventViewModel);
            },
            child: const Icon(Icons.delete_sharp),
          ),
        ],
      ),
    ));
  }

}
