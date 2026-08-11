// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $KeyValueTableTable extends KeyValueTable
    with TableInfo<$KeyValueTableTable, KeyValueEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KeyValueTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _boxMeta = const VerificationMeta('box');
  @override
  late final GeneratedColumn<String> box = GeneratedColumn<String>(
    'box',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
    'data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [box, id, data];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'key_value_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<KeyValueEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('box')) {
      context.handle(
        _boxMeta,
        box.isAcceptableOrUnknown(data['box']!, _boxMeta),
      );
    } else if (isInserting) {
      context.missing(_boxMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {box, id};
  @override
  KeyValueEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KeyValueEntity(
      box: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}box'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      data: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data'],
      )!,
    );
  }

  @override
  $KeyValueTableTable createAlias(String alias) {
    return $KeyValueTableTable(attachedDatabase, alias);
  }
}

class KeyValueEntity extends DataClass implements Insertable<KeyValueEntity> {
  final String box;
  final String id;
  final String data;
  const KeyValueEntity({
    required this.box,
    required this.id,
    required this.data,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['box'] = Variable<String>(box);
    map['id'] = Variable<String>(id);
    map['data'] = Variable<String>(data);
    return map;
  }

  KeyValueTableCompanion toCompanion(bool nullToAbsent) {
    return KeyValueTableCompanion(
      box: Value(box),
      id: Value(id),
      data: Value(data),
    );
  }

  factory KeyValueEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KeyValueEntity(
      box: serializer.fromJson<String>(json['box']),
      id: serializer.fromJson<String>(json['id']),
      data: serializer.fromJson<String>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'box': serializer.toJson<String>(box),
      'id': serializer.toJson<String>(id),
      'data': serializer.toJson<String>(data),
    };
  }

  KeyValueEntity copyWith({String? box, String? id, String? data}) =>
      KeyValueEntity(
        box: box ?? this.box,
        id: id ?? this.id,
        data: data ?? this.data,
      );
  KeyValueEntity copyWithCompanion(KeyValueTableCompanion data) {
    return KeyValueEntity(
      box: data.box.present ? data.box.value : this.box,
      id: data.id.present ? data.id.value : this.id,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KeyValueEntity(')
          ..write('box: $box, ')
          ..write('id: $id, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(box, id, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KeyValueEntity &&
          other.box == this.box &&
          other.id == this.id &&
          other.data == this.data);
}

class KeyValueTableCompanion extends UpdateCompanion<KeyValueEntity> {
  final Value<String> box;
  final Value<String> id;
  final Value<String> data;
  final Value<int> rowid;
  const KeyValueTableCompanion({
    this.box = const Value.absent(),
    this.id = const Value.absent(),
    this.data = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KeyValueTableCompanion.insert({
    required String box,
    required String id,
    required String data,
    this.rowid = const Value.absent(),
  }) : box = Value(box),
       id = Value(id),
       data = Value(data);
  static Insertable<KeyValueEntity> custom({
    Expression<String>? box,
    Expression<String>? id,
    Expression<String>? data,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (box != null) 'box': box,
      if (id != null) 'id': id,
      if (data != null) 'data': data,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KeyValueTableCompanion copyWith({
    Value<String>? box,
    Value<String>? id,
    Value<String>? data,
    Value<int>? rowid,
  }) {
    return KeyValueTableCompanion(
      box: box ?? this.box,
      id: id ?? this.id,
      data: data ?? this.data,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (box.present) {
      map['box'] = Variable<String>(box.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KeyValueTableCompanion(')
          ..write('box: $box, ')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTableTable extends TasksTable
    with TableInfo<$TasksTableTable, TaskEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<String> data = GeneratedColumn<String>(
    'data',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    isCompleted,
    dueDate,
    createdAt,
    updatedAt,
    createdBy,
    data,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      data: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data'],
      ),
    );
  }

  @override
  $TasksTableTable createAlias(String alias) {
    return $TasksTableTable(attachedDatabase, alias);
  }
}

class TaskEntity extends DataClass implements Insertable<TaskEntity> {
  final String id;
  final String title;
  final String? description;
  final bool isCompleted;
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? createdBy;
  final String? data;
  const TaskEntity({
    required this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
    this.createdBy,
    this.data,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    if (!nullToAbsent || data != null) {
      map['data'] = Variable<String>(data);
    }
    return map;
  }

  TasksTableCompanion toCompanion(bool nullToAbsent) {
    return TasksTableCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isCompleted: Value(isCompleted),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      data: data == null && nullToAbsent ? const Value.absent() : Value(data),
    );
  }

  factory TaskEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskEntity(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      data: serializer.fromJson<String?>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdBy': serializer.toJson<String?>(createdBy),
      'data': serializer.toJson<String?>(data),
    };
  }

  TaskEntity copyWith({
    String? id,
    String? title,
    Value<String?> description = const Value.absent(),
    bool? isCompleted,
    Value<DateTime?> dueDate = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<String?> createdBy = const Value.absent(),
    Value<String?> data = const Value.absent(),
  }) => TaskEntity(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    isCompleted: isCompleted ?? this.isCompleted,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    data: data.present ? data.value : this.data,
  );
  TaskEntity copyWithCompanion(TasksTableCompanion data) {
    return TaskEntity(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskEntity(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('dueDate: $dueDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    isCompleted,
    dueDate,
    createdAt,
    updatedAt,
    createdBy,
    data,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskEntity &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.isCompleted == this.isCompleted &&
          other.dueDate == this.dueDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.createdBy == this.createdBy &&
          other.data == this.data);
}

class TasksTableCompanion extends UpdateCompanion<TaskEntity> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<bool> isCompleted;
  final Value<DateTime?> dueDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String?> createdBy;
  final Value<String?> data;
  final Value<int> rowid;
  const TasksTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.data = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.data = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : title = Value(title);
  static Insertable<TaskEntity> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<bool>? isCompleted,
    Expression<DateTime>? dueDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? createdBy,
    Expression<String>? data,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (dueDate != null) 'due_date': dueDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdBy != null) 'created_by': createdBy,
      if (data != null) 'data': data,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<bool>? isCompleted,
    Value<DateTime?>? dueDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String?>? createdBy,
    Value<String?>? data,
    Value<int>? rowid,
  }) {
    return TasksTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      createdBy: createdBy ?? this.createdBy,
      data: data ?? this.data,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('dueDate: $dueDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdBy: $createdBy, ')
          ..write('data: $data, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecoveryProfilesTableTable extends RecoveryProfilesTable
    with TableInfo<$RecoveryProfilesTableTable, RecoveryProfileEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecoveryProfilesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longestStreakMeta = const VerificationMeta(
    'longestStreak',
  );
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
    'longest_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _currentStreakMeta = const VerificationMeta(
    'currentStreak',
  );
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
    'current_streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _primaryTriggerMeta = const VerificationMeta(
    'primaryTrigger',
  );
  @override
  late final GeneratedColumn<String> primaryTrigger = GeneratedColumn<String>(
    'primary_trigger',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startDate,
    longestStreak,
    currentStreak,
    primaryTrigger,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recovery_profiles_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecoveryProfileEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('longest_streak')) {
      context.handle(
        _longestStreakMeta,
        longestStreak.isAcceptableOrUnknown(
          data['longest_streak']!,
          _longestStreakMeta,
        ),
      );
    }
    if (data.containsKey('current_streak')) {
      context.handle(
        _currentStreakMeta,
        currentStreak.isAcceptableOrUnknown(
          data['current_streak']!,
          _currentStreakMeta,
        ),
      );
    }
    if (data.containsKey('primary_trigger')) {
      context.handle(
        _primaryTriggerMeta,
        primaryTrigger.isAcceptableOrUnknown(
          data['primary_trigger']!,
          _primaryTriggerMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecoveryProfileEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecoveryProfileEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      longestStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}longest_streak'],
      )!,
      currentStreak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_streak'],
      )!,
      primaryTrigger: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_trigger'],
      ),
    );
  }

  @override
  $RecoveryProfilesTableTable createAlias(String alias) {
    return $RecoveryProfilesTableTable(attachedDatabase, alias);
  }
}

class RecoveryProfileEntity extends DataClass
    implements Insertable<RecoveryProfileEntity> {
  final String id;
  final DateTime startDate;
  final int longestStreak;
  final int currentStreak;
  final String? primaryTrigger;
  const RecoveryProfileEntity({
    required this.id,
    required this.startDate,
    required this.longestStreak,
    required this.currentStreak,
    this.primaryTrigger,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['start_date'] = Variable<DateTime>(startDate);
    map['longest_streak'] = Variable<int>(longestStreak);
    map['current_streak'] = Variable<int>(currentStreak);
    if (!nullToAbsent || primaryTrigger != null) {
      map['primary_trigger'] = Variable<String>(primaryTrigger);
    }
    return map;
  }

  RecoveryProfilesTableCompanion toCompanion(bool nullToAbsent) {
    return RecoveryProfilesTableCompanion(
      id: Value(id),
      startDate: Value(startDate),
      longestStreak: Value(longestStreak),
      currentStreak: Value(currentStreak),
      primaryTrigger: primaryTrigger == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryTrigger),
    );
  }

  factory RecoveryProfileEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecoveryProfileEntity(
      id: serializer.fromJson<String>(json['id']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      primaryTrigger: serializer.fromJson<String?>(json['primaryTrigger']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startDate': serializer.toJson<DateTime>(startDate),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'primaryTrigger': serializer.toJson<String?>(primaryTrigger),
    };
  }

  RecoveryProfileEntity copyWith({
    String? id,
    DateTime? startDate,
    int? longestStreak,
    int? currentStreak,
    Value<String?> primaryTrigger = const Value.absent(),
  }) => RecoveryProfileEntity(
    id: id ?? this.id,
    startDate: startDate ?? this.startDate,
    longestStreak: longestStreak ?? this.longestStreak,
    currentStreak: currentStreak ?? this.currentStreak,
    primaryTrigger: primaryTrigger.present
        ? primaryTrigger.value
        : this.primaryTrigger,
  );
  RecoveryProfileEntity copyWithCompanion(RecoveryProfilesTableCompanion data) {
    return RecoveryProfileEntity(
      id: data.id.present ? data.id.value : this.id,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      longestStreak: data.longestStreak.present
          ? data.longestStreak.value
          : this.longestStreak,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      primaryTrigger: data.primaryTrigger.present
          ? data.primaryTrigger.value
          : this.primaryTrigger,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecoveryProfileEntity(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('primaryTrigger: $primaryTrigger')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, startDate, longestStreak, currentStreak, primaryTrigger);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecoveryProfileEntity &&
          other.id == this.id &&
          other.startDate == this.startDate &&
          other.longestStreak == this.longestStreak &&
          other.currentStreak == this.currentStreak &&
          other.primaryTrigger == this.primaryTrigger);
}

class RecoveryProfilesTableCompanion
    extends UpdateCompanion<RecoveryProfileEntity> {
  final Value<String> id;
  final Value<DateTime> startDate;
  final Value<int> longestStreak;
  final Value<int> currentStreak;
  final Value<String?> primaryTrigger;
  final Value<int> rowid;
  const RecoveryProfilesTableCompanion({
    this.id = const Value.absent(),
    this.startDate = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.primaryTrigger = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecoveryProfilesTableCompanion.insert({
    this.id = const Value.absent(),
    required DateTime startDate,
    this.longestStreak = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.primaryTrigger = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : startDate = Value(startDate);
  static Insertable<RecoveryProfileEntity> custom({
    Expression<String>? id,
    Expression<DateTime>? startDate,
    Expression<int>? longestStreak,
    Expression<int>? currentStreak,
    Expression<String>? primaryTrigger,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startDate != null) 'start_date': startDate,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (primaryTrigger != null) 'primary_trigger': primaryTrigger,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecoveryProfilesTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? startDate,
    Value<int>? longestStreak,
    Value<int>? currentStreak,
    Value<String?>? primaryTrigger,
    Value<int>? rowid,
  }) {
    return RecoveryProfilesTableCompanion(
      id: id ?? this.id,
      startDate: startDate ?? this.startDate,
      longestStreak: longestStreak ?? this.longestStreak,
      currentStreak: currentStreak ?? this.currentStreak,
      primaryTrigger: primaryTrigger ?? this.primaryTrigger,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (primaryTrigger.present) {
      map['primary_trigger'] = Variable<String>(primaryTrigger.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecoveryProfilesTableCompanion(')
          ..write('id: $id, ')
          ..write('startDate: $startDate, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('primaryTrigger: $primaryTrigger, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AvoidedHabitsTableTable extends AvoidedHabitsTable
    with TableInfo<$AvoidedHabitsTableTable, AvoidedHabitEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AvoidedHabitsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _motivationMeta = const VerificationMeta(
    'motivation',
  );
  @override
  late final GeneratedColumn<String> motivation = GeneratedColumn<String>(
    'motivation',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdDateMeta = const VerificationMeta(
    'createdDate',
  );
  @override
  late final GeneratedColumn<DateTime> createdDate = GeneratedColumn<DateTime>(
    'created_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, motivation, createdDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'avoided_habits_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AvoidedHabitEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('motivation')) {
      context.handle(
        _motivationMeta,
        motivation.isAcceptableOrUnknown(data['motivation']!, _motivationMeta),
      );
    }
    if (data.containsKey('created_date')) {
      context.handle(
        _createdDateMeta,
        createdDate.isAcceptableOrUnknown(
          data['created_date']!,
          _createdDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AvoidedHabitEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AvoidedHabitEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      motivation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motivation'],
      ),
      createdDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_date'],
      )!,
    );
  }

  @override
  $AvoidedHabitsTableTable createAlias(String alias) {
    return $AvoidedHabitsTableTable(attachedDatabase, alias);
  }
}

class AvoidedHabitEntity extends DataClass
    implements Insertable<AvoidedHabitEntity> {
  final String id;
  final String title;
  final String? motivation;
  final DateTime createdDate;
  const AvoidedHabitEntity({
    required this.id,
    required this.title,
    this.motivation,
    required this.createdDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || motivation != null) {
      map['motivation'] = Variable<String>(motivation);
    }
    map['created_date'] = Variable<DateTime>(createdDate);
    return map;
  }

  AvoidedHabitsTableCompanion toCompanion(bool nullToAbsent) {
    return AvoidedHabitsTableCompanion(
      id: Value(id),
      title: Value(title),
      motivation: motivation == null && nullToAbsent
          ? const Value.absent()
          : Value(motivation),
      createdDate: Value(createdDate),
    );
  }

  factory AvoidedHabitEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AvoidedHabitEntity(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      motivation: serializer.fromJson<String?>(json['motivation']),
      createdDate: serializer.fromJson<DateTime>(json['createdDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'motivation': serializer.toJson<String?>(motivation),
      'createdDate': serializer.toJson<DateTime>(createdDate),
    };
  }

  AvoidedHabitEntity copyWith({
    String? id,
    String? title,
    Value<String?> motivation = const Value.absent(),
    DateTime? createdDate,
  }) => AvoidedHabitEntity(
    id: id ?? this.id,
    title: title ?? this.title,
    motivation: motivation.present ? motivation.value : this.motivation,
    createdDate: createdDate ?? this.createdDate,
  );
  AvoidedHabitEntity copyWithCompanion(AvoidedHabitsTableCompanion data) {
    return AvoidedHabitEntity(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      motivation: data.motivation.present
          ? data.motivation.value
          : this.motivation,
      createdDate: data.createdDate.present
          ? data.createdDate.value
          : this.createdDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AvoidedHabitEntity(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('motivation: $motivation, ')
          ..write('createdDate: $createdDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, motivation, createdDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AvoidedHabitEntity &&
          other.id == this.id &&
          other.title == this.title &&
          other.motivation == this.motivation &&
          other.createdDate == this.createdDate);
}

class AvoidedHabitsTableCompanion extends UpdateCompanion<AvoidedHabitEntity> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> motivation;
  final Value<DateTime> createdDate;
  final Value<int> rowid;
  const AvoidedHabitsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.motivation = const Value.absent(),
    this.createdDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AvoidedHabitsTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.motivation = const Value.absent(),
    required DateTime createdDate,
    this.rowid = const Value.absent(),
  }) : title = Value(title),
       createdDate = Value(createdDate);
  static Insertable<AvoidedHabitEntity> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? motivation,
    Expression<DateTime>? createdDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (motivation != null) 'motivation': motivation,
      if (createdDate != null) 'created_date': createdDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AvoidedHabitsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? motivation,
    Value<DateTime>? createdDate,
    Value<int>? rowid,
  }) {
    return AvoidedHabitsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      motivation: motivation ?? this.motivation,
      createdDate: createdDate ?? this.createdDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (motivation.present) {
      map['motivation'] = Variable<String>(motivation.value);
    }
    if (createdDate.present) {
      map['created_date'] = Variable<DateTime>(createdDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AvoidedHabitsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('motivation: $motivation, ')
          ..write('createdDate: $createdDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UrgeLogsTableTable extends UrgeLogsTable
    with TableInfo<$UrgeLogsTableTable, UrgeLogEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UrgeLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intensityMeta = const VerificationMeta(
    'intensity',
  );
  @override
  late final GeneratedColumn<int> intensity = GeneratedColumn<int>(
    'intensity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _triggerTypeMeta = const VerificationMeta(
    'triggerType',
  );
  @override
  late final GeneratedColumn<String> triggerType = GeneratedColumn<String>(
    'trigger_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _outcomeMeta = const VerificationMeta(
    'outcome',
  );
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
    'outcome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reflectionNotesMeta = const VerificationMeta(
    'reflectionNotes',
  );
  @override
  late final GeneratedColumn<String> reflectionNotes = GeneratedColumn<String>(
    'reflection_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    timestamp,
    intensity,
    triggerType,
    outcome,
    reflectionNotes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'urge_logs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UrgeLogEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('intensity')) {
      context.handle(
        _intensityMeta,
        intensity.isAcceptableOrUnknown(data['intensity']!, _intensityMeta),
      );
    } else if (isInserting) {
      context.missing(_intensityMeta);
    }
    if (data.containsKey('trigger_type')) {
      context.handle(
        _triggerTypeMeta,
        triggerType.isAcceptableOrUnknown(
          data['trigger_type']!,
          _triggerTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_triggerTypeMeta);
    }
    if (data.containsKey('outcome')) {
      context.handle(
        _outcomeMeta,
        outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta),
      );
    } else if (isInserting) {
      context.missing(_outcomeMeta);
    }
    if (data.containsKey('reflection_notes')) {
      context.handle(
        _reflectionNotesMeta,
        reflectionNotes.isAcceptableOrUnknown(
          data['reflection_notes']!,
          _reflectionNotesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UrgeLogEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UrgeLogEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      intensity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intensity'],
      )!,
      triggerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trigger_type'],
      )!,
      outcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outcome'],
      )!,
      reflectionNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reflection_notes'],
      ),
    );
  }

  @override
  $UrgeLogsTableTable createAlias(String alias) {
    return $UrgeLogsTableTable(attachedDatabase, alias);
  }
}

class UrgeLogEntity extends DataClass implements Insertable<UrgeLogEntity> {
  final String id;
  final String? habitId;
  final DateTime timestamp;
  final int intensity;
  final String triggerType;
  final String outcome;
  final String? reflectionNotes;
  const UrgeLogEntity({
    required this.id,
    this.habitId,
    required this.timestamp,
    required this.intensity,
    required this.triggerType,
    required this.outcome,
    this.reflectionNotes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || habitId != null) {
      map['habit_id'] = Variable<String>(habitId);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['intensity'] = Variable<int>(intensity);
    map['trigger_type'] = Variable<String>(triggerType);
    map['outcome'] = Variable<String>(outcome);
    if (!nullToAbsent || reflectionNotes != null) {
      map['reflection_notes'] = Variable<String>(reflectionNotes);
    }
    return map;
  }

  UrgeLogsTableCompanion toCompanion(bool nullToAbsent) {
    return UrgeLogsTableCompanion(
      id: Value(id),
      habitId: habitId == null && nullToAbsent
          ? const Value.absent()
          : Value(habitId),
      timestamp: Value(timestamp),
      intensity: Value(intensity),
      triggerType: Value(triggerType),
      outcome: Value(outcome),
      reflectionNotes: reflectionNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(reflectionNotes),
    );
  }

  factory UrgeLogEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UrgeLogEntity(
      id: serializer.fromJson<String>(json['id']),
      habitId: serializer.fromJson<String?>(json['habitId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      intensity: serializer.fromJson<int>(json['intensity']),
      triggerType: serializer.fromJson<String>(json['triggerType']),
      outcome: serializer.fromJson<String>(json['outcome']),
      reflectionNotes: serializer.fromJson<String?>(json['reflectionNotes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'habitId': serializer.toJson<String?>(habitId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'intensity': serializer.toJson<int>(intensity),
      'triggerType': serializer.toJson<String>(triggerType),
      'outcome': serializer.toJson<String>(outcome),
      'reflectionNotes': serializer.toJson<String?>(reflectionNotes),
    };
  }

  UrgeLogEntity copyWith({
    String? id,
    Value<String?> habitId = const Value.absent(),
    DateTime? timestamp,
    int? intensity,
    String? triggerType,
    String? outcome,
    Value<String?> reflectionNotes = const Value.absent(),
  }) => UrgeLogEntity(
    id: id ?? this.id,
    habitId: habitId.present ? habitId.value : this.habitId,
    timestamp: timestamp ?? this.timestamp,
    intensity: intensity ?? this.intensity,
    triggerType: triggerType ?? this.triggerType,
    outcome: outcome ?? this.outcome,
    reflectionNotes: reflectionNotes.present
        ? reflectionNotes.value
        : this.reflectionNotes,
  );
  UrgeLogEntity copyWithCompanion(UrgeLogsTableCompanion data) {
    return UrgeLogEntity(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      intensity: data.intensity.present ? data.intensity.value : this.intensity,
      triggerType: data.triggerType.present
          ? data.triggerType.value
          : this.triggerType,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      reflectionNotes: data.reflectionNotes.present
          ? data.reflectionNotes.value
          : this.reflectionNotes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UrgeLogEntity(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('timestamp: $timestamp, ')
          ..write('intensity: $intensity, ')
          ..write('triggerType: $triggerType, ')
          ..write('outcome: $outcome, ')
          ..write('reflectionNotes: $reflectionNotes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    habitId,
    timestamp,
    intensity,
    triggerType,
    outcome,
    reflectionNotes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UrgeLogEntity &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.timestamp == this.timestamp &&
          other.intensity == this.intensity &&
          other.triggerType == this.triggerType &&
          other.outcome == this.outcome &&
          other.reflectionNotes == this.reflectionNotes);
}

class UrgeLogsTableCompanion extends UpdateCompanion<UrgeLogEntity> {
  final Value<String> id;
  final Value<String?> habitId;
  final Value<DateTime> timestamp;
  final Value<int> intensity;
  final Value<String> triggerType;
  final Value<String> outcome;
  final Value<String?> reflectionNotes;
  final Value<int> rowid;
  const UrgeLogsTableCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.intensity = const Value.absent(),
    this.triggerType = const Value.absent(),
    this.outcome = const Value.absent(),
    this.reflectionNotes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UrgeLogsTableCompanion.insert({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    required DateTime timestamp,
    required int intensity,
    required String triggerType,
    required String outcome,
    this.reflectionNotes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : timestamp = Value(timestamp),
       intensity = Value(intensity),
       triggerType = Value(triggerType),
       outcome = Value(outcome);
  static Insertable<UrgeLogEntity> custom({
    Expression<String>? id,
    Expression<String>? habitId,
    Expression<DateTime>? timestamp,
    Expression<int>? intensity,
    Expression<String>? triggerType,
    Expression<String>? outcome,
    Expression<String>? reflectionNotes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (timestamp != null) 'timestamp': timestamp,
      if (intensity != null) 'intensity': intensity,
      if (triggerType != null) 'trigger_type': triggerType,
      if (outcome != null) 'outcome': outcome,
      if (reflectionNotes != null) 'reflection_notes': reflectionNotes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UrgeLogsTableCompanion copyWith({
    Value<String>? id,
    Value<String?>? habitId,
    Value<DateTime>? timestamp,
    Value<int>? intensity,
    Value<String>? triggerType,
    Value<String>? outcome,
    Value<String?>? reflectionNotes,
    Value<int>? rowid,
  }) {
    return UrgeLogsTableCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      timestamp: timestamp ?? this.timestamp,
      intensity: intensity ?? this.intensity,
      triggerType: triggerType ?? this.triggerType,
      outcome: outcome ?? this.outcome,
      reflectionNotes: reflectionNotes ?? this.reflectionNotes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (intensity.present) {
      map['intensity'] = Variable<int>(intensity.value);
    }
    if (triggerType.present) {
      map['trigger_type'] = Variable<String>(triggerType.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (reflectionNotes.present) {
      map['reflection_notes'] = Variable<String>(reflectionNotes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UrgeLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('timestamp: $timestamp, ')
          ..write('intensity: $intensity, ')
          ..write('triggerType: $triggerType, ')
          ..write('outcome: $outcome, ')
          ..write('reflectionNotes: $reflectionNotes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyRitualsTableTable extends DailyRitualsTable
    with TableInfo<$DailyRitualsTableTable, DailyRitualEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyRitualsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _routineTypeMeta = const VerificationMeta(
    'routineType',
  );
  @override
  late final GeneratedColumn<String> routineType = GeneratedColumn<String>(
    'routine_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconEmojiMeta = const VerificationMeta(
    'iconEmoji',
  );
  @override
  late final GeneratedColumn<String> iconEmoji = GeneratedColumn<String>(
    'icon_emoji',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('💧'),
  );
  static const VerificationMeta _targetDurationMinutesMeta =
      const VerificationMeta('targetDurationMinutes');
  @override
  late final GeneratedColumn<int> targetDurationMinutes = GeneratedColumn<int>(
    'target_duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    routineType,
    iconEmoji,
    targetDurationMinutes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_rituals_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyRitualEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('routine_type')) {
      context.handle(
        _routineTypeMeta,
        routineType.isAcceptableOrUnknown(
          data['routine_type']!,
          _routineTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_routineTypeMeta);
    }
    if (data.containsKey('icon_emoji')) {
      context.handle(
        _iconEmojiMeta,
        iconEmoji.isAcceptableOrUnknown(data['icon_emoji']!, _iconEmojiMeta),
      );
    }
    if (data.containsKey('target_duration_minutes')) {
      context.handle(
        _targetDurationMinutesMeta,
        targetDurationMinutes.isAcceptableOrUnknown(
          data['target_duration_minutes']!,
          _targetDurationMinutesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyRitualEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyRitualEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      routineType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}routine_type'],
      )!,
      iconEmoji: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_emoji'],
      )!,
      targetDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_duration_minutes'],
      )!,
    );
  }

  @override
  $DailyRitualsTableTable createAlias(String alias) {
    return $DailyRitualsTableTable(attachedDatabase, alias);
  }
}

class DailyRitualEntity extends DataClass
    implements Insertable<DailyRitualEntity> {
  final String id;
  final String title;
  final String? description;
  final String routineType;
  final String iconEmoji;
  final int targetDurationMinutes;
  const DailyRitualEntity({
    required this.id,
    required this.title,
    this.description,
    required this.routineType,
    required this.iconEmoji,
    required this.targetDurationMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['routine_type'] = Variable<String>(routineType);
    map['icon_emoji'] = Variable<String>(iconEmoji);
    map['target_duration_minutes'] = Variable<int>(targetDurationMinutes);
    return map;
  }

  DailyRitualsTableCompanion toCompanion(bool nullToAbsent) {
    return DailyRitualsTableCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      routineType: Value(routineType),
      iconEmoji: Value(iconEmoji),
      targetDurationMinutes: Value(targetDurationMinutes),
    );
  }

  factory DailyRitualEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyRitualEntity(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      routineType: serializer.fromJson<String>(json['routineType']),
      iconEmoji: serializer.fromJson<String>(json['iconEmoji']),
      targetDurationMinutes: serializer.fromJson<int>(
        json['targetDurationMinutes'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'routineType': serializer.toJson<String>(routineType),
      'iconEmoji': serializer.toJson<String>(iconEmoji),
      'targetDurationMinutes': serializer.toJson<int>(targetDurationMinutes),
    };
  }

  DailyRitualEntity copyWith({
    String? id,
    String? title,
    Value<String?> description = const Value.absent(),
    String? routineType,
    String? iconEmoji,
    int? targetDurationMinutes,
  }) => DailyRitualEntity(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    routineType: routineType ?? this.routineType,
    iconEmoji: iconEmoji ?? this.iconEmoji,
    targetDurationMinutes: targetDurationMinutes ?? this.targetDurationMinutes,
  );
  DailyRitualEntity copyWithCompanion(DailyRitualsTableCompanion data) {
    return DailyRitualEntity(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      routineType: data.routineType.present
          ? data.routineType.value
          : this.routineType,
      iconEmoji: data.iconEmoji.present ? data.iconEmoji.value : this.iconEmoji,
      targetDurationMinutes: data.targetDurationMinutes.present
          ? data.targetDurationMinutes.value
          : this.targetDurationMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyRitualEntity(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('routineType: $routineType, ')
          ..write('iconEmoji: $iconEmoji, ')
          ..write('targetDurationMinutes: $targetDurationMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    routineType,
    iconEmoji,
    targetDurationMinutes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyRitualEntity &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.routineType == this.routineType &&
          other.iconEmoji == this.iconEmoji &&
          other.targetDurationMinutes == this.targetDurationMinutes);
}

class DailyRitualsTableCompanion extends UpdateCompanion<DailyRitualEntity> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> routineType;
  final Value<String> iconEmoji;
  final Value<int> targetDurationMinutes;
  final Value<int> rowid;
  const DailyRitualsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.routineType = const Value.absent(),
    this.iconEmoji = const Value.absent(),
    this.targetDurationMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyRitualsTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    required String routineType,
    this.iconEmoji = const Value.absent(),
    this.targetDurationMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : title = Value(title),
       routineType = Value(routineType);
  static Insertable<DailyRitualEntity> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? routineType,
    Expression<String>? iconEmoji,
    Expression<int>? targetDurationMinutes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (routineType != null) 'routine_type': routineType,
      if (iconEmoji != null) 'icon_emoji': iconEmoji,
      if (targetDurationMinutes != null)
        'target_duration_minutes': targetDurationMinutes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyRitualsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<String>? routineType,
    Value<String>? iconEmoji,
    Value<int>? targetDurationMinutes,
    Value<int>? rowid,
  }) {
    return DailyRitualsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      routineType: routineType ?? this.routineType,
      iconEmoji: iconEmoji ?? this.iconEmoji,
      targetDurationMinutes:
          targetDurationMinutes ?? this.targetDurationMinutes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (routineType.present) {
      map['routine_type'] = Variable<String>(routineType.value);
    }
    if (iconEmoji.present) {
      map['icon_emoji'] = Variable<String>(iconEmoji.value);
    }
    if (targetDurationMinutes.present) {
      map['target_duration_minutes'] = Variable<int>(
        targetDurationMinutes.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyRitualsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('routineType: $routineType, ')
          ..write('iconEmoji: $iconEmoji, ')
          ..write('targetDurationMinutes: $targetDurationMinutes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RitualLogsTableTable extends RitualLogsTable
    with TableInfo<$RitualLogsTableTable, RitualLogEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RitualLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _ritualIdMeta = const VerificationMeta(
    'ritualId',
  );
  @override
  late final GeneratedColumn<String> ritualId = GeneratedColumn<String>(
    'ritual_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, ritualId, completedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ritual_logs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RitualLogEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ritual_id')) {
      context.handle(
        _ritualIdMeta,
        ritualId.isAcceptableOrUnknown(data['ritual_id']!, _ritualIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ritualIdMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RitualLogEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RitualLogEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ritualId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ritual_id'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
    );
  }

  @override
  $RitualLogsTableTable createAlias(String alias) {
    return $RitualLogsTableTable(attachedDatabase, alias);
  }
}

class RitualLogEntity extends DataClass implements Insertable<RitualLogEntity> {
  final String id;
  final String ritualId;
  final DateTime completedAt;
  const RitualLogEntity({
    required this.id,
    required this.ritualId,
    required this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['ritual_id'] = Variable<String>(ritualId);
    map['completed_at'] = Variable<DateTime>(completedAt);
    return map;
  }

  RitualLogsTableCompanion toCompanion(bool nullToAbsent) {
    return RitualLogsTableCompanion(
      id: Value(id),
      ritualId: Value(ritualId),
      completedAt: Value(completedAt),
    );
  }

  factory RitualLogEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RitualLogEntity(
      id: serializer.fromJson<String>(json['id']),
      ritualId: serializer.fromJson<String>(json['ritualId']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ritualId': serializer.toJson<String>(ritualId),
      'completedAt': serializer.toJson<DateTime>(completedAt),
    };
  }

  RitualLogEntity copyWith({
    String? id,
    String? ritualId,
    DateTime? completedAt,
  }) => RitualLogEntity(
    id: id ?? this.id,
    ritualId: ritualId ?? this.ritualId,
    completedAt: completedAt ?? this.completedAt,
  );
  RitualLogEntity copyWithCompanion(RitualLogsTableCompanion data) {
    return RitualLogEntity(
      id: data.id.present ? data.id.value : this.id,
      ritualId: data.ritualId.present ? data.ritualId.value : this.ritualId,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RitualLogEntity(')
          ..write('id: $id, ')
          ..write('ritualId: $ritualId, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ritualId, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RitualLogEntity &&
          other.id == this.id &&
          other.ritualId == this.ritualId &&
          other.completedAt == this.completedAt);
}

class RitualLogsTableCompanion extends UpdateCompanion<RitualLogEntity> {
  final Value<String> id;
  final Value<String> ritualId;
  final Value<DateTime> completedAt;
  final Value<int> rowid;
  const RitualLogsTableCompanion({
    this.id = const Value.absent(),
    this.ritualId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RitualLogsTableCompanion.insert({
    this.id = const Value.absent(),
    required String ritualId,
    required DateTime completedAt,
    this.rowid = const Value.absent(),
  }) : ritualId = Value(ritualId),
       completedAt = Value(completedAt);
  static Insertable<RitualLogEntity> custom({
    Expression<String>? id,
    Expression<String>? ritualId,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ritualId != null) 'ritual_id': ritualId,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RitualLogsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? ritualId,
    Value<DateTime>? completedAt,
    Value<int>? rowid,
  }) {
    return RitualLogsTableCompanion(
      id: id ?? this.id,
      ritualId: ritualId ?? this.ritualId,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ritualId.present) {
      map['ritual_id'] = Variable<String>(ritualId.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RitualLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('ritualId: $ritualId, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProcrastinationLogsTableTable extends ProcrastinationLogsTable
    with TableInfo<$ProcrastinationLogsTableTable, ProcrastinationLogEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProcrastinationLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => '',
  );
  static const VerificationMeta _ritualIdMeta = const VerificationMeta(
    'ritualId',
  );
  @override
  late final GeneratedColumn<String> ritualId = GeneratedColumn<String>(
    'ritual_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduledTimeMeta = const VerificationMeta(
    'scheduledTime',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledTime =
      GeneratedColumn<DateTime>(
        'scheduled_time',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _logTimeMeta = const VerificationMeta(
    'logTime',
  );
  @override
  late final GeneratedColumn<DateTime> logTime = GeneratedColumn<DateTime>(
    'log_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _delayCountMeta = const VerificationMeta(
    'delayCount',
  );
  @override
  late final GeneratedColumn<int> delayCount = GeneratedColumn<int>(
    'delay_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _procrastinationReasonMeta =
      const VerificationMeta('procrastinationReason');
  @override
  late final GeneratedColumn<String> procrastinationReason =
      GeneratedColumn<String>(
        'procrastination_reason',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _wasCompletedEventuallyMeta =
      const VerificationMeta('wasCompletedEventually');
  @override
  late final GeneratedColumn<bool> wasCompletedEventually =
      GeneratedColumn<bool>(
        'was_completed_eventually',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("was_completed_eventually" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ritualId,
    scheduledTime,
    logTime,
    delayCount,
    procrastinationReason,
    wasCompletedEventually,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'procrastination_logs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProcrastinationLogEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ritual_id')) {
      context.handle(
        _ritualIdMeta,
        ritualId.isAcceptableOrUnknown(data['ritual_id']!, _ritualIdMeta),
      );
    }
    if (data.containsKey('scheduled_time')) {
      context.handle(
        _scheduledTimeMeta,
        scheduledTime.isAcceptableOrUnknown(
          data['scheduled_time']!,
          _scheduledTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledTimeMeta);
    }
    if (data.containsKey('log_time')) {
      context.handle(
        _logTimeMeta,
        logTime.isAcceptableOrUnknown(data['log_time']!, _logTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_logTimeMeta);
    }
    if (data.containsKey('delay_count')) {
      context.handle(
        _delayCountMeta,
        delayCount.isAcceptableOrUnknown(data['delay_count']!, _delayCountMeta),
      );
    }
    if (data.containsKey('procrastination_reason')) {
      context.handle(
        _procrastinationReasonMeta,
        procrastinationReason.isAcceptableOrUnknown(
          data['procrastination_reason']!,
          _procrastinationReasonMeta,
        ),
      );
    }
    if (data.containsKey('was_completed_eventually')) {
      context.handle(
        _wasCompletedEventuallyMeta,
        wasCompletedEventually.isAcceptableOrUnknown(
          data['was_completed_eventually']!,
          _wasCompletedEventuallyMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProcrastinationLogEntity map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProcrastinationLogEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ritualId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ritual_id'],
      ),
      scheduledTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_time'],
      )!,
      logTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}log_time'],
      )!,
      delayCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}delay_count'],
      )!,
      procrastinationReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}procrastination_reason'],
      ),
      wasCompletedEventually: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}was_completed_eventually'],
      )!,
    );
  }

  @override
  $ProcrastinationLogsTableTable createAlias(String alias) {
    return $ProcrastinationLogsTableTable(attachedDatabase, alias);
  }
}

class ProcrastinationLogEntity extends DataClass
    implements Insertable<ProcrastinationLogEntity> {
  final String id;
  final String? ritualId;
  final DateTime scheduledTime;
  final DateTime logTime;
  final int delayCount;
  final String? procrastinationReason;
  final bool wasCompletedEventually;
  const ProcrastinationLogEntity({
    required this.id,
    this.ritualId,
    required this.scheduledTime,
    required this.logTime,
    required this.delayCount,
    this.procrastinationReason,
    required this.wasCompletedEventually,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || ritualId != null) {
      map['ritual_id'] = Variable<String>(ritualId);
    }
    map['scheduled_time'] = Variable<DateTime>(scheduledTime);
    map['log_time'] = Variable<DateTime>(logTime);
    map['delay_count'] = Variable<int>(delayCount);
    if (!nullToAbsent || procrastinationReason != null) {
      map['procrastination_reason'] = Variable<String>(procrastinationReason);
    }
    map['was_completed_eventually'] = Variable<bool>(wasCompletedEventually);
    return map;
  }

  ProcrastinationLogsTableCompanion toCompanion(bool nullToAbsent) {
    return ProcrastinationLogsTableCompanion(
      id: Value(id),
      ritualId: ritualId == null && nullToAbsent
          ? const Value.absent()
          : Value(ritualId),
      scheduledTime: Value(scheduledTime),
      logTime: Value(logTime),
      delayCount: Value(delayCount),
      procrastinationReason: procrastinationReason == null && nullToAbsent
          ? const Value.absent()
          : Value(procrastinationReason),
      wasCompletedEventually: Value(wasCompletedEventually),
    );
  }

  factory ProcrastinationLogEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProcrastinationLogEntity(
      id: serializer.fromJson<String>(json['id']),
      ritualId: serializer.fromJson<String?>(json['ritualId']),
      scheduledTime: serializer.fromJson<DateTime>(json['scheduledTime']),
      logTime: serializer.fromJson<DateTime>(json['logTime']),
      delayCount: serializer.fromJson<int>(json['delayCount']),
      procrastinationReason: serializer.fromJson<String?>(
        json['procrastinationReason'],
      ),
      wasCompletedEventually: serializer.fromJson<bool>(
        json['wasCompletedEventually'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ritualId': serializer.toJson<String?>(ritualId),
      'scheduledTime': serializer.toJson<DateTime>(scheduledTime),
      'logTime': serializer.toJson<DateTime>(logTime),
      'delayCount': serializer.toJson<int>(delayCount),
      'procrastinationReason': serializer.toJson<String?>(
        procrastinationReason,
      ),
      'wasCompletedEventually': serializer.toJson<bool>(wasCompletedEventually),
    };
  }

  ProcrastinationLogEntity copyWith({
    String? id,
    Value<String?> ritualId = const Value.absent(),
    DateTime? scheduledTime,
    DateTime? logTime,
    int? delayCount,
    Value<String?> procrastinationReason = const Value.absent(),
    bool? wasCompletedEventually,
  }) => ProcrastinationLogEntity(
    id: id ?? this.id,
    ritualId: ritualId.present ? ritualId.value : this.ritualId,
    scheduledTime: scheduledTime ?? this.scheduledTime,
    logTime: logTime ?? this.logTime,
    delayCount: delayCount ?? this.delayCount,
    procrastinationReason: procrastinationReason.present
        ? procrastinationReason.value
        : this.procrastinationReason,
    wasCompletedEventually:
        wasCompletedEventually ?? this.wasCompletedEventually,
  );
  ProcrastinationLogEntity copyWithCompanion(
    ProcrastinationLogsTableCompanion data,
  ) {
    return ProcrastinationLogEntity(
      id: data.id.present ? data.id.value : this.id,
      ritualId: data.ritualId.present ? data.ritualId.value : this.ritualId,
      scheduledTime: data.scheduledTime.present
          ? data.scheduledTime.value
          : this.scheduledTime,
      logTime: data.logTime.present ? data.logTime.value : this.logTime,
      delayCount: data.delayCount.present
          ? data.delayCount.value
          : this.delayCount,
      procrastinationReason: data.procrastinationReason.present
          ? data.procrastinationReason.value
          : this.procrastinationReason,
      wasCompletedEventually: data.wasCompletedEventually.present
          ? data.wasCompletedEventually.value
          : this.wasCompletedEventually,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProcrastinationLogEntity(')
          ..write('id: $id, ')
          ..write('ritualId: $ritualId, ')
          ..write('scheduledTime: $scheduledTime, ')
          ..write('logTime: $logTime, ')
          ..write('delayCount: $delayCount, ')
          ..write('procrastinationReason: $procrastinationReason, ')
          ..write('wasCompletedEventually: $wasCompletedEventually')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ritualId,
    scheduledTime,
    logTime,
    delayCount,
    procrastinationReason,
    wasCompletedEventually,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProcrastinationLogEntity &&
          other.id == this.id &&
          other.ritualId == this.ritualId &&
          other.scheduledTime == this.scheduledTime &&
          other.logTime == this.logTime &&
          other.delayCount == this.delayCount &&
          other.procrastinationReason == this.procrastinationReason &&
          other.wasCompletedEventually == this.wasCompletedEventually);
}

class ProcrastinationLogsTableCompanion
    extends UpdateCompanion<ProcrastinationLogEntity> {
  final Value<String> id;
  final Value<String?> ritualId;
  final Value<DateTime> scheduledTime;
  final Value<DateTime> logTime;
  final Value<int> delayCount;
  final Value<String?> procrastinationReason;
  final Value<bool> wasCompletedEventually;
  final Value<int> rowid;
  const ProcrastinationLogsTableCompanion({
    this.id = const Value.absent(),
    this.ritualId = const Value.absent(),
    this.scheduledTime = const Value.absent(),
    this.logTime = const Value.absent(),
    this.delayCount = const Value.absent(),
    this.procrastinationReason = const Value.absent(),
    this.wasCompletedEventually = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProcrastinationLogsTableCompanion.insert({
    this.id = const Value.absent(),
    this.ritualId = const Value.absent(),
    required DateTime scheduledTime,
    required DateTime logTime,
    this.delayCount = const Value.absent(),
    this.procrastinationReason = const Value.absent(),
    this.wasCompletedEventually = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : scheduledTime = Value(scheduledTime),
       logTime = Value(logTime);
  static Insertable<ProcrastinationLogEntity> custom({
    Expression<String>? id,
    Expression<String>? ritualId,
    Expression<DateTime>? scheduledTime,
    Expression<DateTime>? logTime,
    Expression<int>? delayCount,
    Expression<String>? procrastinationReason,
    Expression<bool>? wasCompletedEventually,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ritualId != null) 'ritual_id': ritualId,
      if (scheduledTime != null) 'scheduled_time': scheduledTime,
      if (logTime != null) 'log_time': logTime,
      if (delayCount != null) 'delay_count': delayCount,
      if (procrastinationReason != null)
        'procrastination_reason': procrastinationReason,
      if (wasCompletedEventually != null)
        'was_completed_eventually': wasCompletedEventually,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProcrastinationLogsTableCompanion copyWith({
    Value<String>? id,
    Value<String?>? ritualId,
    Value<DateTime>? scheduledTime,
    Value<DateTime>? logTime,
    Value<int>? delayCount,
    Value<String?>? procrastinationReason,
    Value<bool>? wasCompletedEventually,
    Value<int>? rowid,
  }) {
    return ProcrastinationLogsTableCompanion(
      id: id ?? this.id,
      ritualId: ritualId ?? this.ritualId,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      logTime: logTime ?? this.logTime,
      delayCount: delayCount ?? this.delayCount,
      procrastinationReason:
          procrastinationReason ?? this.procrastinationReason,
      wasCompletedEventually:
          wasCompletedEventually ?? this.wasCompletedEventually,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ritualId.present) {
      map['ritual_id'] = Variable<String>(ritualId.value);
    }
    if (scheduledTime.present) {
      map['scheduled_time'] = Variable<DateTime>(scheduledTime.value);
    }
    if (logTime.present) {
      map['log_time'] = Variable<DateTime>(logTime.value);
    }
    if (delayCount.present) {
      map['delay_count'] = Variable<int>(delayCount.value);
    }
    if (procrastinationReason.present) {
      map['procrastination_reason'] = Variable<String>(
        procrastinationReason.value,
      );
    }
    if (wasCompletedEventually.present) {
      map['was_completed_eventually'] = Variable<bool>(
        wasCompletedEventually.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProcrastinationLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('ritualId: $ritualId, ')
          ..write('scheduledTime: $scheduledTime, ')
          ..write('logTime: $logTime, ')
          ..write('delayCount: $delayCount, ')
          ..write('procrastinationReason: $procrastinationReason, ')
          ..write('wasCompletedEventually: $wasCompletedEventually, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserSubscriptionsTableTable extends UserSubscriptionsTable
    with TableInfo<$UserSubscriptionsTableTable, UserSubscriptionEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSubscriptionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
  );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta(
    'expiryDate',
  );
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
    'expiry_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allowedSubjectsMeta = const VerificationMeta(
    'allowedSubjects',
  );
  @override
  late final GeneratedColumn<String> allowedSubjects = GeneratedColumn<String>(
    'allowed_subjects',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    status,
    active,
    expiryDate,
    allowedSubjects,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_subscriptions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserSubscriptionEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    } else if (isInserting) {
      context.missing(_activeMeta);
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
        _expiryDateMeta,
        expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta),
      );
    }
    if (data.containsKey('allowed_subjects')) {
      context.handle(
        _allowedSubjectsMeta,
        allowedSubjects.isAcceptableOrUnknown(
          data['allowed_subjects']!,
          _allowedSubjectsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_allowedSubjectsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  UserSubscriptionEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSubscriptionEntity(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      expiryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiry_date'],
      ),
      allowedSubjects: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allowed_subjects'],
      )!,
    );
  }

  @override
  $UserSubscriptionsTableTable createAlias(String alias) {
    return $UserSubscriptionsTableTable(attachedDatabase, alias);
  }
}

class UserSubscriptionEntity extends DataClass
    implements Insertable<UserSubscriptionEntity> {
  final String userId;
  final String status;
  final bool active;
  final DateTime? expiryDate;
  final String allowedSubjects;
  const UserSubscriptionEntity({
    required this.userId,
    required this.status,
    required this.active,
    this.expiryDate,
    required this.allowedSubjects,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['status'] = Variable<String>(status);
    map['active'] = Variable<bool>(active);
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<DateTime>(expiryDate);
    }
    map['allowed_subjects'] = Variable<String>(allowedSubjects);
    return map;
  }

  UserSubscriptionsTableCompanion toCompanion(bool nullToAbsent) {
    return UserSubscriptionsTableCompanion(
      userId: Value(userId),
      status: Value(status),
      active: Value(active),
      expiryDate: expiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryDate),
      allowedSubjects: Value(allowedSubjects),
    );
  }

  factory UserSubscriptionEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSubscriptionEntity(
      userId: serializer.fromJson<String>(json['userId']),
      status: serializer.fromJson<String>(json['status']),
      active: serializer.fromJson<bool>(json['active']),
      expiryDate: serializer.fromJson<DateTime?>(json['expiryDate']),
      allowedSubjects: serializer.fromJson<String>(json['allowedSubjects']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'status': serializer.toJson<String>(status),
      'active': serializer.toJson<bool>(active),
      'expiryDate': serializer.toJson<DateTime?>(expiryDate),
      'allowedSubjects': serializer.toJson<String>(allowedSubjects),
    };
  }

  UserSubscriptionEntity copyWith({
    String? userId,
    String? status,
    bool? active,
    Value<DateTime?> expiryDate = const Value.absent(),
    String? allowedSubjects,
  }) => UserSubscriptionEntity(
    userId: userId ?? this.userId,
    status: status ?? this.status,
    active: active ?? this.active,
    expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
    allowedSubjects: allowedSubjects ?? this.allowedSubjects,
  );
  UserSubscriptionEntity copyWithCompanion(
    UserSubscriptionsTableCompanion data,
  ) {
    return UserSubscriptionEntity(
      userId: data.userId.present ? data.userId.value : this.userId,
      status: data.status.present ? data.status.value : this.status,
      active: data.active.present ? data.active.value : this.active,
      expiryDate: data.expiryDate.present
          ? data.expiryDate.value
          : this.expiryDate,
      allowedSubjects: data.allowedSubjects.present
          ? data.allowedSubjects.value
          : this.allowedSubjects,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSubscriptionEntity(')
          ..write('userId: $userId, ')
          ..write('status: $status, ')
          ..write('active: $active, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('allowedSubjects: $allowedSubjects')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(userId, status, active, expiryDate, allowedSubjects);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSubscriptionEntity &&
          other.userId == this.userId &&
          other.status == this.status &&
          other.active == this.active &&
          other.expiryDate == this.expiryDate &&
          other.allowedSubjects == this.allowedSubjects);
}

class UserSubscriptionsTableCompanion
    extends UpdateCompanion<UserSubscriptionEntity> {
  final Value<String> userId;
  final Value<String> status;
  final Value<bool> active;
  final Value<DateTime?> expiryDate;
  final Value<String> allowedSubjects;
  final Value<int> rowid;
  const UserSubscriptionsTableCompanion({
    this.userId = const Value.absent(),
    this.status = const Value.absent(),
    this.active = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.allowedSubjects = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserSubscriptionsTableCompanion.insert({
    required String userId,
    required String status,
    required bool active,
    this.expiryDate = const Value.absent(),
    required String allowedSubjects,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       status = Value(status),
       active = Value(active),
       allowedSubjects = Value(allowedSubjects);
  static Insertable<UserSubscriptionEntity> custom({
    Expression<String>? userId,
    Expression<String>? status,
    Expression<bool>? active,
    Expression<DateTime>? expiryDate,
    Expression<String>? allowedSubjects,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (status != null) 'status': status,
      if (active != null) 'active': active,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (allowedSubjects != null) 'allowed_subjects': allowedSubjects,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserSubscriptionsTableCompanion copyWith({
    Value<String>? userId,
    Value<String>? status,
    Value<bool>? active,
    Value<DateTime?>? expiryDate,
    Value<String>? allowedSubjects,
    Value<int>? rowid,
  }) {
    return UserSubscriptionsTableCompanion(
      userId: userId ?? this.userId,
      status: status ?? this.status,
      active: active ?? this.active,
      expiryDate: expiryDate ?? this.expiryDate,
      allowedSubjects: allowedSubjects ?? this.allowedSubjects,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    if (allowedSubjects.present) {
      map['allowed_subjects'] = Variable<String>(allowedSubjects.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSubscriptionsTableCompanion(')
          ..write('userId: $userId, ')
          ..write('status: $status, ')
          ..write('active: $active, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('allowedSubjects: $allowedSubjects, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $KeyValueTableTable keyValueTable = $KeyValueTableTable(this);
  late final $TasksTableTable tasksTable = $TasksTableTable(this);
  late final $RecoveryProfilesTableTable recoveryProfilesTable =
      $RecoveryProfilesTableTable(this);
  late final $AvoidedHabitsTableTable avoidedHabitsTable =
      $AvoidedHabitsTableTable(this);
  late final $UrgeLogsTableTable urgeLogsTable = $UrgeLogsTableTable(this);
  late final $DailyRitualsTableTable dailyRitualsTable =
      $DailyRitualsTableTable(this);
  late final $RitualLogsTableTable ritualLogsTable = $RitualLogsTableTable(
    this,
  );
  late final $ProcrastinationLogsTableTable procrastinationLogsTable =
      $ProcrastinationLogsTableTable(this);
  late final $UserSubscriptionsTableTable userSubscriptionsTable =
      $UserSubscriptionsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    keyValueTable,
    tasksTable,
    recoveryProfilesTable,
    avoidedHabitsTable,
    urgeLogsTable,
    dailyRitualsTable,
    ritualLogsTable,
    procrastinationLogsTable,
    userSubscriptionsTable,
  ];
}

typedef $$KeyValueTableTableCreateCompanionBuilder =
    KeyValueTableCompanion Function({
      required String box,
      required String id,
      required String data,
      Value<int> rowid,
    });
typedef $$KeyValueTableTableUpdateCompanionBuilder =
    KeyValueTableCompanion Function({
      Value<String> box,
      Value<String> id,
      Value<String> data,
      Value<int> rowid,
    });

class $$KeyValueTableTableFilterComposer
    extends Composer<_$AppDatabase, $KeyValueTableTable> {
  $$KeyValueTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get box => $composableBuilder(
    column: $table.box,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KeyValueTableTableOrderingComposer
    extends Composer<_$AppDatabase, $KeyValueTableTable> {
  $$KeyValueTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get box => $composableBuilder(
    column: $table.box,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KeyValueTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $KeyValueTableTable> {
  $$KeyValueTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get box =>
      $composableBuilder(column: $table.box, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);
}

class $$KeyValueTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KeyValueTableTable,
          KeyValueEntity,
          $$KeyValueTableTableFilterComposer,
          $$KeyValueTableTableOrderingComposer,
          $$KeyValueTableTableAnnotationComposer,
          $$KeyValueTableTableCreateCompanionBuilder,
          $$KeyValueTableTableUpdateCompanionBuilder,
          (
            KeyValueEntity,
            BaseReferences<_$AppDatabase, $KeyValueTableTable, KeyValueEntity>,
          ),
          KeyValueEntity,
          PrefetchHooks Function()
        > {
  $$KeyValueTableTableTableManager(_$AppDatabase db, $KeyValueTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KeyValueTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KeyValueTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KeyValueTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> box = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> data = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => KeyValueTableCompanion(
                box: box,
                id: id,
                data: data,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String box,
                required String id,
                required String data,
                Value<int> rowid = const Value.absent(),
              }) => KeyValueTableCompanion.insert(
                box: box,
                id: id,
                data: data,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KeyValueTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KeyValueTableTable,
      KeyValueEntity,
      $$KeyValueTableTableFilterComposer,
      $$KeyValueTableTableOrderingComposer,
      $$KeyValueTableTableAnnotationComposer,
      $$KeyValueTableTableCreateCompanionBuilder,
      $$KeyValueTableTableUpdateCompanionBuilder,
      (
        KeyValueEntity,
        BaseReferences<_$AppDatabase, $KeyValueTableTable, KeyValueEntity>,
      ),
      KeyValueEntity,
      PrefetchHooks Function()
    >;
typedef $$TasksTableTableCreateCompanionBuilder =
    TasksTableCompanion Function({
      Value<String> id,
      required String title,
      Value<String?> description,
      Value<bool> isCompleted,
      Value<DateTime?> dueDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> createdBy,
      Value<String?> data,
      Value<int> rowid,
    });
typedef $$TasksTableTableUpdateCompanionBuilder =
    TasksTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> description,
      Value<bool> isCompleted,
      Value<DateTime?> dueDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String?> createdBy,
      Value<String?> data,
      Value<int> rowid,
    });

class $$TasksTableTableFilterComposer
    extends Composer<_$AppDatabase, $TasksTableTable> {
  $$TasksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TasksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTableTable> {
  $$TasksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTableTable> {
  $$TasksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);
}

class $$TasksTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTableTable,
          TaskEntity,
          $$TasksTableTableFilterComposer,
          $$TasksTableTableOrderingComposer,
          $$TasksTableTableAnnotationComposer,
          $$TasksTableTableCreateCompanionBuilder,
          $$TasksTableTableUpdateCompanionBuilder,
          (
            TaskEntity,
            BaseReferences<_$AppDatabase, $TasksTableTable, TaskEntity>,
          ),
          TaskEntity,
          PrefetchHooks Function()
        > {
  $$TasksTableTableTableManager(_$AppDatabase db, $TasksTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> data = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksTableCompanion(
                id: id,
                title: title,
                description: description,
                isCompleted: isCompleted,
                dueDate: dueDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                data: data,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<String?> data = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksTableCompanion.insert(
                id: id,
                title: title,
                description: description,
                isCompleted: isCompleted,
                dueDate: dueDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                createdBy: createdBy,
                data: data,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasksTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTableTable,
      TaskEntity,
      $$TasksTableTableFilterComposer,
      $$TasksTableTableOrderingComposer,
      $$TasksTableTableAnnotationComposer,
      $$TasksTableTableCreateCompanionBuilder,
      $$TasksTableTableUpdateCompanionBuilder,
      (TaskEntity, BaseReferences<_$AppDatabase, $TasksTableTable, TaskEntity>),
      TaskEntity,
      PrefetchHooks Function()
    >;
typedef $$RecoveryProfilesTableTableCreateCompanionBuilder =
    RecoveryProfilesTableCompanion Function({
      Value<String> id,
      required DateTime startDate,
      Value<int> longestStreak,
      Value<int> currentStreak,
      Value<String?> primaryTrigger,
      Value<int> rowid,
    });
typedef $$RecoveryProfilesTableTableUpdateCompanionBuilder =
    RecoveryProfilesTableCompanion Function({
      Value<String> id,
      Value<DateTime> startDate,
      Value<int> longestStreak,
      Value<int> currentStreak,
      Value<String?> primaryTrigger,
      Value<int> rowid,
    });

class $$RecoveryProfilesTableTableFilterComposer
    extends Composer<_$AppDatabase, $RecoveryProfilesTableTable> {
  $$RecoveryProfilesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryTrigger => $composableBuilder(
    column: $table.primaryTrigger,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecoveryProfilesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RecoveryProfilesTableTable> {
  $$RecoveryProfilesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryTrigger => $composableBuilder(
    column: $table.primaryTrigger,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecoveryProfilesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecoveryProfilesTableTable> {
  $$RecoveryProfilesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<int> get longestStreak => $composableBuilder(
    column: $table.longestStreak,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentStreak => $composableBuilder(
    column: $table.currentStreak,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryTrigger => $composableBuilder(
    column: $table.primaryTrigger,
    builder: (column) => column,
  );
}

class $$RecoveryProfilesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecoveryProfilesTableTable,
          RecoveryProfileEntity,
          $$RecoveryProfilesTableTableFilterComposer,
          $$RecoveryProfilesTableTableOrderingComposer,
          $$RecoveryProfilesTableTableAnnotationComposer,
          $$RecoveryProfilesTableTableCreateCompanionBuilder,
          $$RecoveryProfilesTableTableUpdateCompanionBuilder,
          (
            RecoveryProfileEntity,
            BaseReferences<
              _$AppDatabase,
              $RecoveryProfilesTableTable,
              RecoveryProfileEntity
            >,
          ),
          RecoveryProfileEntity,
          PrefetchHooks Function()
        > {
  $$RecoveryProfilesTableTableTableManager(
    _$AppDatabase db,
    $RecoveryProfilesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecoveryProfilesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$RecoveryProfilesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RecoveryProfilesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<int> longestStreak = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<String?> primaryTrigger = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecoveryProfilesTableCompanion(
                id: id,
                startDate: startDate,
                longestStreak: longestStreak,
                currentStreak: currentStreak,
                primaryTrigger: primaryTrigger,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required DateTime startDate,
                Value<int> longestStreak = const Value.absent(),
                Value<int> currentStreak = const Value.absent(),
                Value<String?> primaryTrigger = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecoveryProfilesTableCompanion.insert(
                id: id,
                startDate: startDate,
                longestStreak: longestStreak,
                currentStreak: currentStreak,
                primaryTrigger: primaryTrigger,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecoveryProfilesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecoveryProfilesTableTable,
      RecoveryProfileEntity,
      $$RecoveryProfilesTableTableFilterComposer,
      $$RecoveryProfilesTableTableOrderingComposer,
      $$RecoveryProfilesTableTableAnnotationComposer,
      $$RecoveryProfilesTableTableCreateCompanionBuilder,
      $$RecoveryProfilesTableTableUpdateCompanionBuilder,
      (
        RecoveryProfileEntity,
        BaseReferences<
          _$AppDatabase,
          $RecoveryProfilesTableTable,
          RecoveryProfileEntity
        >,
      ),
      RecoveryProfileEntity,
      PrefetchHooks Function()
    >;
typedef $$AvoidedHabitsTableTableCreateCompanionBuilder =
    AvoidedHabitsTableCompanion Function({
      Value<String> id,
      required String title,
      Value<String?> motivation,
      required DateTime createdDate,
      Value<int> rowid,
    });
typedef $$AvoidedHabitsTableTableUpdateCompanionBuilder =
    AvoidedHabitsTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> motivation,
      Value<DateTime> createdDate,
      Value<int> rowid,
    });

class $$AvoidedHabitsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AvoidedHabitsTableTable> {
  $$AvoidedHabitsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motivation => $composableBuilder(
    column: $table.motivation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdDate => $composableBuilder(
    column: $table.createdDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AvoidedHabitsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AvoidedHabitsTableTable> {
  $$AvoidedHabitsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motivation => $composableBuilder(
    column: $table.motivation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdDate => $composableBuilder(
    column: $table.createdDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AvoidedHabitsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AvoidedHabitsTableTable> {
  $$AvoidedHabitsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get motivation => $composableBuilder(
    column: $table.motivation,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdDate => $composableBuilder(
    column: $table.createdDate,
    builder: (column) => column,
  );
}

class $$AvoidedHabitsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AvoidedHabitsTableTable,
          AvoidedHabitEntity,
          $$AvoidedHabitsTableTableFilterComposer,
          $$AvoidedHabitsTableTableOrderingComposer,
          $$AvoidedHabitsTableTableAnnotationComposer,
          $$AvoidedHabitsTableTableCreateCompanionBuilder,
          $$AvoidedHabitsTableTableUpdateCompanionBuilder,
          (
            AvoidedHabitEntity,
            BaseReferences<
              _$AppDatabase,
              $AvoidedHabitsTableTable,
              AvoidedHabitEntity
            >,
          ),
          AvoidedHabitEntity,
          PrefetchHooks Function()
        > {
  $$AvoidedHabitsTableTableTableManager(
    _$AppDatabase db,
    $AvoidedHabitsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AvoidedHabitsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AvoidedHabitsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AvoidedHabitsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> motivation = const Value.absent(),
                Value<DateTime> createdDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AvoidedHabitsTableCompanion(
                id: id,
                title: title,
                motivation: motivation,
                createdDate: createdDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String title,
                Value<String?> motivation = const Value.absent(),
                required DateTime createdDate,
                Value<int> rowid = const Value.absent(),
              }) => AvoidedHabitsTableCompanion.insert(
                id: id,
                title: title,
                motivation: motivation,
                createdDate: createdDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AvoidedHabitsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AvoidedHabitsTableTable,
      AvoidedHabitEntity,
      $$AvoidedHabitsTableTableFilterComposer,
      $$AvoidedHabitsTableTableOrderingComposer,
      $$AvoidedHabitsTableTableAnnotationComposer,
      $$AvoidedHabitsTableTableCreateCompanionBuilder,
      $$AvoidedHabitsTableTableUpdateCompanionBuilder,
      (
        AvoidedHabitEntity,
        BaseReferences<
          _$AppDatabase,
          $AvoidedHabitsTableTable,
          AvoidedHabitEntity
        >,
      ),
      AvoidedHabitEntity,
      PrefetchHooks Function()
    >;
typedef $$UrgeLogsTableTableCreateCompanionBuilder =
    UrgeLogsTableCompanion Function({
      Value<String> id,
      Value<String?> habitId,
      required DateTime timestamp,
      required int intensity,
      required String triggerType,
      required String outcome,
      Value<String?> reflectionNotes,
      Value<int> rowid,
    });
typedef $$UrgeLogsTableTableUpdateCompanionBuilder =
    UrgeLogsTableCompanion Function({
      Value<String> id,
      Value<String?> habitId,
      Value<DateTime> timestamp,
      Value<int> intensity,
      Value<String> triggerType,
      Value<String> outcome,
      Value<String?> reflectionNotes,
      Value<int> rowid,
    });

class $$UrgeLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $UrgeLogsTableTable> {
  $$UrgeLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get triggerType => $composableBuilder(
    column: $table.triggerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reflectionNotes => $composableBuilder(
    column: $table.reflectionNotes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UrgeLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UrgeLogsTableTable> {
  $$UrgeLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get triggerType => $composableBuilder(
    column: $table.triggerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reflectionNotes => $composableBuilder(
    column: $table.reflectionNotes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UrgeLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UrgeLogsTableTable> {
  $$UrgeLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get intensity =>
      $composableBuilder(column: $table.intensity, builder: (column) => column);

  GeneratedColumn<String> get triggerType => $composableBuilder(
    column: $table.triggerType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<String> get reflectionNotes => $composableBuilder(
    column: $table.reflectionNotes,
    builder: (column) => column,
  );
}

class $$UrgeLogsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UrgeLogsTableTable,
          UrgeLogEntity,
          $$UrgeLogsTableTableFilterComposer,
          $$UrgeLogsTableTableOrderingComposer,
          $$UrgeLogsTableTableAnnotationComposer,
          $$UrgeLogsTableTableCreateCompanionBuilder,
          $$UrgeLogsTableTableUpdateCompanionBuilder,
          (
            UrgeLogEntity,
            BaseReferences<_$AppDatabase, $UrgeLogsTableTable, UrgeLogEntity>,
          ),
          UrgeLogEntity,
          PrefetchHooks Function()
        > {
  $$UrgeLogsTableTableTableManager(_$AppDatabase db, $UrgeLogsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UrgeLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UrgeLogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UrgeLogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> habitId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> intensity = const Value.absent(),
                Value<String> triggerType = const Value.absent(),
                Value<String> outcome = const Value.absent(),
                Value<String?> reflectionNotes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UrgeLogsTableCompanion(
                id: id,
                habitId: habitId,
                timestamp: timestamp,
                intensity: intensity,
                triggerType: triggerType,
                outcome: outcome,
                reflectionNotes: reflectionNotes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> habitId = const Value.absent(),
                required DateTime timestamp,
                required int intensity,
                required String triggerType,
                required String outcome,
                Value<String?> reflectionNotes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UrgeLogsTableCompanion.insert(
                id: id,
                habitId: habitId,
                timestamp: timestamp,
                intensity: intensity,
                triggerType: triggerType,
                outcome: outcome,
                reflectionNotes: reflectionNotes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UrgeLogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UrgeLogsTableTable,
      UrgeLogEntity,
      $$UrgeLogsTableTableFilterComposer,
      $$UrgeLogsTableTableOrderingComposer,
      $$UrgeLogsTableTableAnnotationComposer,
      $$UrgeLogsTableTableCreateCompanionBuilder,
      $$UrgeLogsTableTableUpdateCompanionBuilder,
      (
        UrgeLogEntity,
        BaseReferences<_$AppDatabase, $UrgeLogsTableTable, UrgeLogEntity>,
      ),
      UrgeLogEntity,
      PrefetchHooks Function()
    >;
typedef $$DailyRitualsTableTableCreateCompanionBuilder =
    DailyRitualsTableCompanion Function({
      Value<String> id,
      required String title,
      Value<String?> description,
      required String routineType,
      Value<String> iconEmoji,
      Value<int> targetDurationMinutes,
      Value<int> rowid,
    });
typedef $$DailyRitualsTableTableUpdateCompanionBuilder =
    DailyRitualsTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> description,
      Value<String> routineType,
      Value<String> iconEmoji,
      Value<int> targetDurationMinutes,
      Value<int> rowid,
    });

class $$DailyRitualsTableTableFilterComposer
    extends Composer<_$AppDatabase, $DailyRitualsTableTable> {
  $$DailyRitualsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routineType => $composableBuilder(
    column: $table.routineType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconEmoji => $composableBuilder(
    column: $table.iconEmoji,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetDurationMinutes => $composableBuilder(
    column: $table.targetDurationMinutes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyRitualsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyRitualsTableTable> {
  $$DailyRitualsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routineType => $composableBuilder(
    column: $table.routineType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconEmoji => $composableBuilder(
    column: $table.iconEmoji,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetDurationMinutes => $composableBuilder(
    column: $table.targetDurationMinutes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyRitualsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyRitualsTableTable> {
  $$DailyRitualsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get routineType => $composableBuilder(
    column: $table.routineType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get iconEmoji =>
      $composableBuilder(column: $table.iconEmoji, builder: (column) => column);

  GeneratedColumn<int> get targetDurationMinutes => $composableBuilder(
    column: $table.targetDurationMinutes,
    builder: (column) => column,
  );
}

class $$DailyRitualsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyRitualsTableTable,
          DailyRitualEntity,
          $$DailyRitualsTableTableFilterComposer,
          $$DailyRitualsTableTableOrderingComposer,
          $$DailyRitualsTableTableAnnotationComposer,
          $$DailyRitualsTableTableCreateCompanionBuilder,
          $$DailyRitualsTableTableUpdateCompanionBuilder,
          (
            DailyRitualEntity,
            BaseReferences<
              _$AppDatabase,
              $DailyRitualsTableTable,
              DailyRitualEntity
            >,
          ),
          DailyRitualEntity,
          PrefetchHooks Function()
        > {
  $$DailyRitualsTableTableTableManager(
    _$AppDatabase db,
    $DailyRitualsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyRitualsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyRitualsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyRitualsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> routineType = const Value.absent(),
                Value<String> iconEmoji = const Value.absent(),
                Value<int> targetDurationMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyRitualsTableCompanion(
                id: id,
                title: title,
                description: description,
                routineType: routineType,
                iconEmoji: iconEmoji,
                targetDurationMinutes: targetDurationMinutes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                required String routineType,
                Value<String> iconEmoji = const Value.absent(),
                Value<int> targetDurationMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyRitualsTableCompanion.insert(
                id: id,
                title: title,
                description: description,
                routineType: routineType,
                iconEmoji: iconEmoji,
                targetDurationMinutes: targetDurationMinutes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyRitualsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyRitualsTableTable,
      DailyRitualEntity,
      $$DailyRitualsTableTableFilterComposer,
      $$DailyRitualsTableTableOrderingComposer,
      $$DailyRitualsTableTableAnnotationComposer,
      $$DailyRitualsTableTableCreateCompanionBuilder,
      $$DailyRitualsTableTableUpdateCompanionBuilder,
      (
        DailyRitualEntity,
        BaseReferences<
          _$AppDatabase,
          $DailyRitualsTableTable,
          DailyRitualEntity
        >,
      ),
      DailyRitualEntity,
      PrefetchHooks Function()
    >;
typedef $$RitualLogsTableTableCreateCompanionBuilder =
    RitualLogsTableCompanion Function({
      Value<String> id,
      required String ritualId,
      required DateTime completedAt,
      Value<int> rowid,
    });
typedef $$RitualLogsTableTableUpdateCompanionBuilder =
    RitualLogsTableCompanion Function({
      Value<String> id,
      Value<String> ritualId,
      Value<DateTime> completedAt,
      Value<int> rowid,
    });

class $$RitualLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $RitualLogsTableTable> {
  $$RitualLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ritualId => $composableBuilder(
    column: $table.ritualId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RitualLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RitualLogsTableTable> {
  $$RitualLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ritualId => $composableBuilder(
    column: $table.ritualId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RitualLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RitualLogsTableTable> {
  $$RitualLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ritualId =>
      $composableBuilder(column: $table.ritualId, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$RitualLogsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RitualLogsTableTable,
          RitualLogEntity,
          $$RitualLogsTableTableFilterComposer,
          $$RitualLogsTableTableOrderingComposer,
          $$RitualLogsTableTableAnnotationComposer,
          $$RitualLogsTableTableCreateCompanionBuilder,
          $$RitualLogsTableTableUpdateCompanionBuilder,
          (
            RitualLogEntity,
            BaseReferences<
              _$AppDatabase,
              $RitualLogsTableTable,
              RitualLogEntity
            >,
          ),
          RitualLogEntity,
          PrefetchHooks Function()
        > {
  $$RitualLogsTableTableTableManager(
    _$AppDatabase db,
    $RitualLogsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RitualLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RitualLogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RitualLogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ritualId = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RitualLogsTableCompanion(
                id: id,
                ritualId: ritualId,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String ritualId,
                required DateTime completedAt,
                Value<int> rowid = const Value.absent(),
              }) => RitualLogsTableCompanion.insert(
                id: id,
                ritualId: ritualId,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RitualLogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RitualLogsTableTable,
      RitualLogEntity,
      $$RitualLogsTableTableFilterComposer,
      $$RitualLogsTableTableOrderingComposer,
      $$RitualLogsTableTableAnnotationComposer,
      $$RitualLogsTableTableCreateCompanionBuilder,
      $$RitualLogsTableTableUpdateCompanionBuilder,
      (
        RitualLogEntity,
        BaseReferences<_$AppDatabase, $RitualLogsTableTable, RitualLogEntity>,
      ),
      RitualLogEntity,
      PrefetchHooks Function()
    >;
typedef $$ProcrastinationLogsTableTableCreateCompanionBuilder =
    ProcrastinationLogsTableCompanion Function({
      Value<String> id,
      Value<String?> ritualId,
      required DateTime scheduledTime,
      required DateTime logTime,
      Value<int> delayCount,
      Value<String?> procrastinationReason,
      Value<bool> wasCompletedEventually,
      Value<int> rowid,
    });
typedef $$ProcrastinationLogsTableTableUpdateCompanionBuilder =
    ProcrastinationLogsTableCompanion Function({
      Value<String> id,
      Value<String?> ritualId,
      Value<DateTime> scheduledTime,
      Value<DateTime> logTime,
      Value<int> delayCount,
      Value<String?> procrastinationReason,
      Value<bool> wasCompletedEventually,
      Value<int> rowid,
    });

class $$ProcrastinationLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProcrastinationLogsTableTable> {
  $$ProcrastinationLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ritualId => $composableBuilder(
    column: $table.ritualId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledTime => $composableBuilder(
    column: $table.scheduledTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get logTime => $composableBuilder(
    column: $table.logTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get delayCount => $composableBuilder(
    column: $table.delayCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get procrastinationReason => $composableBuilder(
    column: $table.procrastinationReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get wasCompletedEventually => $composableBuilder(
    column: $table.wasCompletedEventually,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProcrastinationLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProcrastinationLogsTableTable> {
  $$ProcrastinationLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ritualId => $composableBuilder(
    column: $table.ritualId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledTime => $composableBuilder(
    column: $table.scheduledTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get logTime => $composableBuilder(
    column: $table.logTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get delayCount => $composableBuilder(
    column: $table.delayCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get procrastinationReason => $composableBuilder(
    column: $table.procrastinationReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get wasCompletedEventually => $composableBuilder(
    column: $table.wasCompletedEventually,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProcrastinationLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProcrastinationLogsTableTable> {
  $$ProcrastinationLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ritualId =>
      $composableBuilder(column: $table.ritualId, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledTime => $composableBuilder(
    column: $table.scheduledTime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get logTime =>
      $composableBuilder(column: $table.logTime, builder: (column) => column);

  GeneratedColumn<int> get delayCount => $composableBuilder(
    column: $table.delayCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get procrastinationReason => $composableBuilder(
    column: $table.procrastinationReason,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get wasCompletedEventually => $composableBuilder(
    column: $table.wasCompletedEventually,
    builder: (column) => column,
  );
}

class $$ProcrastinationLogsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProcrastinationLogsTableTable,
          ProcrastinationLogEntity,
          $$ProcrastinationLogsTableTableFilterComposer,
          $$ProcrastinationLogsTableTableOrderingComposer,
          $$ProcrastinationLogsTableTableAnnotationComposer,
          $$ProcrastinationLogsTableTableCreateCompanionBuilder,
          $$ProcrastinationLogsTableTableUpdateCompanionBuilder,
          (
            ProcrastinationLogEntity,
            BaseReferences<
              _$AppDatabase,
              $ProcrastinationLogsTableTable,
              ProcrastinationLogEntity
            >,
          ),
          ProcrastinationLogEntity,
          PrefetchHooks Function()
        > {
  $$ProcrastinationLogsTableTableTableManager(
    _$AppDatabase db,
    $ProcrastinationLogsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProcrastinationLogsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ProcrastinationLogsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ProcrastinationLogsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> ritualId = const Value.absent(),
                Value<DateTime> scheduledTime = const Value.absent(),
                Value<DateTime> logTime = const Value.absent(),
                Value<int> delayCount = const Value.absent(),
                Value<String?> procrastinationReason = const Value.absent(),
                Value<bool> wasCompletedEventually = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProcrastinationLogsTableCompanion(
                id: id,
                ritualId: ritualId,
                scheduledTime: scheduledTime,
                logTime: logTime,
                delayCount: delayCount,
                procrastinationReason: procrastinationReason,
                wasCompletedEventually: wasCompletedEventually,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> ritualId = const Value.absent(),
                required DateTime scheduledTime,
                required DateTime logTime,
                Value<int> delayCount = const Value.absent(),
                Value<String?> procrastinationReason = const Value.absent(),
                Value<bool> wasCompletedEventually = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProcrastinationLogsTableCompanion.insert(
                id: id,
                ritualId: ritualId,
                scheduledTime: scheduledTime,
                logTime: logTime,
                delayCount: delayCount,
                procrastinationReason: procrastinationReason,
                wasCompletedEventually: wasCompletedEventually,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProcrastinationLogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProcrastinationLogsTableTable,
      ProcrastinationLogEntity,
      $$ProcrastinationLogsTableTableFilterComposer,
      $$ProcrastinationLogsTableTableOrderingComposer,
      $$ProcrastinationLogsTableTableAnnotationComposer,
      $$ProcrastinationLogsTableTableCreateCompanionBuilder,
      $$ProcrastinationLogsTableTableUpdateCompanionBuilder,
      (
        ProcrastinationLogEntity,
        BaseReferences<
          _$AppDatabase,
          $ProcrastinationLogsTableTable,
          ProcrastinationLogEntity
        >,
      ),
      ProcrastinationLogEntity,
      PrefetchHooks Function()
    >;
typedef $$UserSubscriptionsTableTableCreateCompanionBuilder =
    UserSubscriptionsTableCompanion Function({
      required String userId,
      required String status,
      required bool active,
      Value<DateTime?> expiryDate,
      required String allowedSubjects,
      Value<int> rowid,
    });
typedef $$UserSubscriptionsTableTableUpdateCompanionBuilder =
    UserSubscriptionsTableCompanion Function({
      Value<String> userId,
      Value<String> status,
      Value<bool> active,
      Value<DateTime?> expiryDate,
      Value<String> allowedSubjects,
      Value<int> rowid,
    });

class $$UserSubscriptionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $UserSubscriptionsTableTable> {
  $$UserSubscriptionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allowedSubjects => $composableBuilder(
    column: $table.allowedSubjects,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserSubscriptionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSubscriptionsTableTable> {
  $$UserSubscriptionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allowedSubjects => $composableBuilder(
    column: $table.allowedSubjects,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserSubscriptionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSubscriptionsTableTable> {
  $$UserSubscriptionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get expiryDate => $composableBuilder(
    column: $table.expiryDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get allowedSubjects => $composableBuilder(
    column: $table.allowedSubjects,
    builder: (column) => column,
  );
}

class $$UserSubscriptionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserSubscriptionsTableTable,
          UserSubscriptionEntity,
          $$UserSubscriptionsTableTableFilterComposer,
          $$UserSubscriptionsTableTableOrderingComposer,
          $$UserSubscriptionsTableTableAnnotationComposer,
          $$UserSubscriptionsTableTableCreateCompanionBuilder,
          $$UserSubscriptionsTableTableUpdateCompanionBuilder,
          (
            UserSubscriptionEntity,
            BaseReferences<
              _$AppDatabase,
              $UserSubscriptionsTableTable,
              UserSubscriptionEntity
            >,
          ),
          UserSubscriptionEntity,
          PrefetchHooks Function()
        > {
  $$UserSubscriptionsTableTableTableManager(
    _$AppDatabase db,
    $UserSubscriptionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSubscriptionsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$UserSubscriptionsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$UserSubscriptionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime?> expiryDate = const Value.absent(),
                Value<String> allowedSubjects = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserSubscriptionsTableCompanion(
                userId: userId,
                status: status,
                active: active,
                expiryDate: expiryDate,
                allowedSubjects: allowedSubjects,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String status,
                required bool active,
                Value<DateTime?> expiryDate = const Value.absent(),
                required String allowedSubjects,
                Value<int> rowid = const Value.absent(),
              }) => UserSubscriptionsTableCompanion.insert(
                userId: userId,
                status: status,
                active: active,
                expiryDate: expiryDate,
                allowedSubjects: allowedSubjects,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserSubscriptionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserSubscriptionsTableTable,
      UserSubscriptionEntity,
      $$UserSubscriptionsTableTableFilterComposer,
      $$UserSubscriptionsTableTableOrderingComposer,
      $$UserSubscriptionsTableTableAnnotationComposer,
      $$UserSubscriptionsTableTableCreateCompanionBuilder,
      $$UserSubscriptionsTableTableUpdateCompanionBuilder,
      (
        UserSubscriptionEntity,
        BaseReferences<
          _$AppDatabase,
          $UserSubscriptionsTableTable,
          UserSubscriptionEntity
        >,
      ),
      UserSubscriptionEntity,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$KeyValueTableTableTableManager get keyValueTable =>
      $$KeyValueTableTableTableManager(_db, _db.keyValueTable);
  $$TasksTableTableTableManager get tasksTable =>
      $$TasksTableTableTableManager(_db, _db.tasksTable);
  $$RecoveryProfilesTableTableTableManager get recoveryProfilesTable =>
      $$RecoveryProfilesTableTableTableManager(_db, _db.recoveryProfilesTable);
  $$AvoidedHabitsTableTableTableManager get avoidedHabitsTable =>
      $$AvoidedHabitsTableTableTableManager(_db, _db.avoidedHabitsTable);
  $$UrgeLogsTableTableTableManager get urgeLogsTable =>
      $$UrgeLogsTableTableTableManager(_db, _db.urgeLogsTable);
  $$DailyRitualsTableTableTableManager get dailyRitualsTable =>
      $$DailyRitualsTableTableTableManager(_db, _db.dailyRitualsTable);
  $$RitualLogsTableTableTableManager get ritualLogsTable =>
      $$RitualLogsTableTableTableManager(_db, _db.ritualLogsTable);
  $$ProcrastinationLogsTableTableTableManager get procrastinationLogsTable =>
      $$ProcrastinationLogsTableTableTableManager(
        _db,
        _db.procrastinationLogsTable,
      );
  $$UserSubscriptionsTableTableTableManager get userSubscriptionsTable =>
      $$UserSubscriptionsTableTableTableManager(
        _db,
        _db.userSubscriptionsTable,
      );
}
