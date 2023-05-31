import 'package:event_planner/model/database_loader.dart';
import 'package:event_planner/model/event_database.dart';
import 'package:event_planner/view/event_details_page.dart';
import 'package:event_planner/view/event_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:event_planner/view_model/event_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'view/event_form_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(database: await loadDatabase()));
}

int _pathParamToInt(GoRouterState routerState, String paramKey) =>
    int.parse(routerState.pathParameters[paramKey]!);
//TODO No context.push for form page
//TODO add edit event dates functionality
final router = GoRouter(initialLocation: '/viewer', routes: [
  GoRoute(
      path: '/viewer',
      name: 'viewer',
      builder: (context, _) => const EventViewerPage()),
  GoRoute(
      path: '/form',
      name: 'form',
      builder: (context, _) => const EventFormPage(),
      routes: [
        GoRoute(
            path: ':eventId',
            builder: (context, routerState) => EventFormPage(
                eventId: _pathParamToInt(routerState, 'eventId')))
      ]),
  GoRoute(
      path: '/event',
      builder: (context, _) => const EventDetailsPage(),
      routes: [
        GoRoute(
            path: ':eventId',
            builder: (context, routerState) => EventDetailsPage(
                eventId: _pathParamToInt(routerState, 'eventId')))
      ]),
]);

class MyApp extends StatelessWidget {
  final EventDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventViewModel(database),
      child: MaterialApp.router(
        title: 'Event Planner',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        routerConfig: router,
      ),
    );
  }
}
