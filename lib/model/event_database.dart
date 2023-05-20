import 'package:event_planner/model/date_time_converter.dart';
import 'package:event_planner/model/event.dart';
import 'package:event_planner/model/event_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'event_database.g.dart';
@TypeConverters([DateTimeConverter])
@Database(version:1, entities:[Event])
abstract class EventDatabase extends FloorDatabase{
  EventDao get eventDao;
}