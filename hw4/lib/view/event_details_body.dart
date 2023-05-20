import 'package:event_planner/view_model//event_view_model.dart';
import 'package:event_planner/view_model/event.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'event_details_nav_button.dart';

class EventDetailsBody extends StatelessWidget {
  final Event event;
  const EventDetailsBody( this.event,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(event.title, style: Theme.of(context).textTheme.displayMedium),
        Text(event.description,
            style: Theme.of(context).textTheme.displaySmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${event.startDate}',
                style: Theme.of(context).textTheme.bodyMedium),
            const VerticalDivider(),
            Text('${event.endDate}')
          ],
        ),

      ],
    ));
  }
}
