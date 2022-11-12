// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class FileEntity extends DataClass implements Insertable<FileEntity> {
  final int id;
  final String name;
  final String? url;
  final String? location;
  final int? utcDate;
  final String? tagName;
  const FileEntity(
      {required this.id,
      required this.name,
      this.url,
      this.location,
      this.utcDate,
      this.tagName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || utcDate != null) {
      map['utc_date'] = Variable<int>(utcDate);
    }
    if (!nullToAbsent || tagName != null) {
      map['tag_name'] = Variable<String>(tagName);
    }
    return map;
  }

  FileEntitiesCompanion toCompanion(bool nullToAbsent) {
    return FileEntitiesCompanion(
      id: Value(id),
      name: Value(name),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      utcDate: utcDate == null && nullToAbsent
          ? const Value.absent()
          : Value(utcDate),
      tagName: tagName == null && nullToAbsent
          ? const Value.absent()
          : Value(tagName),
    );
  }

  factory FileEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FileEntity(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      url: serializer.fromJson<String?>(json['url']),
      location: serializer.fromJson<String?>(json['location']),
      utcDate: serializer.fromJson<int?>(json['utcDate']),
      tagName: serializer.fromJson<String?>(json['tagName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'url': serializer.toJson<String?>(url),
      'location': serializer.toJson<String?>(location),
      'utcDate': serializer.toJson<int?>(utcDate),
      'tagName': serializer.toJson<String?>(tagName),
    };
  }

  FileEntity copyWith(
          {int? id,
          String? name,
          Value<String?> url = const Value.absent(),
          Value<String?> location = const Value.absent(),
          Value<int?> utcDate = const Value.absent(),
          Value<String?> tagName = const Value.absent()}) =>
      FileEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url.present ? url.value : this.url,
        location: location.present ? location.value : this.location,
        utcDate: utcDate.present ? utcDate.value : this.utcDate,
        tagName: tagName.present ? tagName.value : this.tagName,
      );
  @override
  String toString() {
    return (StringBuffer('FileEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('location: $location, ')
          ..write('utcDate: $utcDate, ')
          ..write('tagName: $tagName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, url, location, utcDate, tagName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FileEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.url == this.url &&
          other.location == this.location &&
          other.utcDate == this.utcDate &&
          other.tagName == this.tagName);
}

class FileEntitiesCompanion extends UpdateCompanion<FileEntity> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> url;
  final Value<String?> location;
  final Value<int?> utcDate;
  final Value<String?> tagName;
  const FileEntitiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.url = const Value.absent(),
    this.location = const Value.absent(),
    this.utcDate = const Value.absent(),
    this.tagName = const Value.absent(),
  });
  FileEntitiesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.url = const Value.absent(),
    this.location = const Value.absent(),
    this.utcDate = const Value.absent(),
    this.tagName = const Value.absent(),
  }) : name = Value(name);
  static Insertable<FileEntity> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? url,
    Expression<String>? location,
    Expression<int>? utcDate,
    Expression<String>? tagName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (url != null) 'url': url,
      if (location != null) 'location': location,
      if (utcDate != null) 'utc_date': utcDate,
      if (tagName != null) 'tag_name': tagName,
    });
  }

  FileEntitiesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? url,
      Value<String?>? location,
      Value<int?>? utcDate,
      Value<String?>? tagName}) {
    return FileEntitiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      location: location ?? this.location,
      utcDate: utcDate ?? this.utcDate,
      tagName: tagName ?? this.tagName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (utcDate.present) {
      map['utc_date'] = Variable<int>(utcDate.value);
    }
    if (tagName.present) {
      map['tag_name'] = Variable<String>(tagName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FileEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('url: $url, ')
          ..write('location: $location, ')
          ..write('utcDate: $utcDate, ')
          ..write('tagName: $tagName')
          ..write(')'))
        .toString();
  }
}

class $FileEntitiesTable extends FileEntities
    with TableInfo<$FileEntitiesTable, FileEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FileEntitiesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name =
      GeneratedColumn<String>('name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 6,
          ),
          type: DriftSqlType.string,
          requiredDuringInsert: true);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _locationMeta = const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _utcDateMeta = const VerificationMeta('utcDate');
  @override
  late final GeneratedColumn<int> utcDate = GeneratedColumn<int>(
      'utc_date', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _tagNameMeta = const VerificationMeta('tagName');
  @override
  late final GeneratedColumn<String> tagName = GeneratedColumn<String>(
      'tag_name', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NULL REFERENCES tags(name)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, url, location, utcDate, tagName];
  @override
  String get aliasedName => _alias ?? 'file_entities';
  @override
  String get actualTableName => 'file_entities';
  @override
  VerificationContext validateIntegrity(Insertable<FileEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    }
    if (data.containsKey('utc_date')) {
      context.handle(_utcDateMeta,
          utcDate.isAcceptableOrUnknown(data['utc_date']!, _utcDateMeta));
    }
    if (data.containsKey('tag_name')) {
      context.handle(_tagNameMeta,
          tagName.isAcceptableOrUnknown(data['tag_name']!, _tagNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FileEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FileEntity(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      url: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}url']),
      location: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}location']),
      utcDate: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}utc_date']),
      tagName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}tag_name']),
    );
  }

  @override
  $FileEntitiesTable createAlias(String alias) {
    return $FileEntitiesTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final String name;
  final int color;
  const Tag({required this.name, required this.color});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['color'] = Variable<int>(color);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      name: Value(name),
      color: Value(color),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<int>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<int>(color),
    };
  }

  Tag copyWith({String? name, int? color}) => Tag(
        name: name ?? this.name,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, color);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag && other.name == this.name && other.color == this.color);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<String> name;
  final Value<int> color;
  const TagsCompanion({
    this.name = const Value.absent(),
    this.color = const Value.absent(),
  });
  TagsCompanion.insert({
    required String name,
    required int color,
  })  : name = Value(name),
        color = Value(color);
  static Insertable<Tag> custom({
    Expression<String>? name,
    Expression<int>? color,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (color != null) 'color': color,
    });
  }

  TagsCompanion copyWith({Value<String>? name, Value<int>? color}) {
    return TagsCompanion(
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('name: $name, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
      'color', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [name, color];
  @override
  String get aliasedName => _alias ?? 'tags';
  @override
  String get actualTableName => 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      color: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  late final $FileEntitiesTable fileEntities = $FileEntitiesTable(this);
  late final $TagsTable tags = $TagsTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [fileEntities, tags];
}
