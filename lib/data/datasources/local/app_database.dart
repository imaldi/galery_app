import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:galery_app/domain/entities/tags.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:galery_app/domain/entities/file_entities.dart';

part 'app_database.g.dart';
@DriftDatabase(tables: [FileEntities, Tags])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    // Runs if the database has already been opened on the device with a lower version
      onUpgrade: (migrator, from, to) async {
        if (from == 1) {
          await migrator.addColumn(fileEntities, fileEntities.url);
          await migrator.createTable(tags);
        }
      },
      // This migration property ties in nicely with the foreign key we've added previously.
      // It turns out that foreign keys are actually not enabled by default in SQLite - we have to
      // enable them ourselves with a custom statement.
      // We want to run this statement before any other queries are run to
      // prevent the chance of  "unchecked data" from entering the database.
      // This is a perfect use-case for the beforeOpen callback.
      // Runs after all the migrations but BEFORE any queries have a chance to execute
      beforeOpen: (details) async {
        // ini lumayan beda dari Reso Coder, tapi kyknya ini caranya
        await customStatement('PRAGMA foreign_keys = ON');
      });
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}