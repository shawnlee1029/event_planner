import 'package:event_planner/model/event_database.dart';
import 'package:flutter/material.dart';
import 'package:event_planner/model/event.dart' as db_event;
import 'event.dart';
import 'package:event_planner/model/firestore_event_dao.dart';

class EventViewModel extends ChangeNotifier {
  final EventDatabase _database;
  final FireStoreEventDao _fireStoreEventDao = FireStoreEventDao();
  bool filterPastEvents = false;
  bool usingFireStore = false;

  EventViewModel(this._database);

  Future<List<Event>?> getFireStoreEvent(int id) async {
    return await _fireStoreEventDao.getEvent(id);
  }

  Future<void> addFirestoreEvent(Event event) async {
    if (await isTitleUnique(event.title)) {
      await _fireStoreEventDao.addEvent(event);
      notifyListeners();
    } else {
      throw Future.error(event.title);
    }
  }

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

  Future<bool> isTitleUnique(String title) async {
    return !(await events).map((event) => event.title).toList().contains(title);
  }

  Future<List<Event>> get dbEvents async {
    final dbEvents = await (filterPastEvents
        ? _database.eventDao.listCurrentEvents()
        : _database.eventDao.listEvents());
    return _dbEventToViewEvents(dbEvents);
  }

  Future<List<Event>> get fireStoreEvents async {
    return await (filterPastEvents
        ? _fireStoreEventDao.listCurrentEvents()
        : _fireStoreEventDao.listEvents());
  }

  Future<List<Event>> get events async {
    final List<Event> events = [];
    final dbe = await dbEvents;
    final fse = await fireStoreEvents;
    events.addAll(dbe);
    events.addAll(fse);
    return events;
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
    if (await isTitleUnique(title)) {
      await _database.eventDao
          .addEvent(db_event.Event(title, description, start, end));
      notifyListeners();
    } else {
      throw Future.error(title);
    }
  }

  Future<void> editEvent(int id, String title, String description,
      DateTime start, DateTime end) async {
    final currentEvent = await getEvent(id);
    if (currentEvent!.title == title || await isTitleUnique(title)) {
      await _database.eventDao
          .updateEvent(db_event.Event(id: id, title, description, start, end));
      notifyListeners();
    } else {
      throw Future.error(title);
    }
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
    notifyListeners();
  }

  void toggleFilter() {
    filterPastEvents = !filterPastEvents;
    notifyListeners();
  }

  void toggleUsingFireStore() {
    usingFireStore = !usingFireStore;
    notifyListeners();
  }
}
