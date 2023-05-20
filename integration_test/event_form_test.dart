import 'package:event_planner/model/event_database.dart';
import 'package:event_planner/view_model/event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:event_planner/view/event_form.dart';
import 'package:provider/provider.dart';


main() {
  group('Event Form Testing', () {
    testWidgets('Adds an event when EventForm with title is submitted',
        (WidgetTester tester) async {
      const eventTitle = 'Concert';
      final database =
          await $FloorEventDatabase.inMemoryDatabaseBuilder().build();
      final evm = EventViewModel(database);

      await tester.pumpWidget(
        ChangeNotifierProvider<EventViewModel>.value(
          value: evm,
          child: const MaterialApp(home: Scaffold(body: EventForm())),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, eventTitle);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      final queryResults = await database.database.rawQuery('SELECT DISTINCT title FROM Event');
      expect(queryResults, hasLength(1));
      expect(queryResults[0]['title'], eventTitle);
    });
  });
}
