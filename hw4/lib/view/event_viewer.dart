import 'package:event_planner/view/event_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:event_planner/view_model/event_view_model.dart';

class EventViewer extends StatelessWidget {
  const EventViewer({super.key});

  // _onEdit(int index, DateTimeRange dateTimeRange, BuildContext context,
  //     EventViewModel eventViewModel) async {
  //   final DateTimeRange? dateRangePicked = await showDateRangePicker(
  //       context: context,
  //       initialDateRange: dateTimeRange,
  //       firstDate: DateTime(2023),
  //       lastDate: DateTime(2123));
  //   if (dateRangePicked != null) {
  //     eventViewModel.editEventDateRange(dateRangePicked, index);
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    final eventViewModel = context.watch<EventViewModel>();
    final eventListFuture = eventViewModel.events;
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
