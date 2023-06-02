import 'package:floor/floor.dart';

@entity
class Event{
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;

  Event(this.title, this.description, this.startDate, this.endDate, {this.id});
}