import 'package:event_planner/view_model/event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventViewerAppBar extends StatefulWidget with PreferredSizeWidget{
  const EventViewerAppBar({Key? key}) : super(key: key);

  @override
  State<EventViewerAppBar> createState() => _EventViewerAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _EventViewerAppBarState extends State<EventViewerAppBar> {

  bool allowNavigation = true;

  _onToggleFilterPastEvents() {
    final eventViewModel = context.read<EventViewModel>();
    setState(() {
      eventViewModel.toggleFilter();
    });
    print('filter: ${eventViewModel.filterPastEvents}');

  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Event Planner'),
      actions: [
        InkWell(
            onTap: _onToggleFilterPastEvents,
            child: context.read<EventViewModel>().filterPastEvents
                ? const Icon(Icons.filter_alt)
                : const Icon(Icons.filter_alt_off))
      ],
  );
  }
}
