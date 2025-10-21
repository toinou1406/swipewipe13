// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AlbumDao? _albumDaoInstance;

  MediaDao? _mediaDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Album` (`id` TEXT NOT NULL, `name` TEXT NOT NULL, `count` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Media` (`id` TEXT NOT NULL, `albumId` TEXT NOT NULL, `path` TEXT NOT NULL, `type` TEXT NOT NULL, `creationDate` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AlbumDao get albumDao {
    return _albumDaoInstance ??= _$AlbumDao(database, changeListener);
  }

  @override
  MediaDao get mediaDao {
    return _mediaDaoInstance ??= _$MediaDao(database, changeListener);
  }
}

class _$AlbumDao extends AlbumDao {
  _$AlbumDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _albumInsertionAdapter = InsertionAdapter(
            database,
            'Album',
            (Album item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'count': item.count
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Album> _albumInsertionAdapter;

  @override
  Future<List<Album>> findAllAlbums() async {
    return _queryAdapter.queryList('SELECT * FROM Album',
        mapper: (Map<String, Object?> row) => Album(
            id: row['id'] as String,
            name: row['name'] as String,
            count: row['count'] as int));
  }

  @override
  Future<void> insertAlbum(Album album) async {
    await _albumInsertionAdapter.insert(album, OnConflictStrategy.abort);
  }
}

class _$MediaDao extends MediaDao {
  _$MediaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _mediaInsertionAdapter = InsertionAdapter(
            database,
            'Media',
            (Media item) => <String, Object?>{
                  'id': item.id,
                  'albumId': item.albumId,
                  'path': item.path,
                  'type': item.type,
                  'creationDate': _dateTimeConverter.encode(item.creationDate)
                }),
        _mediaDeletionAdapter = DeletionAdapter(
            database,
            'Media',
            ['id'],
            (Media item) => <String, Object?>{
                  'id': item.id,
                  'albumId': item.albumId,
                  'path': item.path,
                  'type': item.type,
                  'creationDate': _dateTimeConverter.encode(item.creationDate)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Media> _mediaInsertionAdapter;

  final DeletionAdapter<Media> _mediaDeletionAdapter;

  @override
  Future<List<Media>> findMediaForAlbum(String albumId) async {
    return _queryAdapter.queryList('SELECT * FROM Media WHERE albumId = ?1',
        mapper: (Map<String, Object?> row) => Media(
            id: row['id'] as String,
            albumId: row['albumId'] as String,
            path: row['path'] as String,
            type: row['type'] as String,
            creationDate:
                _dateTimeConverter.decode(row['creationDate'] as int)),
        arguments: [albumId]);
  }

  @override
  Future<void> insertMedia(Media media) async {
    await _mediaInsertionAdapter.insert(media, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMedia(Media media) async {
    await _mediaDeletionAdapter.delete(media);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
