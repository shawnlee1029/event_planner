import 'package:event_planner/view_model/event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:event_planner/view_model/event.dart';

class _EventDetailsBody extends StatelessWidget {
  final Event event;

  const _EventDetailsBody(this.event, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(event.title, style: Theme
                .of(context)
                .textTheme
                .displayMedium),
            Text(event.description,
                style: Theme
                    .of(context)
                    .textTheme
                    .displaySmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${event.startDate}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium),
                const VerticalDivider(),
                Text('${event.endDate}')
              ],
            ),
          ],
        ));
  }
}

class EventDetailsViewer extends StatelessWidget {
  final int id;

  const EventDetailsViewer(this.id, {super.key});

  onNextPressed(int index, List list, BuildContext context) {
    int nextIndex = index < list.length - 1 ? ++index : 0;
    context.push('/event/${list[nextIndex].id}');
  }
  onPreviousPressed(int index, List list, BuildContext context) {
    int prevIndex = index > 0 ? --index : list.length - 1;
    context.push('/event/${list[prevIndex].id}');
  }

  @override
  Widget build(BuildContext context) {
    final eventViewModel = context.read<EventViewModel>();
    final eventsFuture = eventViewModel.events;
    return FutureBuilder(
        future: eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final events = snapshot.data!;
            final index = events.indexWhere((event) => event.id == id);
            return Column(children: [
              _EventDetailsBody(events[index]),
              Row(children: [
                OutlinedButton(
                    onPressed: () => onPreviousPressed(index, events, context),
                    child: const Icon(Icons.chevron_left)),
                OutlinedButton(
                    onPressed: () => onNextPressed(index, events, context),
                    child: const Icon(Icons.chevron_right))
              ])
            ]);
          }
          return const CircularProgressIndicator();
        });
  }
}
