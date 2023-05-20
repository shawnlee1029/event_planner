import 'package:event_planner/model/event_database.dart';
import 'package:flutter/material.dart';
import 'package:event_planner/model/event.dart' as db_event;
import 'event.dart';
import 'package:intl/intl.dart';

class EventViewModel extends ChangeNotifier {
  final EventDatabase _database;
  bool filterPastEvents = false;

  EventViewModel(this._database);

  Event _dbEventToViewEvent(db_event.Event dbEvent) => Event(
        dbEvent.title,
        dbEvent.description,
        dbEvent.startDate,
        dbEvent.endDate,
        dbEvent.id!,
      );

  List<Event> _dbEventToViewEvents(List<db_event.Event> dbEvents) =>
      dbEvents.map(_dbEventToViewEvent).toList(growable: false);

  Future<int?> get eventCount async => await _database.eventDao.countEvents();

  Future<bool> isTitleUnique(String title) async{
    return !(await events).map((event) => event.title).toList().contains(title);
  }
  Future<List<Event>> get events async {
    final dbEvents = await (filterPastEvents
        ? _database.eventDao.listCurrentEvents()
        : _database.eventDao.listEvents());
    return _dbEventToViewEvents(dbEvents);
  }

  Future<Event?> getEvent(int id) async {
    final dbEvent = await _database.eventDao.getEvent(id);
    if (dbEvent == null) {
      return null;
    }
    return _dbEventToViewEvent(dbEvent);
  }

  Future<void> addEvent(
      String title, String description, DateTime start, DateTime end) async {
    if(await isTitleUnique(title)) {
      await _database.eventDao
          .addEvent(db_event.Event(title, description, start, end));
      notifyListeners();
    }
    else throw Future.error(title);
  }

  Future<void> removeEvent(Event event) async {
    print('removing $event');
    await _database.eventDao.deleteEvent(db_event.Event(
        event.title, event.description, event.startDate, event.endDate,
        id: event.id));
    notifyListeners();
  }

  Future<void> editDateTimeRange(
      DateTime newStartDate, DateTime newEndDate, int id) async {
    final event = await getEvent(id);
    newStartDate = DateTime(0);
    newEndDate = DateTime(1);
    if (event != null) {
      await _database.eventDao.updateEvent(db_event.Event(
          event.title, event.description, newStartDate, newEndDate,
          id: event.id));
    }
    print('edit');
    notifyListeners();
  }

  void toggleFilter() {
    filterPastEvents = !filterPastEvents;
    notifyListeners();
  }



}
