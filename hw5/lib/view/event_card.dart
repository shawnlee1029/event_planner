import 'package:event_planner/view_model/event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:event_planner/view/event_details_view_button.dart';
import 'package:event_planner/view_model/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard(this.event, {super.key});

  _onDelete(EventViewModel eventViewModel) async {
    eventViewModel.removeEvent(event);
  }

  @override
  Widget build(BuildContext context) {
    final eventViewModel = context.watch<EventViewModel>();
    return SizedBox(
        height: 115,
        child: Card(
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: ListTile(
              title: Text(event.title),
              subtitle: Text(
                  '${event.description}${event.strStartDateTime}\t${event.strEndDateTime}'),
              trailing: Wrap(
                spacing: 5,
                children: [
                  EventDetailsViewButton(index: event.id),
                  ElevatedButton(
                      onPressed: eventViewModel.usingFireStore
                          ? null
                          : () {
                              context.push('/form/${event.id}');
                            },
                      child: const Text('Edit')),
                  ElevatedButton(
                    onPressed: eventViewModel.usingFireStore
                        ? null
                        : () {
                            _onDelete(eventViewModel);
                          },
                    child: const Icon(Icons.delete_sharp),
                  ),
                ],
              ),
            )));
  }
}
