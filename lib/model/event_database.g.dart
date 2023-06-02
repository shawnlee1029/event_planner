// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorEventDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$EventDatabaseBuilder databaseBuilder(String name) =>
      _$EventDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$EventDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$EventDatabaseBuilder(null);
}

class _$EventDatabaseBuilder {
  _$EventDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$EventDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$EventDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<EventDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$EventDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$EventDatabase extends EventDatabase {
  _$EventDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FloorEventDao? _eventDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Event` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `startDate` INTEGER NOT NULL, `endDate` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FloorEventDao get eventDao {
    return _eventDaoInstance ??= _$EventDao(database, changeListener);
  }
}

class _$EventDao extends FloorEventDao {
  _$EventDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _eventInsertionAdapter = InsertionAdapter(
            database,
            'Event',
            (Event item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'startDate': _dateTimeConverter.encode(item.startDate),
                  'endDate': _dateTimeConverter.encode(item.endDate)
                }),
        _eventUpdateAdapter = UpdateAdapter(
            database,
            'Event',
            ['id'],
            (Event item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'startDate': _dateTimeConverter.encode(item.startDate),
                  'endDate': _dateTimeConverter.encode(item.endDate)
                }),
        _eventDeletionAdapter = DeletionAdapter(
            database,
            'Event',
            ['id'],
            (Event item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'startDate': _dateTimeConverter.encode(item.startDate),
                  'endDate': _dateTimeConverter.encode(item.endDate)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Event> _eventInsertionAdapter;

  final UpdateAdapter<Event> _eventUpdateAdapter;

  final DeletionAdapter<Event> _eventDeletionAdapter;

  @override
  Future<List<Event>> listEvents() async {
    return _queryAdapter.queryList('SELECT * FROM Event ORDER BY startDate',
        mapper: (Map<String, Object?> row) => Event(
            row['title'] as String,
            row['description'] as String,
            _dateTimeConverter.decode(row['startDate'] as int),
            _dateTimeConverter.decode(row['endDate'] as int),
            id: row['id'] as int?));
  }

  @override
  Future<List<Event>> listCurrentEvents() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Event WHERE endDate >= strftime(\'%s\', \'now\') * 1000 ORDER BY startDate',
        mapper: (Map<String, Object?> row) => Event(
            row['title'] as String,
            row['description'] as String,
            _dateTimeConverter.decode(row['startDate'] as int),
            _dateTimeConverter.decode(row['endDate'] as int),
            id: row['id'] as int?));
  }

  @override
  Future<int?> countEvents() async {
    return _queryAdapter.query('SELECT COUNT(*) from Event',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<Event?> getEvent(int id) async {
    return _queryAdapter.query('SELECT * FROM Event WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Event(
            row['title'] as String,
            row['description'] as String,
            _dateTimeConverter.decode(row['startDate'] as int),
            _dateTimeConverter.decode(row['endDate'] as int),
            id: row['id'] as int?),
        arguments: [id]);
  }

  @override
  Future<bool?> isTitleUnique(String title) async {
    return _queryAdapter.query(
        'SELECT  EXISTS (SELECT * FROM Event WHERE title == ?1)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [title]);
  }

  @override
  Future<void> addEvent(Event event) async {
    await _eventInsertionAdapter.insert(event, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateEvent(Event event) async {
    await _eventUpdateAdapter.update(event, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteEvent(Event event) async {
    await _eventDeletionAdapter.delete(event);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
