import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/model/database_loader.dart';
import 'package:event_planner/model/event_database.dart';
import 'package:event_planner/view/event_details_page.dart';
import 'package:event_planner/view/event_viewer_page.dart';
import 'package:flutter/material.dart';
import 'package:event_planner/view_model/event_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'view/event_form_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  _initFirebase();
  runApp(MyApp(database: await loadDatabase()));
}

_initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // if (kDebugMode) {
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 6001);
  //   FirebaseAuth.instance.useAuthEmulator('localhost', 5001);
  // }
  // // await FirebaseAuth.instance.signInAnonymously();
  // FirebaseAuth.instance.userChanges().listen((maybeUser) {
  //   if (maybeUser == null) {
  //     print('user signed out');
  //   }
  //
  //   else {
  //     print('User signed in as "${maybeUser.displayName}", email=${maybeUser
  //         .email}');
  //   }
  // });
  // FireStoreEventDao().addEvent([
  //   Event('concert','today!',DateTime(2021),DateTime(2022),1),
  //   Event('festival','fun!',DateTime(2021),DateTime(2022),1)
  // ]);
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
            builder: (context, routerState) =>
                EventFormPage(
                    eventId: _pathParamToInt(routerState, 'eventId')))
      ]),
  GoRoute(
      path: '/event',
      builder: (context, _) => const EventDetailsPage(),
      routes: [
        GoRoute(
            path: ':eventId',
            builder: (context, routerState) =>
                EventDetailsPage(
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
