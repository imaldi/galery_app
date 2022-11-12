// Denote which tables this DAO can access
import 'package:drift/drift.dart';
import 'package:galery_app/data/datasources/local/database/app_database.dart';
import 'package:galery_app/domain/entities/file_entities.dart';
import 'package:galery_app/domain/entities/tags.dart';

part 'file_entity_dao.g.dart';
@DriftAccessor(tables: [FileEntities, Tags])
class FileEntityDao extends DatabaseAccessor<MyDatabase> with _$FileEntityDaoMixin {
  final MyDatabase db;

  // Called by the AppDatabase class
  FileEntityDao(this.db) : super(db);

  // Ganti return type
  // Return TaskWithTag now
  Stream<List<FileWithTag>> watchAllTasks() {
    // Wrap the whole select statement in parenthesis
    var val = (select(fileEntities)
    // Statements like orderBy and where return void => the need to use a cascading ".." operator
      ..orderBy(
        ([
          // Primary sorting by due date
              (t) =>
              OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          // Secondary alphabetical sorting
              (t) => OrderingTerm(expression: t.name),
        ]),
      )
      ..where((t) => t.url.isNotNull())
    )
    // TODO nanti perdalami lagi soal join di moor ini
    // As opposed to orderBy or where, join returns a value. This is what we want to watch/get.
        .join(
      [
        // Join all the tasks with their tags.
        // It's important that we use equalsExp and not just equals.
        // This way, we can join using all tag names in the tasks table, not just a specific one.
        leftOuterJoin(tags, tags.name.equalsExp(fileEntities.tagName)),
      ],
    )
    // watch the whole select statement including the join
        .watch()
    // Watching a join gets us a Stream of List<TypedResult>
    // Mapping each List<TypedResult> emitted by the Stream to a List<TaskWithTag>
        .map(
          (rows) => rows.map(
            (row) {
          return FileWithTag(
            theFile: row.readTable(fileEntities),
            // In dia penyebab masalah, tutorial dibuat ketika null safety belum ada di dart
            tag: row.readTableOrNull(tags),
          );
        },
      ).toList(),
    );
    print("This is the list boy: ${val.toList().toString()}");
    return val;
  }

  // Stream<List<TaskWithTag>> watchCompletedTasks() {
  //   // where returns void, need to use the cascading operator
  //   return (select(tasks)
  //     ..orderBy(
  //       ([
  //         // Primary sorting by due date
  //             (t) =>
  //             OrderingTerm(expression: t.dueDate, mode: OrderingMode.desc),
  //         // Secondary alphabetical sorting
  //             (t) => OrderingTerm(expression: t.name),
  //       ]),
  //     )
  //     ..where((t) => t.completed.equals(true)))
  //       .join(
  //     [
  //       // Join all the tasks with their tags.
  //       // It's important that we use equalsExp and not just equals.
  //       // This way, we can join using all tag names in the tasks table, not just a specific one.
  //       leftOuterJoin(tags, tags.name.equalsExp(tasks.tagName)),
  //     ],
  //   )
  //       .watch()
  //       .map(
  //         (rows) => rows.map(
  //           (row) {
  //         return TaskWithTag(
  //           task: row.readTable(tasks),
  //           tag: row.readTable(tags),
  //         );
  //       },
  //     ).toList(),
  //   );
  // }

  Future insertFile(Insertable<FileEntity> file) => into(fileEntities).insert(file);

  // Updates a Task with a matching primary key
  Future updateFile(Insertable<FileEntity> file) => update(fileEntities).replace(file);

  Future deleteFile(Insertable<FileEntity> file) => delete(fileEntities).delete(file);
}