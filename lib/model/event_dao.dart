import 'package:event_planner/model/event.dart';
import 'package:floor/floor.dart';

@dao
abstract class EventDao {
  @Query('SELECT * FROM Event ORDER BY startDate')
  Future<List<Event>> listEvents();

  @Query(
      "SELECT * FROM Event "
          "WHERE endDate >= strftime('%s', 'now') * 1000 "
          "ORDER BY startDate")
  Future<List<Event>> listCurrentEvents();

  @Query("SELECT COUNT(*) from Event")
  Future<int?> countEvents();

  @Query('SELECT * FROM Event WHERE id = :id')
  Future<Event?> getEvent(int id);

  @Query('SELECT  EXISTS (SELECT * FROM Event WHERE title == :title)')
  Future<bool?> isTitleUnique(String title);
  @insert
  Future<void> addEvent(Event event);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateEvent(Event event);
  @delete
  Future<void> deleteEvent(Event event);
}
