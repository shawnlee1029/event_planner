// import 'package:event_planner/view_model/event_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
//
// class EventDetailsNavButton extends StatelessWidget {
//   final int index;
//   final bool next;
//
//   const EventDetailsNavButton(
//       {Key? key, required this.index, required this.next})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final eventViewModel = context.read<EventViewModel>();
//     return next
//         ? OutlinedButton(
//             onPressed: () {
//               if (eventViewModel.eventCount != 1) {
//                 int next = index + 1;
//                 if (next > eventViewModel.eventCount - 1) next = 0;
//                 context.push('/event/$next');
//               }
//             },
//             child: const Icon(Icons.chevron_right))
//         : OutlinedButton(
//             onPressed: () {
//               if (eventViewModel.eventCount != 1) {
//                 int prev = index - 1;
//                 if (prev < 0) prev = eventViewModel.eventCount - 1;
//                 context.push('/event/$prev');
//               }
//             },
//             child: const Icon(Icons.chevron_left),
//           );
//   }
// }
