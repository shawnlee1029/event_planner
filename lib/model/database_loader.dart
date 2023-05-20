import 'event_database.dart';

Future<EventDatabase> loadDatabase(){
  return $FloorEventDatabase
      .databaseBuilder('events.db')
      .build();
}