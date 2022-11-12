import 'package:drift/drift.dart';
import 'package:galery_app/data/datasources/local/app_database.dart';

// this will generate a table called "FileEntities" for us. The rows of that table will
// be represented by a class called "FileEntities".
@DataClassName('FileEntity')
class FileEntities extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 6)();
  TextColumn get url => text().nullable()();
  TextColumn get location => text().nullable()();
  IntColumn get utcDate => integer().nullable()();
  // add nullable tagName
  TextColumn get tagName =>
      text().nullable().customConstraint('NULL REFERENCES tags(name)')();
}

// Task jadi sepaket dengan tag
// We have to group tasks with tags manually.
// This class will be used for the table join.
class FileWithTag {
  final FileEntity theFile;
  final Tag? tag;

  FileWithTag({
    required this.theFile,
    this.tag,
  });
}