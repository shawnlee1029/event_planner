import 'package:event_planner/model/database_loader.dart';
import 'package:event_planner/view/event_details_view_button.dart';
import 'package:event_planner/view_model/event.dart';
import 'package:event_planner/view/event_card.dart';
import 'package:event_planner/view/event_details_page.dart';
import 'package:event_planner/view/event_form_button.dart';
import 'package:event_planner/view_model/event_view_model.dart';
import 'package:event_planner/view/event_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:event_planner/view/event_form.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';

import 'event_viewer_test.mocks.dart';

@GenerateMocks([EventViewModel, NavigatorObserver])
main() {
  testWidgets('Find no event cards when view model contains 0 events',
      (WidgetTester tester) async {
    final evm = MockEventViewModel();
    when(evm.events).thenAnswer((_) => Future.value([]));

    await tester.pumpWidget(ChangeNotifierProvider<EventViewModel>.value(
        value: evm,
        child: const MaterialApp(home: Scaffold(body: EventViewer()))));
    await tester.pumpAndSettle();
    expect(find.byType(EventCard), findsNothing);
  });

  testWidgets('Find 2 event cards when view model contains 2 events',
      (WidgetTester tester) async {
    final evm = MockEventViewModel();
    when(evm.events).thenAnswer((_) => Future.value([
      Event('Title', 'desc', DateTime(2020), DateTime(2023), 1),
      Event('Title2', 'desc2', DateTime(2021), DateTime(2023), 2),

    ]));

    await tester.pumpWidget(ChangeNotifierProvider<EventViewModel>.value(
        value: evm,
        child: const MaterialApp(home: Scaffold(body: EventViewer()))));
    await tester.pumpAndSettle();

    expect(find.byType(EventCard), findsNWidgets(2));
  });

  testWidgets('Navigate to EventForm', (WidgetTester tester) async {
    final mockEventViewModel = MockEventViewModel();
    const destinationIdentifier = '812ue12ueojdioasj';
    final router = GoRouter(routes: [
      GoRoute(
          path: '/',
          builder: (context, _) => const Scaffold(
                body: EventFormButton(),
              )),
      GoRoute(
          path: '/form',
          name: 'form',
          builder: (context, _) => const Scaffold(
                body: Text(destinationIdentifier),
              ))
    ]);
    await tester.pumpWidget(ChangeNotifierProvider<EventViewModel>.value(
      value: mockEventViewModel,
      child: MaterialApp.router(
        routerConfig: router,
      ),
    ));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text(destinationIdentifier), findsOneWidget);
  });
  testWidgets('Navigate to EventDetails of id 2',
      (WidgetTester tester) async {
    const destinationIdentifier = 'asdsacsaew32r42';
    final evm = MockEventViewModel();
    when(evm.events).thenAnswer((_) => Future.value([
      Event('TitleA', 'descA', DateTime(2020), DateTime(2023), 0),
      Event('TitleB', 'descB', DateTime(2020), DateTime(2023), 1),
      Event('TitleC', 'asdsacsaew32r42', DateTime(2020), DateTime(2023), 2),
      Event('TitleD', 'descD', DateTime(2020), DateTime(2023), 3),

    ]));
    final router = GoRouter(routes: [
      GoRoute(
          path: '/',
          builder: (context, _) => const Scaffold(
                body: EventViewer(),
              )),
      GoRoute(
          path: '/event/:eventId',
          builder: (context, state) => EventDetailsPage(
              eventId: int.parse(state.pathParameters['eventId']!)))
    ]);
    await tester.pumpWidget(ChangeNotifierProvider<EventViewModel>.value(
      value: evm,
      child: MaterialApp.router(
        routerConfig: router,
      ),
    ));

    await tester.pumpAndSettle();
    await tester.tap(find.byType(EventDetailsViewButton).at(2));
    await tester.pumpAndSettle();

    expect(find.text(destinationIdentifier), findsOneWidget);
  });
}
