// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
    'year',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2026),
  );
  static const VerificationMeta _varietyMeta = const VerificationMeta(
    'variety',
  );
  @override
  late final GeneratedColumn<String> variety = GeneratedColumn<String>(
    'variety',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('甘露'),
  );
  static const VerificationMeta _wageGraftMeta = const VerificationMeta(
    'wageGraft',
  );
  @override
  late final GeneratedColumn<double> wageGraft = GeneratedColumn<double>(
    'wage_graft',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wageBagMeta = const VerificationMeta(
    'wageBag',
  );
  @override
  late final GeneratedColumn<double> wageBag = GeneratedColumn<double>(
    'wage_bag',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _budgetLimitMeta = const VerificationMeta(
    'budgetLimit',
  );
  @override
  late final GeneratedColumn<double> budgetLimit = GeneratedColumn<double>(
    'budget_limit',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _budgetAlertEnabledMeta =
      const VerificationMeta('budgetAlertEnabled');
  @override
  late final GeneratedColumn<bool> budgetAlertEnabled = GeneratedColumn<bool>(
    'budget_alert_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("budget_alert_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _budgetAlertThresholdMeta =
      const VerificationMeta('budgetAlertThreshold');
  @override
  late final GeneratedColumn<double> budgetAlertThreshold =
      GeneratedColumn<double>(
        'budget_alert_threshold',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.8),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    year,
    variety,
    wageGraft,
    wageBag,
    budgetLimit,
    budgetAlertEnabled,
    budgetAlertThreshold,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Project> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('year')) {
      context.handle(
        _yearMeta,
        year.isAcceptableOrUnknown(data['year']!, _yearMeta),
      );
    }
    if (data.containsKey('variety')) {
      context.handle(
        _varietyMeta,
        variety.isAcceptableOrUnknown(data['variety']!, _varietyMeta),
      );
    }
    if (data.containsKey('wage_graft')) {
      context.handle(
        _wageGraftMeta,
        wageGraft.isAcceptableOrUnknown(data['wage_graft']!, _wageGraftMeta),
      );
    } else if (isInserting) {
      context.missing(_wageGraftMeta);
    }
    if (data.containsKey('wage_bag')) {
      context.handle(
        _wageBagMeta,
        wageBag.isAcceptableOrUnknown(data['wage_bag']!, _wageBagMeta),
      );
    } else if (isInserting) {
      context.missing(_wageBagMeta);
    }
    if (data.containsKey('budget_limit')) {
      context.handle(
        _budgetLimitMeta,
        budgetLimit.isAcceptableOrUnknown(
          data['budget_limit']!,
          _budgetLimitMeta,
        ),
      );
    }
    if (data.containsKey('budget_alert_enabled')) {
      context.handle(
        _budgetAlertEnabledMeta,
        budgetAlertEnabled.isAcceptableOrUnknown(
          data['budget_alert_enabled']!,
          _budgetAlertEnabledMeta,
        ),
      );
    }
    if (data.containsKey('budget_alert_threshold')) {
      context.handle(
        _budgetAlertThresholdMeta,
        budgetAlertThreshold.isAcceptableOrUnknown(
          data['budget_alert_threshold']!,
          _budgetAlertThresholdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      year: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}year'],
      )!,
      variety: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variety'],
      )!,
      wageGraft: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wage_graft'],
      )!,
      wageBag: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}wage_bag'],
      )!,
      budgetLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}budget_limit'],
      ),
      budgetAlertEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}budget_alert_enabled'],
      )!,
      budgetAlertThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}budget_alert_threshold'],
      )!,
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }
}

class Project extends DataClass implements Insertable<Project> {
  final int id;
  final int year;
  final String variety;
  final double wageGraft;
  final double wageBag;
  final double? budgetLimit;
  final bool budgetAlertEnabled;
  final double budgetAlertThreshold;
  const Project({
    required this.id,
    required this.year,
    required this.variety,
    required this.wageGraft,
    required this.wageBag,
    this.budgetLimit,
    required this.budgetAlertEnabled,
    required this.budgetAlertThreshold,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['year'] = Variable<int>(year);
    map['variety'] = Variable<String>(variety);
    map['wage_graft'] = Variable<double>(wageGraft);
    map['wage_bag'] = Variable<double>(wageBag);
    if (!nullToAbsent || budgetLimit != null) {
      map['budget_limit'] = Variable<double>(budgetLimit);
    }
    map['budget_alert_enabled'] = Variable<bool>(budgetAlertEnabled);
    map['budget_alert_threshold'] = Variable<double>(budgetAlertThreshold);
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      year: Value(year),
      variety: Value(variety),
      wageGraft: Value(wageGraft),
      wageBag: Value(wageBag),
      budgetLimit: budgetLimit == null && nullToAbsent
          ? const Value.absent()
          : Value(budgetLimit),
      budgetAlertEnabled: Value(budgetAlertEnabled),
      budgetAlertThreshold: Value(budgetAlertThreshold),
    );
  }

  factory Project.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<int>(json['id']),
      year: serializer.fromJson<int>(json['year']),
      variety: serializer.fromJson<String>(json['variety']),
      wageGraft: serializer.fromJson<double>(json['wageGraft']),
      wageBag: serializer.fromJson<double>(json['wageBag']),
      budgetLimit: serializer.fromJson<double?>(json['budgetLimit']),
      budgetAlertEnabled: serializer.fromJson<bool>(json['budgetAlertEnabled']),
      budgetAlertThreshold: serializer.fromJson<double>(
        json['budgetAlertThreshold'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'year': serializer.toJson<int>(year),
      'variety': serializer.toJson<String>(variety),
      'wageGraft': serializer.toJson<double>(wageGraft),
      'wageBag': serializer.toJson<double>(wageBag),
      'budgetLimit': serializer.toJson<double?>(budgetLimit),
      'budgetAlertEnabled': serializer.toJson<bool>(budgetAlertEnabled),
      'budgetAlertThreshold': serializer.toJson<double>(budgetAlertThreshold),
    };
  }

  Project copyWith({
    int? id,
    int? year,
    String? variety,
    double? wageGraft,
    double? wageBag,
    Value<double?> budgetLimit = const Value.absent(),
    bool? budgetAlertEnabled,
    double? budgetAlertThreshold,
  }) => Project(
    id: id ?? this.id,
    year: year ?? this.year,
    variety: variety ?? this.variety,
    wageGraft: wageGraft ?? this.wageGraft,
    wageBag: wageBag ?? this.wageBag,
    budgetLimit: budgetLimit.present ? budgetLimit.value : this.budgetLimit,
    budgetAlertEnabled: budgetAlertEnabled ?? this.budgetAlertEnabled,
    budgetAlertThreshold: budgetAlertThreshold ?? this.budgetAlertThreshold,
  );
  Project copyWithCompanion(ProjectsCompanion data) {
    return Project(
      id: data.id.present ? data.id.value : this.id,
      year: data.year.present ? data.year.value : this.year,
      variety: data.variety.present ? data.variety.value : this.variety,
      wageGraft: data.wageGraft.present ? data.wageGraft.value : this.wageGraft,
      wageBag: data.wageBag.present ? data.wageBag.value : this.wageBag,
      budgetLimit: data.budgetLimit.present
          ? data.budgetLimit.value
          : this.budgetLimit,
      budgetAlertEnabled: data.budgetAlertEnabled.present
          ? data.budgetAlertEnabled.value
          : this.budgetAlertEnabled,
      budgetAlertThreshold: data.budgetAlertThreshold.present
          ? data.budgetAlertThreshold.value
          : this.budgetAlertThreshold,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('variety: $variety, ')
          ..write('wageGraft: $wageGraft, ')
          ..write('wageBag: $wageBag, ')
          ..write('budgetLimit: $budgetLimit, ')
          ..write('budgetAlertEnabled: $budgetAlertEnabled, ')
          ..write('budgetAlertThreshold: $budgetAlertThreshold')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    year,
    variety,
    wageGraft,
    wageBag,
    budgetLimit,
    budgetAlertEnabled,
    budgetAlertThreshold,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.year == this.year &&
          other.variety == this.variety &&
          other.wageGraft == this.wageGraft &&
          other.wageBag == this.wageBag &&
          other.budgetLimit == this.budgetLimit &&
          other.budgetAlertEnabled == this.budgetAlertEnabled &&
          other.budgetAlertThreshold == this.budgetAlertThreshold);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<int> id;
  final Value<int> year;
  final Value<String> variety;
  final Value<double> wageGraft;
  final Value<double> wageBag;
  final Value<double?> budgetLimit;
  final Value<bool> budgetAlertEnabled;
  final Value<double> budgetAlertThreshold;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.year = const Value.absent(),
    this.variety = const Value.absent(),
    this.wageGraft = const Value.absent(),
    this.wageBag = const Value.absent(),
    this.budgetLimit = const Value.absent(),
    this.budgetAlertEnabled = const Value.absent(),
    this.budgetAlertThreshold = const Value.absent(),
  });
  ProjectsCompanion.insert({
    this.id = const Value.absent(),
    this.year = const Value.absent(),
    this.variety = const Value.absent(),
    required double wageGraft,
    required double wageBag,
    this.budgetLimit = const Value.absent(),
    this.budgetAlertEnabled = const Value.absent(),
    this.budgetAlertThreshold = const Value.absent(),
  }) : wageGraft = Value(wageGraft),
       wageBag = Value(wageBag);
  static Insertable<Project> custom({
    Expression<int>? id,
    Expression<int>? year,
    Expression<String>? variety,
    Expression<double>? wageGraft,
    Expression<double>? wageBag,
    Expression<double>? budgetLimit,
    Expression<bool>? budgetAlertEnabled,
    Expression<double>? budgetAlertThreshold,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (year != null) 'year': year,
      if (variety != null) 'variety': variety,
      if (wageGraft != null) 'wage_graft': wageGraft,
      if (wageBag != null) 'wage_bag': wageBag,
      if (budgetLimit != null) 'budget_limit': budgetLimit,
      if (budgetAlertEnabled != null)
        'budget_alert_enabled': budgetAlertEnabled,
      if (budgetAlertThreshold != null)
        'budget_alert_threshold': budgetAlertThreshold,
    });
  }

  ProjectsCompanion copyWith({
    Value<int>? id,
    Value<int>? year,
    Value<String>? variety,
    Value<double>? wageGraft,
    Value<double>? wageBag,
    Value<double?>? budgetLimit,
    Value<bool>? budgetAlertEnabled,
    Value<double>? budgetAlertThreshold,
  }) {
    return ProjectsCompanion(
      id: id ?? this.id,
      year: year ?? this.year,
      variety: variety ?? this.variety,
      wageGraft: wageGraft ?? this.wageGraft,
      wageBag: wageBag ?? this.wageBag,
      budgetLimit: budgetLimit ?? this.budgetLimit,
      budgetAlertEnabled: budgetAlertEnabled ?? this.budgetAlertEnabled,
      budgetAlertThreshold: budgetAlertThreshold ?? this.budgetAlertThreshold,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (variety.present) {
      map['variety'] = Variable<String>(variety.value);
    }
    if (wageGraft.present) {
      map['wage_graft'] = Variable<double>(wageGraft.value);
    }
    if (wageBag.present) {
      map['wage_bag'] = Variable<double>(wageBag.value);
    }
    if (budgetLimit.present) {
      map['budget_limit'] = Variable<double>(budgetLimit.value);
    }
    if (budgetAlertEnabled.present) {
      map['budget_alert_enabled'] = Variable<bool>(budgetAlertEnabled.value);
    }
    if (budgetAlertThreshold.present) {
      map['budget_alert_threshold'] = Variable<double>(
        budgetAlertThreshold.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('variety: $variety, ')
          ..write('wageGraft: $wageGraft, ')
          ..write('wageBag: $wageBag, ')
          ..write('budgetLimit: $budgetLimit, ')
          ..write('budgetAlertEnabled: $budgetAlertEnabled, ')
          ..write('budgetAlertThreshold: $budgetAlertThreshold')
          ..write(')'))
        .toString();
  }
}

class $DailyLogsTable extends DailyLogs
    with TableInfo<$DailyLogsTable, DailyLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayNumberMeta = const VerificationMeta(
    'dayNumber',
  );
  @override
  late final GeneratedColumn<int> dayNumber = GeneratedColumn<int>(
    'day_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<String> area = GeneratedColumn<String>(
    'area',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weatherMeta = const VerificationMeta(
    'weather',
  );
  @override
  late final GeneratedColumn<String> weather = GeneratedColumn<String>(
    'weather',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scionBatchIdMeta = const VerificationMeta(
    'scionBatchId',
  );
  @override
  late final GeneratedColumn<int> scionBatchId = GeneratedColumn<int>(
    'scion_batch_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _graftingCountMeta = const VerificationMeta(
    'graftingCount',
  );
  @override
  late final GeneratedColumn<int> graftingCount = GeneratedColumn<int>(
    'grafting_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _baggingCountMeta = const VerificationMeta(
    'baggingCount',
  );
  @override
  late final GeneratedColumn<int> baggingCount = GeneratedColumn<int>(
    'bagging_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _laborCostMeta = const VerificationMeta(
    'laborCost',
  );
  @override
  late final GeneratedColumn<double> laborCost = GeneratedColumn<double>(
    'labor_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _materialCostMeta = const VerificationMeta(
    'materialCost',
  );
  @override
  late final GeneratedColumn<double> materialCost = GeneratedColumn<double>(
    'material_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _totalCostMeta = const VerificationMeta(
    'totalCost',
  );
  @override
  late final GeneratedColumn<double> totalCost = GeneratedColumn<double>(
    'total_cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _materialNotesMeta = const VerificationMeta(
    'materialNotes',
  );
  @override
  late final GeneratedColumn<String> materialNotes = GeneratedColumn<String>(
    'material_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _importanceLevelMeta = const VerificationMeta(
    'importanceLevel',
  );
  @override
  late final GeneratedColumn<int> importanceLevel = GeneratedColumn<int>(
    'importance_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    date,
    dayNumber,
    area,
    weather,
    scionBatchId,
    graftingCount,
    baggingCount,
    laborCost,
    materialCost,
    totalCost,
    materialNotes,
    notes,
    importanceLevel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('day_number')) {
      context.handle(
        _dayNumberMeta,
        dayNumber.isAcceptableOrUnknown(data['day_number']!, _dayNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_dayNumberMeta);
    }
    if (data.containsKey('area')) {
      context.handle(
        _areaMeta,
        area.isAcceptableOrUnknown(data['area']!, _areaMeta),
      );
    } else if (isInserting) {
      context.missing(_areaMeta);
    }
    if (data.containsKey('weather')) {
      context.handle(
        _weatherMeta,
        weather.isAcceptableOrUnknown(data['weather']!, _weatherMeta),
      );
    } else if (isInserting) {
      context.missing(_weatherMeta);
    }
    if (data.containsKey('scion_batch_id')) {
      context.handle(
        _scionBatchIdMeta,
        scionBatchId.isAcceptableOrUnknown(
          data['scion_batch_id']!,
          _scionBatchIdMeta,
        ),
      );
    }
    if (data.containsKey('grafting_count')) {
      context.handle(
        _graftingCountMeta,
        graftingCount.isAcceptableOrUnknown(
          data['grafting_count']!,
          _graftingCountMeta,
        ),
      );
    }
    if (data.containsKey('bagging_count')) {
      context.handle(
        _baggingCountMeta,
        baggingCount.isAcceptableOrUnknown(
          data['bagging_count']!,
          _baggingCountMeta,
        ),
      );
    }
    if (data.containsKey('labor_cost')) {
      context.handle(
        _laborCostMeta,
        laborCost.isAcceptableOrUnknown(data['labor_cost']!, _laborCostMeta),
      );
    }
    if (data.containsKey('material_cost')) {
      context.handle(
        _materialCostMeta,
        materialCost.isAcceptableOrUnknown(
          data['material_cost']!,
          _materialCostMeta,
        ),
      );
    }
    if (data.containsKey('total_cost')) {
      context.handle(
        _totalCostMeta,
        totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta),
      );
    }
    if (data.containsKey('material_notes')) {
      context.handle(
        _materialNotesMeta,
        materialNotes.isAcceptableOrUnknown(
          data['material_notes']!,
          _materialNotesMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('importance_level')) {
      context.handle(
        _importanceLevelMeta,
        importanceLevel.isAcceptableOrUnknown(
          data['importance_level']!,
          _importanceLevelMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}project_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      dayNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_number'],
      )!,
      area: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}area'],
      )!,
      weather: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weather'],
      )!,
      scionBatchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scion_batch_id'],
      ),
      graftingCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grafting_count'],
      )!,
      baggingCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bagging_count'],
      )!,
      laborCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}labor_cost'],
      )!,
      materialCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}material_cost'],
      )!,
      totalCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_cost'],
      )!,
      materialNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}material_notes'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      importanceLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}importance_level'],
      )!,
    );
  }

  @override
  $DailyLogsTable createAlias(String alias) {
    return $DailyLogsTable(attachedDatabase, alias);
  }
}

class DailyLog extends DataClass implements Insertable<DailyLog> {
  final int id;
  final int projectId;
  final DateTime date;
  final int dayNumber;
  final String area;
  final String weather;
  final int? scionBatchId;
  final int graftingCount;
  final int baggingCount;
  final double laborCost;
  final double materialCost;
  final double totalCost;
  final String? materialNotes;
  final String? notes;
  final int importanceLevel;
  const DailyLog({
    required this.id,
    required this.projectId,
    required this.date,
    required this.dayNumber,
    required this.area,
    required this.weather,
    this.scionBatchId,
    required this.graftingCount,
    required this.baggingCount,
    required this.laborCost,
    required this.materialCost,
    required this.totalCost,
    this.materialNotes,
    this.notes,
    required this.importanceLevel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['project_id'] = Variable<int>(projectId);
    map['date'] = Variable<DateTime>(date);
    map['day_number'] = Variable<int>(dayNumber);
    map['area'] = Variable<String>(area);
    map['weather'] = Variable<String>(weather);
    if (!nullToAbsent || scionBatchId != null) {
      map['scion_batch_id'] = Variable<int>(scionBatchId);
    }
    map['grafting_count'] = Variable<int>(graftingCount);
    map['bagging_count'] = Variable<int>(baggingCount);
    map['labor_cost'] = Variable<double>(laborCost);
    map['material_cost'] = Variable<double>(materialCost);
    map['total_cost'] = Variable<double>(totalCost);
    if (!nullToAbsent || materialNotes != null) {
      map['material_notes'] = Variable<String>(materialNotes);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['importance_level'] = Variable<int>(importanceLevel);
    return map;
  }

  DailyLogsCompanion toCompanion(bool nullToAbsent) {
    return DailyLogsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      date: Value(date),
      dayNumber: Value(dayNumber),
      area: Value(area),
      weather: Value(weather),
      scionBatchId: scionBatchId == null && nullToAbsent
          ? const Value.absent()
          : Value(scionBatchId),
      graftingCount: Value(graftingCount),
      baggingCount: Value(baggingCount),
      laborCost: Value(laborCost),
      materialCost: Value(materialCost),
      totalCost: Value(totalCost),
      materialNotes: materialNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(materialNotes),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      importanceLevel: Value(importanceLevel),
    );
  }

  factory DailyLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyLog(
      id: serializer.fromJson<int>(json['id']),
      projectId: serializer.fromJson<int>(json['projectId']),
      date: serializer.fromJson<DateTime>(json['date']),
      dayNumber: serializer.fromJson<int>(json['dayNumber']),
      area: serializer.fromJson<String>(json['area']),
      weather: serializer.fromJson<String>(json['weather']),
      scionBatchId: serializer.fromJson<int?>(json['scionBatchId']),
      graftingCount: serializer.fromJson<int>(json['graftingCount']),
      baggingCount: serializer.fromJson<int>(json['baggingCount']),
      laborCost: serializer.fromJson<double>(json['laborCost']),
      materialCost: serializer.fromJson<double>(json['materialCost']),
      totalCost: serializer.fromJson<double>(json['totalCost']),
      materialNotes: serializer.fromJson<String?>(json['materialNotes']),
      notes: serializer.fromJson<String?>(json['notes']),
      importanceLevel: serializer.fromJson<int>(json['importanceLevel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectId': serializer.toJson<int>(projectId),
      'date': serializer.toJson<DateTime>(date),
      'dayNumber': serializer.toJson<int>(dayNumber),
      'area': serializer.toJson<String>(area),
      'weather': serializer.toJson<String>(weather),
      'scionBatchId': serializer.toJson<int?>(scionBatchId),
      'graftingCount': serializer.toJson<int>(graftingCount),
      'baggingCount': serializer.toJson<int>(baggingCount),
      'laborCost': serializer.toJson<double>(laborCost),
      'materialCost': serializer.toJson<double>(materialCost),
      'totalCost': serializer.toJson<double>(totalCost),
      'materialNotes': serializer.toJson<String?>(materialNotes),
      'notes': serializer.toJson<String?>(notes),
      'importanceLevel': serializer.toJson<int>(importanceLevel),
    };
  }

  DailyLog copyWith({
    int? id,
    int? projectId,
    DateTime? date,
    int? dayNumber,
    String? area,
    String? weather,
    Value<int?> scionBatchId = const Value.absent(),
    int? graftingCount,
    int? baggingCount,
    double? laborCost,
    double? materialCost,
    double? totalCost,
    Value<String?> materialNotes = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    int? importanceLevel,
  }) => DailyLog(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    date: date ?? this.date,
    dayNumber: dayNumber ?? this.dayNumber,
    area: area ?? this.area,
    weather: weather ?? this.weather,
    scionBatchId: scionBatchId.present ? scionBatchId.value : this.scionBatchId,
    graftingCount: graftingCount ?? this.graftingCount,
    baggingCount: baggingCount ?? this.baggingCount,
    laborCost: laborCost ?? this.laborCost,
    materialCost: materialCost ?? this.materialCost,
    totalCost: totalCost ?? this.totalCost,
    materialNotes: materialNotes.present
        ? materialNotes.value
        : this.materialNotes,
    notes: notes.present ? notes.value : this.notes,
    importanceLevel: importanceLevel ?? this.importanceLevel,
  );
  DailyLog copyWithCompanion(DailyLogsCompanion data) {
    return DailyLog(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      date: data.date.present ? data.date.value : this.date,
      dayNumber: data.dayNumber.present ? data.dayNumber.value : this.dayNumber,
      area: data.area.present ? data.area.value : this.area,
      weather: data.weather.present ? data.weather.value : this.weather,
      scionBatchId: data.scionBatchId.present
          ? data.scionBatchId.value
          : this.scionBatchId,
      graftingCount: data.graftingCount.present
          ? data.graftingCount.value
          : this.graftingCount,
      baggingCount: data.baggingCount.present
          ? data.baggingCount.value
          : this.baggingCount,
      laborCost: data.laborCost.present ? data.laborCost.value : this.laborCost,
      materialCost: data.materialCost.present
          ? data.materialCost.value
          : this.materialCost,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
      materialNotes: data.materialNotes.present
          ? data.materialNotes.value
          : this.materialNotes,
      notes: data.notes.present ? data.notes.value : this.notes,
      importanceLevel: data.importanceLevel.present
          ? data.importanceLevel.value
          : this.importanceLevel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyLog(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('date: $date, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('area: $area, ')
          ..write('weather: $weather, ')
          ..write('scionBatchId: $scionBatchId, ')
          ..write('graftingCount: $graftingCount, ')
          ..write('baggingCount: $baggingCount, ')
          ..write('laborCost: $laborCost, ')
          ..write('materialCost: $materialCost, ')
          ..write('totalCost: $totalCost, ')
          ..write('materialNotes: $materialNotes, ')
          ..write('notes: $notes, ')
          ..write('importanceLevel: $importanceLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    date,
    dayNumber,
    area,
    weather,
    scionBatchId,
    graftingCount,
    baggingCount,
    laborCost,
    materialCost,
    totalCost,
    materialNotes,
    notes,
    importanceLevel,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyLog &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.date == this.date &&
          other.dayNumber == this.dayNumber &&
          other.area == this.area &&
          other.weather == this.weather &&
          other.scionBatchId == this.scionBatchId &&
          other.graftingCount == this.graftingCount &&
          other.baggingCount == this.baggingCount &&
          other.laborCost == this.laborCost &&
          other.materialCost == this.materialCost &&
          other.totalCost == this.totalCost &&
          other.materialNotes == this.materialNotes &&
          other.notes == this.notes &&
          other.importanceLevel == this.importanceLevel);
}

class DailyLogsCompanion extends UpdateCompanion<DailyLog> {
  final Value<int> id;
  final Value<int> projectId;
  final Value<DateTime> date;
  final Value<int> dayNumber;
  final Value<String> area;
  final Value<String> weather;
  final Value<int?> scionBatchId;
  final Value<int> graftingCount;
  final Value<int> baggingCount;
  final Value<double> laborCost;
  final Value<double> materialCost;
  final Value<double> totalCost;
  final Value<String?> materialNotes;
  final Value<String?> notes;
  final Value<int> importanceLevel;
  const DailyLogsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.date = const Value.absent(),
    this.dayNumber = const Value.absent(),
    this.area = const Value.absent(),
    this.weather = const Value.absent(),
    this.scionBatchId = const Value.absent(),
    this.graftingCount = const Value.absent(),
    this.baggingCount = const Value.absent(),
    this.laborCost = const Value.absent(),
    this.materialCost = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.materialNotes = const Value.absent(),
    this.notes = const Value.absent(),
    this.importanceLevel = const Value.absent(),
  });
  DailyLogsCompanion.insert({
    this.id = const Value.absent(),
    required int projectId,
    required DateTime date,
    required int dayNumber,
    required String area,
    required String weather,
    this.scionBatchId = const Value.absent(),
    this.graftingCount = const Value.absent(),
    this.baggingCount = const Value.absent(),
    this.laborCost = const Value.absent(),
    this.materialCost = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.materialNotes = const Value.absent(),
    this.notes = const Value.absent(),
    this.importanceLevel = const Value.absent(),
  }) : projectId = Value(projectId),
       date = Value(date),
       dayNumber = Value(dayNumber),
       area = Value(area),
       weather = Value(weather);
  static Insertable<DailyLog> custom({
    Expression<int>? id,
    Expression<int>? projectId,
    Expression<DateTime>? date,
    Expression<int>? dayNumber,
    Expression<String>? area,
    Expression<String>? weather,
    Expression<int>? scionBatchId,
    Expression<int>? graftingCount,
    Expression<int>? baggingCount,
    Expression<double>? laborCost,
    Expression<double>? materialCost,
    Expression<double>? totalCost,
    Expression<String>? materialNotes,
    Expression<String>? notes,
    Expression<int>? importanceLevel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (date != null) 'date': date,
      if (dayNumber != null) 'day_number': dayNumber,
      if (area != null) 'area': area,
      if (weather != null) 'weather': weather,
      if (scionBatchId != null) 'scion_batch_id': scionBatchId,
      if (graftingCount != null) 'grafting_count': graftingCount,
      if (baggingCount != null) 'bagging_count': baggingCount,
      if (laborCost != null) 'labor_cost': laborCost,
      if (materialCost != null) 'material_cost': materialCost,
      if (totalCost != null) 'total_cost': totalCost,
      if (materialNotes != null) 'material_notes': materialNotes,
      if (notes != null) 'notes': notes,
      if (importanceLevel != null) 'importance_level': importanceLevel,
    });
  }

  DailyLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? projectId,
    Value<DateTime>? date,
    Value<int>? dayNumber,
    Value<String>? area,
    Value<String>? weather,
    Value<int?>? scionBatchId,
    Value<int>? graftingCount,
    Value<int>? baggingCount,
    Value<double>? laborCost,
    Value<double>? materialCost,
    Value<double>? totalCost,
    Value<String?>? materialNotes,
    Value<String?>? notes,
    Value<int>? importanceLevel,
  }) {
    return DailyLogsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      date: date ?? this.date,
      dayNumber: dayNumber ?? this.dayNumber,
      area: area ?? this.area,
      weather: weather ?? this.weather,
      scionBatchId: scionBatchId ?? this.scionBatchId,
      graftingCount: graftingCount ?? this.graftingCount,
      baggingCount: baggingCount ?? this.baggingCount,
      laborCost: laborCost ?? this.laborCost,
      materialCost: materialCost ?? this.materialCost,
      totalCost: totalCost ?? this.totalCost,
      materialNotes: materialNotes ?? this.materialNotes,
      notes: notes ?? this.notes,
      importanceLevel: importanceLevel ?? this.importanceLevel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (dayNumber.present) {
      map['day_number'] = Variable<int>(dayNumber.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (weather.present) {
      map['weather'] = Variable<String>(weather.value);
    }
    if (scionBatchId.present) {
      map['scion_batch_id'] = Variable<int>(scionBatchId.value);
    }
    if (graftingCount.present) {
      map['grafting_count'] = Variable<int>(graftingCount.value);
    }
    if (baggingCount.present) {
      map['bagging_count'] = Variable<int>(baggingCount.value);
    }
    if (laborCost.present) {
      map['labor_cost'] = Variable<double>(laborCost.value);
    }
    if (materialCost.present) {
      map['material_cost'] = Variable<double>(materialCost.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (materialNotes.present) {
      map['material_notes'] = Variable<String>(materialNotes.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (importanceLevel.present) {
      map['importance_level'] = Variable<int>(importanceLevel.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyLogsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('date: $date, ')
          ..write('dayNumber: $dayNumber, ')
          ..write('area: $area, ')
          ..write('weather: $weather, ')
          ..write('scionBatchId: $scionBatchId, ')
          ..write('graftingCount: $graftingCount, ')
          ..write('baggingCount: $baggingCount, ')
          ..write('laborCost: $laborCost, ')
          ..write('materialCost: $materialCost, ')
          ..write('totalCost: $totalCost, ')
          ..write('materialNotes: $materialNotes, ')
          ..write('notes: $notes, ')
          ..write('importanceLevel: $importanceLevel')
          ..write(')'))
        .toString();
  }
}

class $ActionsTable extends Actions with TableInfo<$ActionsTable, Action> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dailyLogIdMeta = const VerificationMeta(
    'dailyLogId',
  );
  @override
  late final GeneratedColumn<int> dailyLogId = GeneratedColumn<int>(
    'daily_log_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES daily_logs (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemNameMeta = const VerificationMeta(
    'itemName',
  );
  @override
  late final GeneratedColumn<String> itemName = GeneratedColumn<String>(
    'item_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, dailyLogId, type, itemName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'actions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Action> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('daily_log_id')) {
      context.handle(
        _dailyLogIdMeta,
        dailyLogId.isAcceptableOrUnknown(
          data['daily_log_id']!,
          _dailyLogIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyLogIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('item_name')) {
      context.handle(
        _itemNameMeta,
        itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta),
      );
    } else if (isInserting) {
      context.missing(_itemNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Action map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Action(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dailyLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_log_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      itemName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_name'],
      )!,
    );
  }

  @override
  $ActionsTable createAlias(String alias) {
    return $ActionsTable(attachedDatabase, alias);
  }
}

class Action extends DataClass implements Insertable<Action> {
  final int id;
  final int dailyLogId;
  final String type;
  final String itemName;
  const Action({
    required this.id,
    required this.dailyLogId,
    required this.type,
    required this.itemName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['daily_log_id'] = Variable<int>(dailyLogId);
    map['type'] = Variable<String>(type);
    map['item_name'] = Variable<String>(itemName);
    return map;
  }

  ActionsCompanion toCompanion(bool nullToAbsent) {
    return ActionsCompanion(
      id: Value(id),
      dailyLogId: Value(dailyLogId),
      type: Value(type),
      itemName: Value(itemName),
    );
  }

  factory Action.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Action(
      id: serializer.fromJson<int>(json['id']),
      dailyLogId: serializer.fromJson<int>(json['dailyLogId']),
      type: serializer.fromJson<String>(json['type']),
      itemName: serializer.fromJson<String>(json['itemName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dailyLogId': serializer.toJson<int>(dailyLogId),
      'type': serializer.toJson<String>(type),
      'itemName': serializer.toJson<String>(itemName),
    };
  }

  Action copyWith({int? id, int? dailyLogId, String? type, String? itemName}) =>
      Action(
        id: id ?? this.id,
        dailyLogId: dailyLogId ?? this.dailyLogId,
        type: type ?? this.type,
        itemName: itemName ?? this.itemName,
      );
  Action copyWithCompanion(ActionsCompanion data) {
    return Action(
      id: data.id.present ? data.id.value : this.id,
      dailyLogId: data.dailyLogId.present
          ? data.dailyLogId.value
          : this.dailyLogId,
      type: data.type.present ? data.type.value : this.type,
      itemName: data.itemName.present ? data.itemName.value : this.itemName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Action(')
          ..write('id: $id, ')
          ..write('dailyLogId: $dailyLogId, ')
          ..write('type: $type, ')
          ..write('itemName: $itemName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dailyLogId, type, itemName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Action &&
          other.id == this.id &&
          other.dailyLogId == this.dailyLogId &&
          other.type == this.type &&
          other.itemName == this.itemName);
}

class ActionsCompanion extends UpdateCompanion<Action> {
  final Value<int> id;
  final Value<int> dailyLogId;
  final Value<String> type;
  final Value<String> itemName;
  const ActionsCompanion({
    this.id = const Value.absent(),
    this.dailyLogId = const Value.absent(),
    this.type = const Value.absent(),
    this.itemName = const Value.absent(),
  });
  ActionsCompanion.insert({
    this.id = const Value.absent(),
    required int dailyLogId,
    required String type,
    required String itemName,
  }) : dailyLogId = Value(dailyLogId),
       type = Value(type),
       itemName = Value(itemName);
  static Insertable<Action> custom({
    Expression<int>? id,
    Expression<int>? dailyLogId,
    Expression<String>? type,
    Expression<String>? itemName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dailyLogId != null) 'daily_log_id': dailyLogId,
      if (type != null) 'type': type,
      if (itemName != null) 'item_name': itemName,
    });
  }

  ActionsCompanion copyWith({
    Value<int>? id,
    Value<int>? dailyLogId,
    Value<String>? type,
    Value<String>? itemName,
  }) {
    return ActionsCompanion(
      id: id ?? this.id,
      dailyLogId: dailyLogId ?? this.dailyLogId,
      type: type ?? this.type,
      itemName: itemName ?? this.itemName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dailyLogId.present) {
      map['daily_log_id'] = Variable<int>(dailyLogId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActionsCompanion(')
          ..write('id: $id, ')
          ..write('dailyLogId: $dailyLogId, ')
          ..write('type: $type, ')
          ..write('itemName: $itemName')
          ..write(')'))
        .toString();
  }
}

class $ScionBatchesTable extends ScionBatches
    with TableInfo<$ScionBatchesTable, ScionBatche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScionBatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  static const VerificationMeta _deliveryDateMeta = const VerificationMeta(
    'deliveryDate',
  );
  @override
  late final GeneratedColumn<DateTime> deliveryDate = GeneratedColumn<DateTime>(
    'delivery_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batchNameMeta = const VerificationMeta(
    'batchName',
  );
  @override
  late final GeneratedColumn<String> batchName = GeneratedColumn<String>(
    'batch_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('其他'),
  );
  static const VerificationMeta _supplierNameMeta = const VerificationMeta(
    'supplierName',
  );
  @override
  late final GeneratedColumn<String> supplierName = GeneratedColumn<String>(
    'supplier_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _supplierContactMeta = const VerificationMeta(
    'supplierContact',
  );
  @override
  late final GeneratedColumn<String> supplierContact = GeneratedColumn<String>(
    'supplier_contact',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _harvestDateMeta = const VerificationMeta(
    'harvestDate',
  );
  @override
  late final GeneratedColumn<DateTime> harvestDate = GeneratedColumn<DateTime>(
    'harvest_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coldStorageStartDateMeta =
      const VerificationMeta('coldStorageStartDate');
  @override
  late final GeneratedColumn<DateTime> coldStorageStartDate =
      GeneratedColumn<DateTime>(
        'cold_storage_start_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _coldStorageDaysMeta = const VerificationMeta(
    'coldStorageDays',
  );
  @override
  late final GeneratedColumn<int> coldStorageDays = GeneratedColumn<int>(
    'cold_storage_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
    'total_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _qualityRatingMeta = const VerificationMeta(
    'qualityRating',
  );
  @override
  late final GeneratedColumn<String> qualityRating = GeneratedColumn<String>(
    'quality_rating',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    deliveryDate,
    batchName,
    quantity,
    sourceType,
    supplierName,
    supplierContact,
    harvestDate,
    coldStorageStartDate,
    coldStorageDays,
    unitPrice,
    totalPrice,
    qualityRating,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scion_batches';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScionBatche> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('delivery_date')) {
      context.handle(
        _deliveryDateMeta,
        deliveryDate.isAcceptableOrUnknown(
          data['delivery_date']!,
          _deliveryDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deliveryDateMeta);
    }
    if (data.containsKey('batch_name')) {
      context.handle(
        _batchNameMeta,
        batchName.isAcceptableOrUnknown(data['batch_name']!, _batchNameMeta),
      );
    } else if (isInserting) {
      context.missing(_batchNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    }
    if (data.containsKey('supplier_name')) {
      context.handle(
        _supplierNameMeta,
        supplierName.isAcceptableOrUnknown(
          data['supplier_name']!,
          _supplierNameMeta,
        ),
      );
    }
    if (data.containsKey('supplier_contact')) {
      context.handle(
        _supplierContactMeta,
        supplierContact.isAcceptableOrUnknown(
          data['supplier_contact']!,
          _supplierContactMeta,
        ),
      );
    }
    if (data.containsKey('harvest_date')) {
      context.handle(
        _harvestDateMeta,
        harvestDate.isAcceptableOrUnknown(
          data['harvest_date']!,
          _harvestDateMeta,
        ),
      );
    }
    if (data.containsKey('cold_storage_start_date')) {
      context.handle(
        _coldStorageStartDateMeta,
        coldStorageStartDate.isAcceptableOrUnknown(
          data['cold_storage_start_date']!,
          _coldStorageStartDateMeta,
        ),
      );
    }
    if (data.containsKey('cold_storage_days')) {
      context.handle(
        _coldStorageDaysMeta,
        coldStorageDays.isAcceptableOrUnknown(
          data['cold_storage_days']!,
          _coldStorageDaysMeta,
        ),
      );
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    }
    if (data.containsKey('quality_rating')) {
      context.handle(
        _qualityRatingMeta,
        qualityRating.isAcceptableOrUnknown(
          data['quality_rating']!,
          _qualityRatingMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScionBatche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScionBatche(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}project_id'],
      )!,
      deliveryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}delivery_date'],
      )!,
      batchName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}batch_name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      ),
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      supplierName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_name'],
      ),
      supplierContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}supplier_contact'],
      ),
      harvestDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}harvest_date'],
      ),
      coldStorageStartDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cold_storage_start_date'],
      ),
      coldStorageDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cold_storage_days'],
      ),
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      ),
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      ),
      qualityRating: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quality_rating'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $ScionBatchesTable createAlias(String alias) {
    return $ScionBatchesTable(attachedDatabase, alias);
  }
}

class ScionBatche extends DataClass implements Insertable<ScionBatche> {
  final int id;
  final int projectId;
  final DateTime deliveryDate;
  final String batchName;
  final int? quantity;
  final String sourceType;
  final String? supplierName;
  final String? supplierContact;
  final DateTime? harvestDate;
  final DateTime? coldStorageStartDate;
  final int? coldStorageDays;
  final double? unitPrice;
  final double? totalPrice;
  final String? qualityRating;
  final String? notes;
  const ScionBatche({
    required this.id,
    required this.projectId,
    required this.deliveryDate,
    required this.batchName,
    this.quantity,
    required this.sourceType,
    this.supplierName,
    this.supplierContact,
    this.harvestDate,
    this.coldStorageStartDate,
    this.coldStorageDays,
    this.unitPrice,
    this.totalPrice,
    this.qualityRating,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['project_id'] = Variable<int>(projectId);
    map['delivery_date'] = Variable<DateTime>(deliveryDate);
    map['batch_name'] = Variable<String>(batchName);
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<int>(quantity);
    }
    map['source_type'] = Variable<String>(sourceType);
    if (!nullToAbsent || supplierName != null) {
      map['supplier_name'] = Variable<String>(supplierName);
    }
    if (!nullToAbsent || supplierContact != null) {
      map['supplier_contact'] = Variable<String>(supplierContact);
    }
    if (!nullToAbsent || harvestDate != null) {
      map['harvest_date'] = Variable<DateTime>(harvestDate);
    }
    if (!nullToAbsent || coldStorageStartDate != null) {
      map['cold_storage_start_date'] = Variable<DateTime>(coldStorageStartDate);
    }
    if (!nullToAbsent || coldStorageDays != null) {
      map['cold_storage_days'] = Variable<int>(coldStorageDays);
    }
    if (!nullToAbsent || unitPrice != null) {
      map['unit_price'] = Variable<double>(unitPrice);
    }
    if (!nullToAbsent || totalPrice != null) {
      map['total_price'] = Variable<double>(totalPrice);
    }
    if (!nullToAbsent || qualityRating != null) {
      map['quality_rating'] = Variable<String>(qualityRating);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  ScionBatchesCompanion toCompanion(bool nullToAbsent) {
    return ScionBatchesCompanion(
      id: Value(id),
      projectId: Value(projectId),
      deliveryDate: Value(deliveryDate),
      batchName: Value(batchName),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      sourceType: Value(sourceType),
      supplierName: supplierName == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierName),
      supplierContact: supplierContact == null && nullToAbsent
          ? const Value.absent()
          : Value(supplierContact),
      harvestDate: harvestDate == null && nullToAbsent
          ? const Value.absent()
          : Value(harvestDate),
      coldStorageStartDate: coldStorageStartDate == null && nullToAbsent
          ? const Value.absent()
          : Value(coldStorageStartDate),
      coldStorageDays: coldStorageDays == null && nullToAbsent
          ? const Value.absent()
          : Value(coldStorageDays),
      unitPrice: unitPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(unitPrice),
      totalPrice: totalPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(totalPrice),
      qualityRating: qualityRating == null && nullToAbsent
          ? const Value.absent()
          : Value(qualityRating),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory ScionBatche.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScionBatche(
      id: serializer.fromJson<int>(json['id']),
      projectId: serializer.fromJson<int>(json['projectId']),
      deliveryDate: serializer.fromJson<DateTime>(json['deliveryDate']),
      batchName: serializer.fromJson<String>(json['batchName']),
      quantity: serializer.fromJson<int?>(json['quantity']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      supplierName: serializer.fromJson<String?>(json['supplierName']),
      supplierContact: serializer.fromJson<String?>(json['supplierContact']),
      harvestDate: serializer.fromJson<DateTime?>(json['harvestDate']),
      coldStorageStartDate: serializer.fromJson<DateTime?>(
        json['coldStorageStartDate'],
      ),
      coldStorageDays: serializer.fromJson<int?>(json['coldStorageDays']),
      unitPrice: serializer.fromJson<double?>(json['unitPrice']),
      totalPrice: serializer.fromJson<double?>(json['totalPrice']),
      qualityRating: serializer.fromJson<String?>(json['qualityRating']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectId': serializer.toJson<int>(projectId),
      'deliveryDate': serializer.toJson<DateTime>(deliveryDate),
      'batchName': serializer.toJson<String>(batchName),
      'quantity': serializer.toJson<int?>(quantity),
      'sourceType': serializer.toJson<String>(sourceType),
      'supplierName': serializer.toJson<String?>(supplierName),
      'supplierContact': serializer.toJson<String?>(supplierContact),
      'harvestDate': serializer.toJson<DateTime?>(harvestDate),
      'coldStorageStartDate': serializer.toJson<DateTime?>(
        coldStorageStartDate,
      ),
      'coldStorageDays': serializer.toJson<int?>(coldStorageDays),
      'unitPrice': serializer.toJson<double?>(unitPrice),
      'totalPrice': serializer.toJson<double?>(totalPrice),
      'qualityRating': serializer.toJson<String?>(qualityRating),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  ScionBatche copyWith({
    int? id,
    int? projectId,
    DateTime? deliveryDate,
    String? batchName,
    Value<int?> quantity = const Value.absent(),
    String? sourceType,
    Value<String?> supplierName = const Value.absent(),
    Value<String?> supplierContact = const Value.absent(),
    Value<DateTime?> harvestDate = const Value.absent(),
    Value<DateTime?> coldStorageStartDate = const Value.absent(),
    Value<int?> coldStorageDays = const Value.absent(),
    Value<double?> unitPrice = const Value.absent(),
    Value<double?> totalPrice = const Value.absent(),
    Value<String?> qualityRating = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => ScionBatche(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    deliveryDate: deliveryDate ?? this.deliveryDate,
    batchName: batchName ?? this.batchName,
    quantity: quantity.present ? quantity.value : this.quantity,
    sourceType: sourceType ?? this.sourceType,
    supplierName: supplierName.present ? supplierName.value : this.supplierName,
    supplierContact: supplierContact.present
        ? supplierContact.value
        : this.supplierContact,
    harvestDate: harvestDate.present ? harvestDate.value : this.harvestDate,
    coldStorageStartDate: coldStorageStartDate.present
        ? coldStorageStartDate.value
        : this.coldStorageStartDate,
    coldStorageDays: coldStorageDays.present
        ? coldStorageDays.value
        : this.coldStorageDays,
    unitPrice: unitPrice.present ? unitPrice.value : this.unitPrice,
    totalPrice: totalPrice.present ? totalPrice.value : this.totalPrice,
    qualityRating: qualityRating.present
        ? qualityRating.value
        : this.qualityRating,
    notes: notes.present ? notes.value : this.notes,
  );
  ScionBatche copyWithCompanion(ScionBatchesCompanion data) {
    return ScionBatche(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      deliveryDate: data.deliveryDate.present
          ? data.deliveryDate.value
          : this.deliveryDate,
      batchName: data.batchName.present ? data.batchName.value : this.batchName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      supplierName: data.supplierName.present
          ? data.supplierName.value
          : this.supplierName,
      supplierContact: data.supplierContact.present
          ? data.supplierContact.value
          : this.supplierContact,
      harvestDate: data.harvestDate.present
          ? data.harvestDate.value
          : this.harvestDate,
      coldStorageStartDate: data.coldStorageStartDate.present
          ? data.coldStorageStartDate.value
          : this.coldStorageStartDate,
      coldStorageDays: data.coldStorageDays.present
          ? data.coldStorageDays.value
          : this.coldStorageDays,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      qualityRating: data.qualityRating.present
          ? data.qualityRating.value
          : this.qualityRating,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScionBatche(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('batchName: $batchName, ')
          ..write('quantity: $quantity, ')
          ..write('sourceType: $sourceType, ')
          ..write('supplierName: $supplierName, ')
          ..write('supplierContact: $supplierContact, ')
          ..write('harvestDate: $harvestDate, ')
          ..write('coldStorageStartDate: $coldStorageStartDate, ')
          ..write('coldStorageDays: $coldStorageDays, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('qualityRating: $qualityRating, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    deliveryDate,
    batchName,
    quantity,
    sourceType,
    supplierName,
    supplierContact,
    harvestDate,
    coldStorageStartDate,
    coldStorageDays,
    unitPrice,
    totalPrice,
    qualityRating,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScionBatche &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.deliveryDate == this.deliveryDate &&
          other.batchName == this.batchName &&
          other.quantity == this.quantity &&
          other.sourceType == this.sourceType &&
          other.supplierName == this.supplierName &&
          other.supplierContact == this.supplierContact &&
          other.harvestDate == this.harvestDate &&
          other.coldStorageStartDate == this.coldStorageStartDate &&
          other.coldStorageDays == this.coldStorageDays &&
          other.unitPrice == this.unitPrice &&
          other.totalPrice == this.totalPrice &&
          other.qualityRating == this.qualityRating &&
          other.notes == this.notes);
}

class ScionBatchesCompanion extends UpdateCompanion<ScionBatche> {
  final Value<int> id;
  final Value<int> projectId;
  final Value<DateTime> deliveryDate;
  final Value<String> batchName;
  final Value<int?> quantity;
  final Value<String> sourceType;
  final Value<String?> supplierName;
  final Value<String?> supplierContact;
  final Value<DateTime?> harvestDate;
  final Value<DateTime?> coldStorageStartDate;
  final Value<int?> coldStorageDays;
  final Value<double?> unitPrice;
  final Value<double?> totalPrice;
  final Value<String?> qualityRating;
  final Value<String?> notes;
  const ScionBatchesCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.deliveryDate = const Value.absent(),
    this.batchName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.supplierName = const Value.absent(),
    this.supplierContact = const Value.absent(),
    this.harvestDate = const Value.absent(),
    this.coldStorageStartDate = const Value.absent(),
    this.coldStorageDays = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.qualityRating = const Value.absent(),
    this.notes = const Value.absent(),
  });
  ScionBatchesCompanion.insert({
    this.id = const Value.absent(),
    required int projectId,
    required DateTime deliveryDate,
    required String batchName,
    this.quantity = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.supplierName = const Value.absent(),
    this.supplierContact = const Value.absent(),
    this.harvestDate = const Value.absent(),
    this.coldStorageStartDate = const Value.absent(),
    this.coldStorageDays = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.qualityRating = const Value.absent(),
    this.notes = const Value.absent(),
  }) : projectId = Value(projectId),
       deliveryDate = Value(deliveryDate),
       batchName = Value(batchName);
  static Insertable<ScionBatche> custom({
    Expression<int>? id,
    Expression<int>? projectId,
    Expression<DateTime>? deliveryDate,
    Expression<String>? batchName,
    Expression<int>? quantity,
    Expression<String>? sourceType,
    Expression<String>? supplierName,
    Expression<String>? supplierContact,
    Expression<DateTime>? harvestDate,
    Expression<DateTime>? coldStorageStartDate,
    Expression<int>? coldStorageDays,
    Expression<double>? unitPrice,
    Expression<double>? totalPrice,
    Expression<String>? qualityRating,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (deliveryDate != null) 'delivery_date': deliveryDate,
      if (batchName != null) 'batch_name': batchName,
      if (quantity != null) 'quantity': quantity,
      if (sourceType != null) 'source_type': sourceType,
      if (supplierName != null) 'supplier_name': supplierName,
      if (supplierContact != null) 'supplier_contact': supplierContact,
      if (harvestDate != null) 'harvest_date': harvestDate,
      if (coldStorageStartDate != null)
        'cold_storage_start_date': coldStorageStartDate,
      if (coldStorageDays != null) 'cold_storage_days': coldStorageDays,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (totalPrice != null) 'total_price': totalPrice,
      if (qualityRating != null) 'quality_rating': qualityRating,
      if (notes != null) 'notes': notes,
    });
  }

  ScionBatchesCompanion copyWith({
    Value<int>? id,
    Value<int>? projectId,
    Value<DateTime>? deliveryDate,
    Value<String>? batchName,
    Value<int?>? quantity,
    Value<String>? sourceType,
    Value<String?>? supplierName,
    Value<String?>? supplierContact,
    Value<DateTime?>? harvestDate,
    Value<DateTime?>? coldStorageStartDate,
    Value<int?>? coldStorageDays,
    Value<double?>? unitPrice,
    Value<double?>? totalPrice,
    Value<String?>? qualityRating,
    Value<String?>? notes,
  }) {
    return ScionBatchesCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      batchName: batchName ?? this.batchName,
      quantity: quantity ?? this.quantity,
      sourceType: sourceType ?? this.sourceType,
      supplierName: supplierName ?? this.supplierName,
      supplierContact: supplierContact ?? this.supplierContact,
      harvestDate: harvestDate ?? this.harvestDate,
      coldStorageStartDate: coldStorageStartDate ?? this.coldStorageStartDate,
      coldStorageDays: coldStorageDays ?? this.coldStorageDays,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      qualityRating: qualityRating ?? this.qualityRating,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (deliveryDate.present) {
      map['delivery_date'] = Variable<DateTime>(deliveryDate.value);
    }
    if (batchName.present) {
      map['batch_name'] = Variable<String>(batchName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (supplierName.present) {
      map['supplier_name'] = Variable<String>(supplierName.value);
    }
    if (supplierContact.present) {
      map['supplier_contact'] = Variable<String>(supplierContact.value);
    }
    if (harvestDate.present) {
      map['harvest_date'] = Variable<DateTime>(harvestDate.value);
    }
    if (coldStorageStartDate.present) {
      map['cold_storage_start_date'] = Variable<DateTime>(
        coldStorageStartDate.value,
      );
    }
    if (coldStorageDays.present) {
      map['cold_storage_days'] = Variable<int>(coldStorageDays.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (qualityRating.present) {
      map['quality_rating'] = Variable<String>(qualityRating.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScionBatchesCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('deliveryDate: $deliveryDate, ')
          ..write('batchName: $batchName, ')
          ..write('quantity: $quantity, ')
          ..write('sourceType: $sourceType, ')
          ..write('supplierName: $supplierName, ')
          ..write('supplierContact: $supplierContact, ')
          ..write('harvestDate: $harvestDate, ')
          ..write('coldStorageStartDate: $coldStorageStartDate, ')
          ..write('coldStorageDays: $coldStorageDays, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('qualityRating: $qualityRating, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $GraftStatusTable extends GraftStatus
    with TableInfo<$GraftStatusTable, GraftStatusData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GraftStatusTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dailyLogIdMeta = const VerificationMeta(
    'dailyLogId',
  );
  @override
  late final GeneratedColumn<int> dailyLogId = GeneratedColumn<int>(
    'daily_log_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES daily_logs (id)',
    ),
  );
  static const VerificationMeta _recordDateMeta = const VerificationMeta(
    'recordDate',
  );
  @override
  late final GeneratedColumn<DateTime> recordDate = GeneratedColumn<DateTime>(
    'record_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dailyLogId,
    recordDate,
    status,
    count,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'graft_status';
  @override
  VerificationContext validateIntegrity(
    Insertable<GraftStatusData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('daily_log_id')) {
      context.handle(
        _dailyLogIdMeta,
        dailyLogId.isAcceptableOrUnknown(
          data['daily_log_id']!,
          _dailyLogIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dailyLogIdMeta);
    }
    if (data.containsKey('record_date')) {
      context.handle(
        _recordDateMeta,
        recordDate.isAcceptableOrUnknown(data['record_date']!, _recordDateMeta),
      );
    } else if (isInserting) {
      context.missing(_recordDateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GraftStatusData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GraftStatusData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      dailyLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_log_id'],
      )!,
      recordDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}record_date'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      count: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}count'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $GraftStatusTable createAlias(String alias) {
    return $GraftStatusTable(attachedDatabase, alias);
  }
}

class GraftStatusData extends DataClass implements Insertable<GraftStatusData> {
  final int id;
  final int dailyLogId;
  final DateTime recordDate;
  final String status;
  final int count;
  final String? notes;
  const GraftStatusData({
    required this.id,
    required this.dailyLogId,
    required this.recordDate,
    required this.status,
    required this.count,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['daily_log_id'] = Variable<int>(dailyLogId);
    map['record_date'] = Variable<DateTime>(recordDate);
    map['status'] = Variable<String>(status);
    map['count'] = Variable<int>(count);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  GraftStatusCompanion toCompanion(bool nullToAbsent) {
    return GraftStatusCompanion(
      id: Value(id),
      dailyLogId: Value(dailyLogId),
      recordDate: Value(recordDate),
      status: Value(status),
      count: Value(count),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory GraftStatusData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GraftStatusData(
      id: serializer.fromJson<int>(json['id']),
      dailyLogId: serializer.fromJson<int>(json['dailyLogId']),
      recordDate: serializer.fromJson<DateTime>(json['recordDate']),
      status: serializer.fromJson<String>(json['status']),
      count: serializer.fromJson<int>(json['count']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dailyLogId': serializer.toJson<int>(dailyLogId),
      'recordDate': serializer.toJson<DateTime>(recordDate),
      'status': serializer.toJson<String>(status),
      'count': serializer.toJson<int>(count),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  GraftStatusData copyWith({
    int? id,
    int? dailyLogId,
    DateTime? recordDate,
    String? status,
    int? count,
    Value<String?> notes = const Value.absent(),
  }) => GraftStatusData(
    id: id ?? this.id,
    dailyLogId: dailyLogId ?? this.dailyLogId,
    recordDate: recordDate ?? this.recordDate,
    status: status ?? this.status,
    count: count ?? this.count,
    notes: notes.present ? notes.value : this.notes,
  );
  GraftStatusData copyWithCompanion(GraftStatusCompanion data) {
    return GraftStatusData(
      id: data.id.present ? data.id.value : this.id,
      dailyLogId: data.dailyLogId.present
          ? data.dailyLogId.value
          : this.dailyLogId,
      recordDate: data.recordDate.present
          ? data.recordDate.value
          : this.recordDate,
      status: data.status.present ? data.status.value : this.status,
      count: data.count.present ? data.count.value : this.count,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GraftStatusData(')
          ..write('id: $id, ')
          ..write('dailyLogId: $dailyLogId, ')
          ..write('recordDate: $recordDate, ')
          ..write('status: $status, ')
          ..write('count: $count, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, dailyLogId, recordDate, status, count, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GraftStatusData &&
          other.id == this.id &&
          other.dailyLogId == this.dailyLogId &&
          other.recordDate == this.recordDate &&
          other.status == this.status &&
          other.count == this.count &&
          other.notes == this.notes);
}

class GraftStatusCompanion extends UpdateCompanion<GraftStatusData> {
  final Value<int> id;
  final Value<int> dailyLogId;
  final Value<DateTime> recordDate;
  final Value<String> status;
  final Value<int> count;
  final Value<String?> notes;
  const GraftStatusCompanion({
    this.id = const Value.absent(),
    this.dailyLogId = const Value.absent(),
    this.recordDate = const Value.absent(),
    this.status = const Value.absent(),
    this.count = const Value.absent(),
    this.notes = const Value.absent(),
  });
  GraftStatusCompanion.insert({
    this.id = const Value.absent(),
    required int dailyLogId,
    required DateTime recordDate,
    required String status,
    this.count = const Value.absent(),
    this.notes = const Value.absent(),
  }) : dailyLogId = Value(dailyLogId),
       recordDate = Value(recordDate),
       status = Value(status);
  static Insertable<GraftStatusData> custom({
    Expression<int>? id,
    Expression<int>? dailyLogId,
    Expression<DateTime>? recordDate,
    Expression<String>? status,
    Expression<int>? count,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dailyLogId != null) 'daily_log_id': dailyLogId,
      if (recordDate != null) 'record_date': recordDate,
      if (status != null) 'status': status,
      if (count != null) 'count': count,
      if (notes != null) 'notes': notes,
    });
  }

  GraftStatusCompanion copyWith({
    Value<int>? id,
    Value<int>? dailyLogId,
    Value<DateTime>? recordDate,
    Value<String>? status,
    Value<int>? count,
    Value<String?>? notes,
  }) {
    return GraftStatusCompanion(
      id: id ?? this.id,
      dailyLogId: dailyLogId ?? this.dailyLogId,
      recordDate: recordDate ?? this.recordDate,
      status: status ?? this.status,
      count: count ?? this.count,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dailyLogId.present) {
      map['daily_log_id'] = Variable<int>(dailyLogId.value);
    }
    if (recordDate.present) {
      map['record_date'] = Variable<DateTime>(recordDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GraftStatusCompanion(')
          ..write('id: $id, ')
          ..write('dailyLogId: $dailyLogId, ')
          ..write('recordDate: $recordDate, ')
          ..write('status: $status, ')
          ..write('count: $count, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $ReminderSettingsTable extends ReminderSettings
    with TableInfo<$ReminderSettingsTable, ReminderSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReminderSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<int> projectId = GeneratedColumn<int>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  static const VerificationMeta _dailyReminderEnabledMeta =
      const VerificationMeta('dailyReminderEnabled');
  @override
  late final GeneratedColumn<bool> dailyReminderEnabled = GeneratedColumn<bool>(
    'daily_reminder_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("daily_reminder_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _dailyReminderHourMeta = const VerificationMeta(
    'dailyReminderHour',
  );
  @override
  late final GeneratedColumn<int> dailyReminderHour = GeneratedColumn<int>(
    'daily_reminder_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(9),
  );
  static const VerificationMeta _dailyReminderMinuteMeta =
      const VerificationMeta('dailyReminderMinute');
  @override
  late final GeneratedColumn<int> dailyReminderMinute = GeneratedColumn<int>(
    'daily_reminder_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _startDateReminderEnabledMeta =
      const VerificationMeta('startDateReminderEnabled');
  @override
  late final GeneratedColumn<bool> startDateReminderEnabled =
      GeneratedColumn<bool>(
        'start_date_reminder_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("start_date_reminder_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _endDateReminderEnabledMeta =
      const VerificationMeta('endDateReminderEnabled');
  @override
  late final GeneratedColumn<bool> endDateReminderEnabled =
      GeneratedColumn<bool>(
        'end_date_reminder_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("end_date_reminder_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _expectedStartDateMeta = const VerificationMeta(
    'expectedStartDate',
  );
  @override
  late final GeneratedColumn<DateTime> expectedStartDate =
      GeneratedColumn<DateTime>(
        'expected_start_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _expectedEndDateMeta = const VerificationMeta(
    'expectedEndDate',
  );
  @override
  late final GeneratedColumn<DateTime> expectedEndDate =
      GeneratedColumn<DateTime>(
        'expected_end_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _rainyDaysAlertEnabledMeta =
      const VerificationMeta('rainyDaysAlertEnabled');
  @override
  late final GeneratedColumn<bool> rainyDaysAlertEnabled =
      GeneratedColumn<bool>(
        'rainy_days_alert_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("rainy_days_alert_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _consecutiveRainyDaysThresholdMeta =
      const VerificationMeta('consecutiveRainyDaysThreshold');
  @override
  late final GeneratedColumn<int> consecutiveRainyDaysThreshold =
      GeneratedColumn<int>(
        'consecutive_rainy_days_threshold',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(3),
      );
  static const VerificationMeta _lowTempAlertEnabledMeta =
      const VerificationMeta('lowTempAlertEnabled');
  @override
  late final GeneratedColumn<bool> lowTempAlertEnabled = GeneratedColumn<bool>(
    'low_temp_alert_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("low_temp_alert_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    projectId,
    dailyReminderEnabled,
    dailyReminderHour,
    dailyReminderMinute,
    startDateReminderEnabled,
    endDateReminderEnabled,
    expectedStartDate,
    expectedEndDate,
    rainyDaysAlertEnabled,
    consecutiveRainyDaysThreshold,
    lowTempAlertEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminder_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('daily_reminder_enabled')) {
      context.handle(
        _dailyReminderEnabledMeta,
        dailyReminderEnabled.isAcceptableOrUnknown(
          data['daily_reminder_enabled']!,
          _dailyReminderEnabledMeta,
        ),
      );
    }
    if (data.containsKey('daily_reminder_hour')) {
      context.handle(
        _dailyReminderHourMeta,
        dailyReminderHour.isAcceptableOrUnknown(
          data['daily_reminder_hour']!,
          _dailyReminderHourMeta,
        ),
      );
    }
    if (data.containsKey('daily_reminder_minute')) {
      context.handle(
        _dailyReminderMinuteMeta,
        dailyReminderMinute.isAcceptableOrUnknown(
          data['daily_reminder_minute']!,
          _dailyReminderMinuteMeta,
        ),
      );
    }
    if (data.containsKey('start_date_reminder_enabled')) {
      context.handle(
        _startDateReminderEnabledMeta,
        startDateReminderEnabled.isAcceptableOrUnknown(
          data['start_date_reminder_enabled']!,
          _startDateReminderEnabledMeta,
        ),
      );
    }
    if (data.containsKey('end_date_reminder_enabled')) {
      context.handle(
        _endDateReminderEnabledMeta,
        endDateReminderEnabled.isAcceptableOrUnknown(
          data['end_date_reminder_enabled']!,
          _endDateReminderEnabledMeta,
        ),
      );
    }
    if (data.containsKey('expected_start_date')) {
      context.handle(
        _expectedStartDateMeta,
        expectedStartDate.isAcceptableOrUnknown(
          data['expected_start_date']!,
          _expectedStartDateMeta,
        ),
      );
    }
    if (data.containsKey('expected_end_date')) {
      context.handle(
        _expectedEndDateMeta,
        expectedEndDate.isAcceptableOrUnknown(
          data['expected_end_date']!,
          _expectedEndDateMeta,
        ),
      );
    }
    if (data.containsKey('rainy_days_alert_enabled')) {
      context.handle(
        _rainyDaysAlertEnabledMeta,
        rainyDaysAlertEnabled.isAcceptableOrUnknown(
          data['rainy_days_alert_enabled']!,
          _rainyDaysAlertEnabledMeta,
        ),
      );
    }
    if (data.containsKey('consecutive_rainy_days_threshold')) {
      context.handle(
        _consecutiveRainyDaysThresholdMeta,
        consecutiveRainyDaysThreshold.isAcceptableOrUnknown(
          data['consecutive_rainy_days_threshold']!,
          _consecutiveRainyDaysThresholdMeta,
        ),
      );
    }
    if (data.containsKey('low_temp_alert_enabled')) {
      context.handle(
        _lowTempAlertEnabledMeta,
        lowTempAlertEnabled.isAcceptableOrUnknown(
          data['low_temp_alert_enabled']!,
          _lowTempAlertEnabledMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}project_id'],
      )!,
      dailyReminderEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}daily_reminder_enabled'],
      )!,
      dailyReminderHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_reminder_hour'],
      )!,
      dailyReminderMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_reminder_minute'],
      )!,
      startDateReminderEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}start_date_reminder_enabled'],
      )!,
      endDateReminderEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}end_date_reminder_enabled'],
      )!,
      expectedStartDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expected_start_date'],
      ),
      expectedEndDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expected_end_date'],
      ),
      rainyDaysAlertEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}rainy_days_alert_enabled'],
      )!,
      consecutiveRainyDaysThreshold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}consecutive_rainy_days_threshold'],
      )!,
      lowTempAlertEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}low_temp_alert_enabled'],
      )!,
    );
  }

  @override
  $ReminderSettingsTable createAlias(String alias) {
    return $ReminderSettingsTable(attachedDatabase, alias);
  }
}

class ReminderSetting extends DataClass implements Insertable<ReminderSetting> {
  final int id;
  final int projectId;
  final bool dailyReminderEnabled;
  final int dailyReminderHour;
  final int dailyReminderMinute;
  final bool startDateReminderEnabled;
  final bool endDateReminderEnabled;
  final DateTime? expectedStartDate;
  final DateTime? expectedEndDate;
  final bool rainyDaysAlertEnabled;
  final int consecutiveRainyDaysThreshold;
  final bool lowTempAlertEnabled;
  const ReminderSetting({
    required this.id,
    required this.projectId,
    required this.dailyReminderEnabled,
    required this.dailyReminderHour,
    required this.dailyReminderMinute,
    required this.startDateReminderEnabled,
    required this.endDateReminderEnabled,
    this.expectedStartDate,
    this.expectedEndDate,
    required this.rainyDaysAlertEnabled,
    required this.consecutiveRainyDaysThreshold,
    required this.lowTempAlertEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['project_id'] = Variable<int>(projectId);
    map['daily_reminder_enabled'] = Variable<bool>(dailyReminderEnabled);
    map['daily_reminder_hour'] = Variable<int>(dailyReminderHour);
    map['daily_reminder_minute'] = Variable<int>(dailyReminderMinute);
    map['start_date_reminder_enabled'] = Variable<bool>(
      startDateReminderEnabled,
    );
    map['end_date_reminder_enabled'] = Variable<bool>(endDateReminderEnabled);
    if (!nullToAbsent || expectedStartDate != null) {
      map['expected_start_date'] = Variable<DateTime>(expectedStartDate);
    }
    if (!nullToAbsent || expectedEndDate != null) {
      map['expected_end_date'] = Variable<DateTime>(expectedEndDate);
    }
    map['rainy_days_alert_enabled'] = Variable<bool>(rainyDaysAlertEnabled);
    map['consecutive_rainy_days_threshold'] = Variable<int>(
      consecutiveRainyDaysThreshold,
    );
    map['low_temp_alert_enabled'] = Variable<bool>(lowTempAlertEnabled);
    return map;
  }

  ReminderSettingsCompanion toCompanion(bool nullToAbsent) {
    return ReminderSettingsCompanion(
      id: Value(id),
      projectId: Value(projectId),
      dailyReminderEnabled: Value(dailyReminderEnabled),
      dailyReminderHour: Value(dailyReminderHour),
      dailyReminderMinute: Value(dailyReminderMinute),
      startDateReminderEnabled: Value(startDateReminderEnabled),
      endDateReminderEnabled: Value(endDateReminderEnabled),
      expectedStartDate: expectedStartDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedStartDate),
      expectedEndDate: expectedEndDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedEndDate),
      rainyDaysAlertEnabled: Value(rainyDaysAlertEnabled),
      consecutiveRainyDaysThreshold: Value(consecutiveRainyDaysThreshold),
      lowTempAlertEnabled: Value(lowTempAlertEnabled),
    );
  }

  factory ReminderSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderSetting(
      id: serializer.fromJson<int>(json['id']),
      projectId: serializer.fromJson<int>(json['projectId']),
      dailyReminderEnabled: serializer.fromJson<bool>(
        json['dailyReminderEnabled'],
      ),
      dailyReminderHour: serializer.fromJson<int>(json['dailyReminderHour']),
      dailyReminderMinute: serializer.fromJson<int>(
        json['dailyReminderMinute'],
      ),
      startDateReminderEnabled: serializer.fromJson<bool>(
        json['startDateReminderEnabled'],
      ),
      endDateReminderEnabled: serializer.fromJson<bool>(
        json['endDateReminderEnabled'],
      ),
      expectedStartDate: serializer.fromJson<DateTime?>(
        json['expectedStartDate'],
      ),
      expectedEndDate: serializer.fromJson<DateTime?>(json['expectedEndDate']),
      rainyDaysAlertEnabled: serializer.fromJson<bool>(
        json['rainyDaysAlertEnabled'],
      ),
      consecutiveRainyDaysThreshold: serializer.fromJson<int>(
        json['consecutiveRainyDaysThreshold'],
      ),
      lowTempAlertEnabled: serializer.fromJson<bool>(
        json['lowTempAlertEnabled'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'projectId': serializer.toJson<int>(projectId),
      'dailyReminderEnabled': serializer.toJson<bool>(dailyReminderEnabled),
      'dailyReminderHour': serializer.toJson<int>(dailyReminderHour),
      'dailyReminderMinute': serializer.toJson<int>(dailyReminderMinute),
      'startDateReminderEnabled': serializer.toJson<bool>(
        startDateReminderEnabled,
      ),
      'endDateReminderEnabled': serializer.toJson<bool>(endDateReminderEnabled),
      'expectedStartDate': serializer.toJson<DateTime?>(expectedStartDate),
      'expectedEndDate': serializer.toJson<DateTime?>(expectedEndDate),
      'rainyDaysAlertEnabled': serializer.toJson<bool>(rainyDaysAlertEnabled),
      'consecutiveRainyDaysThreshold': serializer.toJson<int>(
        consecutiveRainyDaysThreshold,
      ),
      'lowTempAlertEnabled': serializer.toJson<bool>(lowTempAlertEnabled),
    };
  }

  ReminderSetting copyWith({
    int? id,
    int? projectId,
    bool? dailyReminderEnabled,
    int? dailyReminderHour,
    int? dailyReminderMinute,
    bool? startDateReminderEnabled,
    bool? endDateReminderEnabled,
    Value<DateTime?> expectedStartDate = const Value.absent(),
    Value<DateTime?> expectedEndDate = const Value.absent(),
    bool? rainyDaysAlertEnabled,
    int? consecutiveRainyDaysThreshold,
    bool? lowTempAlertEnabled,
  }) => ReminderSetting(
    id: id ?? this.id,
    projectId: projectId ?? this.projectId,
    dailyReminderEnabled: dailyReminderEnabled ?? this.dailyReminderEnabled,
    dailyReminderHour: dailyReminderHour ?? this.dailyReminderHour,
    dailyReminderMinute: dailyReminderMinute ?? this.dailyReminderMinute,
    startDateReminderEnabled:
        startDateReminderEnabled ?? this.startDateReminderEnabled,
    endDateReminderEnabled:
        endDateReminderEnabled ?? this.endDateReminderEnabled,
    expectedStartDate: expectedStartDate.present
        ? expectedStartDate.value
        : this.expectedStartDate,
    expectedEndDate: expectedEndDate.present
        ? expectedEndDate.value
        : this.expectedEndDate,
    rainyDaysAlertEnabled: rainyDaysAlertEnabled ?? this.rainyDaysAlertEnabled,
    consecutiveRainyDaysThreshold:
        consecutiveRainyDaysThreshold ?? this.consecutiveRainyDaysThreshold,
    lowTempAlertEnabled: lowTempAlertEnabled ?? this.lowTempAlertEnabled,
  );
  ReminderSetting copyWithCompanion(ReminderSettingsCompanion data) {
    return ReminderSetting(
      id: data.id.present ? data.id.value : this.id,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      dailyReminderEnabled: data.dailyReminderEnabled.present
          ? data.dailyReminderEnabled.value
          : this.dailyReminderEnabled,
      dailyReminderHour: data.dailyReminderHour.present
          ? data.dailyReminderHour.value
          : this.dailyReminderHour,
      dailyReminderMinute: data.dailyReminderMinute.present
          ? data.dailyReminderMinute.value
          : this.dailyReminderMinute,
      startDateReminderEnabled: data.startDateReminderEnabled.present
          ? data.startDateReminderEnabled.value
          : this.startDateReminderEnabled,
      endDateReminderEnabled: data.endDateReminderEnabled.present
          ? data.endDateReminderEnabled.value
          : this.endDateReminderEnabled,
      expectedStartDate: data.expectedStartDate.present
          ? data.expectedStartDate.value
          : this.expectedStartDate,
      expectedEndDate: data.expectedEndDate.present
          ? data.expectedEndDate.value
          : this.expectedEndDate,
      rainyDaysAlertEnabled: data.rainyDaysAlertEnabled.present
          ? data.rainyDaysAlertEnabled.value
          : this.rainyDaysAlertEnabled,
      consecutiveRainyDaysThreshold: data.consecutiveRainyDaysThreshold.present
          ? data.consecutiveRainyDaysThreshold.value
          : this.consecutiveRainyDaysThreshold,
      lowTempAlertEnabled: data.lowTempAlertEnabled.present
          ? data.lowTempAlertEnabled.value
          : this.lowTempAlertEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderSetting(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('dailyReminderEnabled: $dailyReminderEnabled, ')
          ..write('dailyReminderHour: $dailyReminderHour, ')
          ..write('dailyReminderMinute: $dailyReminderMinute, ')
          ..write('startDateReminderEnabled: $startDateReminderEnabled, ')
          ..write('endDateReminderEnabled: $endDateReminderEnabled, ')
          ..write('expectedStartDate: $expectedStartDate, ')
          ..write('expectedEndDate: $expectedEndDate, ')
          ..write('rainyDaysAlertEnabled: $rainyDaysAlertEnabled, ')
          ..write(
            'consecutiveRainyDaysThreshold: $consecutiveRainyDaysThreshold, ',
          )
          ..write('lowTempAlertEnabled: $lowTempAlertEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    dailyReminderEnabled,
    dailyReminderHour,
    dailyReminderMinute,
    startDateReminderEnabled,
    endDateReminderEnabled,
    expectedStartDate,
    expectedEndDate,
    rainyDaysAlertEnabled,
    consecutiveRainyDaysThreshold,
    lowTempAlertEnabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderSetting &&
          other.id == this.id &&
          other.projectId == this.projectId &&
          other.dailyReminderEnabled == this.dailyReminderEnabled &&
          other.dailyReminderHour == this.dailyReminderHour &&
          other.dailyReminderMinute == this.dailyReminderMinute &&
          other.startDateReminderEnabled == this.startDateReminderEnabled &&
          other.endDateReminderEnabled == this.endDateReminderEnabled &&
          other.expectedStartDate == this.expectedStartDate &&
          other.expectedEndDate == this.expectedEndDate &&
          other.rainyDaysAlertEnabled == this.rainyDaysAlertEnabled &&
          other.consecutiveRainyDaysThreshold ==
              this.consecutiveRainyDaysThreshold &&
          other.lowTempAlertEnabled == this.lowTempAlertEnabled);
}

class ReminderSettingsCompanion extends UpdateCompanion<ReminderSetting> {
  final Value<int> id;
  final Value<int> projectId;
  final Value<bool> dailyReminderEnabled;
  final Value<int> dailyReminderHour;
  final Value<int> dailyReminderMinute;
  final Value<bool> startDateReminderEnabled;
  final Value<bool> endDateReminderEnabled;
  final Value<DateTime?> expectedStartDate;
  final Value<DateTime?> expectedEndDate;
  final Value<bool> rainyDaysAlertEnabled;
  final Value<int> consecutiveRainyDaysThreshold;
  final Value<bool> lowTempAlertEnabled;
  const ReminderSettingsCompanion({
    this.id = const Value.absent(),
    this.projectId = const Value.absent(),
    this.dailyReminderEnabled = const Value.absent(),
    this.dailyReminderHour = const Value.absent(),
    this.dailyReminderMinute = const Value.absent(),
    this.startDateReminderEnabled = const Value.absent(),
    this.endDateReminderEnabled = const Value.absent(),
    this.expectedStartDate = const Value.absent(),
    this.expectedEndDate = const Value.absent(),
    this.rainyDaysAlertEnabled = const Value.absent(),
    this.consecutiveRainyDaysThreshold = const Value.absent(),
    this.lowTempAlertEnabled = const Value.absent(),
  });
  ReminderSettingsCompanion.insert({
    this.id = const Value.absent(),
    required int projectId,
    this.dailyReminderEnabled = const Value.absent(),
    this.dailyReminderHour = const Value.absent(),
    this.dailyReminderMinute = const Value.absent(),
    this.startDateReminderEnabled = const Value.absent(),
    this.endDateReminderEnabled = const Value.absent(),
    this.expectedStartDate = const Value.absent(),
    this.expectedEndDate = const Value.absent(),
    this.rainyDaysAlertEnabled = const Value.absent(),
    this.consecutiveRainyDaysThreshold = const Value.absent(),
    this.lowTempAlertEnabled = const Value.absent(),
  }) : projectId = Value(projectId);
  static Insertable<ReminderSetting> custom({
    Expression<int>? id,
    Expression<int>? projectId,
    Expression<bool>? dailyReminderEnabled,
    Expression<int>? dailyReminderHour,
    Expression<int>? dailyReminderMinute,
    Expression<bool>? startDateReminderEnabled,
    Expression<bool>? endDateReminderEnabled,
    Expression<DateTime>? expectedStartDate,
    Expression<DateTime>? expectedEndDate,
    Expression<bool>? rainyDaysAlertEnabled,
    Expression<int>? consecutiveRainyDaysThreshold,
    Expression<bool>? lowTempAlertEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (projectId != null) 'project_id': projectId,
      if (dailyReminderEnabled != null)
        'daily_reminder_enabled': dailyReminderEnabled,
      if (dailyReminderHour != null) 'daily_reminder_hour': dailyReminderHour,
      if (dailyReminderMinute != null)
        'daily_reminder_minute': dailyReminderMinute,
      if (startDateReminderEnabled != null)
        'start_date_reminder_enabled': startDateReminderEnabled,
      if (endDateReminderEnabled != null)
        'end_date_reminder_enabled': endDateReminderEnabled,
      if (expectedStartDate != null) 'expected_start_date': expectedStartDate,
      if (expectedEndDate != null) 'expected_end_date': expectedEndDate,
      if (rainyDaysAlertEnabled != null)
        'rainy_days_alert_enabled': rainyDaysAlertEnabled,
      if (consecutiveRainyDaysThreshold != null)
        'consecutive_rainy_days_threshold': consecutiveRainyDaysThreshold,
      if (lowTempAlertEnabled != null)
        'low_temp_alert_enabled': lowTempAlertEnabled,
    });
  }

  ReminderSettingsCompanion copyWith({
    Value<int>? id,
    Value<int>? projectId,
    Value<bool>? dailyReminderEnabled,
    Value<int>? dailyReminderHour,
    Value<int>? dailyReminderMinute,
    Value<bool>? startDateReminderEnabled,
    Value<bool>? endDateReminderEnabled,
    Value<DateTime?>? expectedStartDate,
    Value<DateTime?>? expectedEndDate,
    Value<bool>? rainyDaysAlertEnabled,
    Value<int>? consecutiveRainyDaysThreshold,
    Value<bool>? lowTempAlertEnabled,
  }) {
    return ReminderSettingsCompanion(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      dailyReminderEnabled: dailyReminderEnabled ?? this.dailyReminderEnabled,
      dailyReminderHour: dailyReminderHour ?? this.dailyReminderHour,
      dailyReminderMinute: dailyReminderMinute ?? this.dailyReminderMinute,
      startDateReminderEnabled:
          startDateReminderEnabled ?? this.startDateReminderEnabled,
      endDateReminderEnabled:
          endDateReminderEnabled ?? this.endDateReminderEnabled,
      expectedStartDate: expectedStartDate ?? this.expectedStartDate,
      expectedEndDate: expectedEndDate ?? this.expectedEndDate,
      rainyDaysAlertEnabled:
          rainyDaysAlertEnabled ?? this.rainyDaysAlertEnabled,
      consecutiveRainyDaysThreshold:
          consecutiveRainyDaysThreshold ?? this.consecutiveRainyDaysThreshold,
      lowTempAlertEnabled: lowTempAlertEnabled ?? this.lowTempAlertEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<int>(projectId.value);
    }
    if (dailyReminderEnabled.present) {
      map['daily_reminder_enabled'] = Variable<bool>(
        dailyReminderEnabled.value,
      );
    }
    if (dailyReminderHour.present) {
      map['daily_reminder_hour'] = Variable<int>(dailyReminderHour.value);
    }
    if (dailyReminderMinute.present) {
      map['daily_reminder_minute'] = Variable<int>(dailyReminderMinute.value);
    }
    if (startDateReminderEnabled.present) {
      map['start_date_reminder_enabled'] = Variable<bool>(
        startDateReminderEnabled.value,
      );
    }
    if (endDateReminderEnabled.present) {
      map['end_date_reminder_enabled'] = Variable<bool>(
        endDateReminderEnabled.value,
      );
    }
    if (expectedStartDate.present) {
      map['expected_start_date'] = Variable<DateTime>(expectedStartDate.value);
    }
    if (expectedEndDate.present) {
      map['expected_end_date'] = Variable<DateTime>(expectedEndDate.value);
    }
    if (rainyDaysAlertEnabled.present) {
      map['rainy_days_alert_enabled'] = Variable<bool>(
        rainyDaysAlertEnabled.value,
      );
    }
    if (consecutiveRainyDaysThreshold.present) {
      map['consecutive_rainy_days_threshold'] = Variable<int>(
        consecutiveRainyDaysThreshold.value,
      );
    }
    if (lowTempAlertEnabled.present) {
      map['low_temp_alert_enabled'] = Variable<bool>(lowTempAlertEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReminderSettingsCompanion(')
          ..write('id: $id, ')
          ..write('projectId: $projectId, ')
          ..write('dailyReminderEnabled: $dailyReminderEnabled, ')
          ..write('dailyReminderHour: $dailyReminderHour, ')
          ..write('dailyReminderMinute: $dailyReminderMinute, ')
          ..write('startDateReminderEnabled: $startDateReminderEnabled, ')
          ..write('endDateReminderEnabled: $endDateReminderEnabled, ')
          ..write('expectedStartDate: $expectedStartDate, ')
          ..write('expectedEndDate: $expectedEndDate, ')
          ..write('rainyDaysAlertEnabled: $rainyDaysAlertEnabled, ')
          ..write(
            'consecutiveRainyDaysThreshold: $consecutiveRainyDaysThreshold, ',
          )
          ..write('lowTempAlertEnabled: $lowTempAlertEnabled')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $DailyLogsTable dailyLogs = $DailyLogsTable(this);
  late final $ActionsTable actions = $ActionsTable(this);
  late final $ScionBatchesTable scionBatches = $ScionBatchesTable(this);
  late final $GraftStatusTable graftStatus = $GraftStatusTable(this);
  late final $ReminderSettingsTable reminderSettings = $ReminderSettingsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    projects,
    dailyLogs,
    actions,
    scionBatches,
    graftStatus,
    reminderSettings,
  ];
}

typedef $$ProjectsTableCreateCompanionBuilder =
    ProjectsCompanion Function({
      Value<int> id,
      Value<int> year,
      Value<String> variety,
      required double wageGraft,
      required double wageBag,
      Value<double?> budgetLimit,
      Value<bool> budgetAlertEnabled,
      Value<double> budgetAlertThreshold,
    });
typedef $$ProjectsTableUpdateCompanionBuilder =
    ProjectsCompanion Function({
      Value<int> id,
      Value<int> year,
      Value<String> variety,
      Value<double> wageGraft,
      Value<double> wageBag,
      Value<double?> budgetLimit,
      Value<bool> budgetAlertEnabled,
      Value<double> budgetAlertThreshold,
    });

final class $$ProjectsTableReferences
    extends BaseReferences<_$AppDatabase, $ProjectsTable, Project> {
  $$ProjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DailyLogsTable, List<DailyLog>>
  _dailyLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dailyLogs,
    aliasName: $_aliasNameGenerator(db.projects.id, db.dailyLogs.projectId),
  );

  $$DailyLogsTableProcessedTableManager get dailyLogsRefs {
    final manager = $$DailyLogsTableTableManager(
      $_db,
      $_db.dailyLogs,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dailyLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ScionBatchesTable, List<ScionBatche>>
  _scionBatchesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.scionBatches,
    aliasName: $_aliasNameGenerator(db.projects.id, db.scionBatches.projectId),
  );

  $$ScionBatchesTableProcessedTableManager get scionBatchesRefs {
    final manager = $$ScionBatchesTableTableManager(
      $_db,
      $_db.scionBatches,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_scionBatchesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReminderSettingsTable, List<ReminderSetting>>
  _reminderSettingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminderSettings,
    aliasName: $_aliasNameGenerator(
      db.projects.id,
      db.reminderSettings.projectId,
    ),
  );

  $$ReminderSettingsTableProcessedTableManager get reminderSettingsRefs {
    final manager = $$ReminderSettingsTableTableManager(
      $_db,
      $_db.reminderSettings,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _reminderSettingsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variety => $composableBuilder(
    column: $table.variety,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wageGraft => $composableBuilder(
    column: $table.wageGraft,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get wageBag => $composableBuilder(
    column: $table.wageBag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get budgetLimit => $composableBuilder(
    column: $table.budgetLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get budgetAlertEnabled => $composableBuilder(
    column: $table.budgetAlertEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get budgetAlertThreshold => $composableBuilder(
    column: $table.budgetAlertThreshold,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> dailyLogsRefs(
    Expression<bool> Function($$DailyLogsTableFilterComposer f) f,
  ) {
    final $$DailyLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyLogs,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyLogsTableFilterComposer(
            $db: $db,
            $table: $db.dailyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scionBatchesRefs(
    Expression<bool> Function($$ScionBatchesTableFilterComposer f) f,
  ) {
    final $$ScionBatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scionBatches,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScionBatchesTableFilterComposer(
            $db: $db,
            $table: $db.scionBatches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reminderSettingsRefs(
    Expression<bool> Function($$ReminderSettingsTableFilterComposer f) f,
  ) {
    final $$ReminderSettingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminderSettings,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReminderSettingsTableFilterComposer(
            $db: $db,
            $table: $db.reminderSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get year => $composableBuilder(
    column: $table.year,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variety => $composableBuilder(
    column: $table.variety,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wageGraft => $composableBuilder(
    column: $table.wageGraft,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get wageBag => $composableBuilder(
    column: $table.wageBag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get budgetLimit => $composableBuilder(
    column: $table.budgetLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get budgetAlertEnabled => $composableBuilder(
    column: $table.budgetAlertEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get budgetAlertThreshold => $composableBuilder(
    column: $table.budgetAlertThreshold,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<String> get variety =>
      $composableBuilder(column: $table.variety, builder: (column) => column);

  GeneratedColumn<double> get wageGraft =>
      $composableBuilder(column: $table.wageGraft, builder: (column) => column);

  GeneratedColumn<double> get wageBag =>
      $composableBuilder(column: $table.wageBag, builder: (column) => column);

  GeneratedColumn<double> get budgetLimit => $composableBuilder(
    column: $table.budgetLimit,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get budgetAlertEnabled => $composableBuilder(
    column: $table.budgetAlertEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<double> get budgetAlertThreshold => $composableBuilder(
    column: $table.budgetAlertThreshold,
    builder: (column) => column,
  );

  Expression<T> dailyLogsRefs<T extends Object>(
    Expression<T> Function($$DailyLogsTableAnnotationComposer a) f,
  ) {
    final $$DailyLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dailyLogs,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> scionBatchesRefs<T extends Object>(
    Expression<T> Function($$ScionBatchesTableAnnotationComposer a) f,
  ) {
    final $$ScionBatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scionBatches,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScionBatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.scionBatches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> reminderSettingsRefs<T extends Object>(
    Expression<T> Function($$ReminderSettingsTableAnnotationComposer a) f,
  ) {
    final $$ReminderSettingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminderSettings,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReminderSettingsTableAnnotationComposer(
            $db: $db,
            $table: $db.reminderSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProjectsTable,
          Project,
          $$ProjectsTableFilterComposer,
          $$ProjectsTableOrderingComposer,
          $$ProjectsTableAnnotationComposer,
          $$ProjectsTableCreateCompanionBuilder,
          $$ProjectsTableUpdateCompanionBuilder,
          (Project, $$ProjectsTableReferences),
          Project,
          PrefetchHooks Function({
            bool dailyLogsRefs,
            bool scionBatchesRefs,
            bool reminderSettingsRefs,
          })
        > {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<String> variety = const Value.absent(),
                Value<double> wageGraft = const Value.absent(),
                Value<double> wageBag = const Value.absent(),
                Value<double?> budgetLimit = const Value.absent(),
                Value<bool> budgetAlertEnabled = const Value.absent(),
                Value<double> budgetAlertThreshold = const Value.absent(),
              }) => ProjectsCompanion(
                id: id,
                year: year,
                variety: variety,
                wageGraft: wageGraft,
                wageBag: wageBag,
                budgetLimit: budgetLimit,
                budgetAlertEnabled: budgetAlertEnabled,
                budgetAlertThreshold: budgetAlertThreshold,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> year = const Value.absent(),
                Value<String> variety = const Value.absent(),
                required double wageGraft,
                required double wageBag,
                Value<double?> budgetLimit = const Value.absent(),
                Value<bool> budgetAlertEnabled = const Value.absent(),
                Value<double> budgetAlertThreshold = const Value.absent(),
              }) => ProjectsCompanion.insert(
                id: id,
                year: year,
                variety: variety,
                wageGraft: wageGraft,
                wageBag: wageBag,
                budgetLimit: budgetLimit,
                budgetAlertEnabled: budgetAlertEnabled,
                budgetAlertThreshold: budgetAlertThreshold,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                dailyLogsRefs = false,
                scionBatchesRefs = false,
                reminderSettingsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (dailyLogsRefs) db.dailyLogs,
                    if (scionBatchesRefs) db.scionBatches,
                    if (reminderSettingsRefs) db.reminderSettings,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (dailyLogsRefs)
                        await $_getPrefetchedData<
                          Project,
                          $ProjectsTable,
                          DailyLog
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._dailyLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).dailyLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scionBatchesRefs)
                        await $_getPrefetchedData<
                          Project,
                          $ProjectsTable,
                          ScionBatche
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._scionBatchesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).scionBatchesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (reminderSettingsRefs)
                        await $_getPrefetchedData<
                          Project,
                          $ProjectsTable,
                          ReminderSetting
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._reminderSettingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).reminderSettingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.projectId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProjectsTable,
      Project,
      $$ProjectsTableFilterComposer,
      $$ProjectsTableOrderingComposer,
      $$ProjectsTableAnnotationComposer,
      $$ProjectsTableCreateCompanionBuilder,
      $$ProjectsTableUpdateCompanionBuilder,
      (Project, $$ProjectsTableReferences),
      Project,
      PrefetchHooks Function({
        bool dailyLogsRefs,
        bool scionBatchesRefs,
        bool reminderSettingsRefs,
      })
    >;
typedef $$DailyLogsTableCreateCompanionBuilder =
    DailyLogsCompanion Function({
      Value<int> id,
      required int projectId,
      required DateTime date,
      required int dayNumber,
      required String area,
      required String weather,
      Value<int?> scionBatchId,
      Value<int> graftingCount,
      Value<int> baggingCount,
      Value<double> laborCost,
      Value<double> materialCost,
      Value<double> totalCost,
      Value<String?> materialNotes,
      Value<String?> notes,
      Value<int> importanceLevel,
    });
typedef $$DailyLogsTableUpdateCompanionBuilder =
    DailyLogsCompanion Function({
      Value<int> id,
      Value<int> projectId,
      Value<DateTime> date,
      Value<int> dayNumber,
      Value<String> area,
      Value<String> weather,
      Value<int?> scionBatchId,
      Value<int> graftingCount,
      Value<int> baggingCount,
      Value<double> laborCost,
      Value<double> materialCost,
      Value<double> totalCost,
      Value<String?> materialNotes,
      Value<String?> notes,
      Value<int> importanceLevel,
    });

final class $$DailyLogsTableReferences
    extends BaseReferences<_$AppDatabase, $DailyLogsTable, DailyLog> {
  $$DailyLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias(
        $_aliasNameGenerator(db.dailyLogs.projectId, db.projects.id),
      );

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<int>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ActionsTable, List<Action>> _actionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.actions,
    aliasName: $_aliasNameGenerator(db.dailyLogs.id, db.actions.dailyLogId),
  );

  $$ActionsTableProcessedTableManager get actionsRefs {
    final manager = $$ActionsTableTableManager(
      $_db,
      $_db.actions,
    ).filter((f) => f.dailyLogId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_actionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GraftStatusTable, List<GraftStatusData>>
  _graftStatusRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.graftStatus,
    aliasName: $_aliasNameGenerator(db.dailyLogs.id, db.graftStatus.dailyLogId),
  );

  $$GraftStatusTableProcessedTableManager get graftStatusRefs {
    final manager = $$GraftStatusTableTableManager(
      $_db,
      $_db.graftStatus,
    ).filter((f) => f.dailyLogId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_graftStatusRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DailyLogsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyLogsTable> {
  $$DailyLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weather => $composableBuilder(
    column: $table.weather,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scionBatchId => $composableBuilder(
    column: $table.scionBatchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get graftingCount => $composableBuilder(
    column: $table.graftingCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baggingCount => $composableBuilder(
    column: $table.baggingCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get laborCost => $composableBuilder(
    column: $table.laborCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get materialCost => $composableBuilder(
    column: $table.materialCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get materialNotes => $composableBuilder(
    column: $table.materialNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get importanceLevel => $composableBuilder(
    column: $table.importanceLevel,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> actionsRefs(
    Expression<bool> Function($$ActionsTableFilterComposer f) f,
  ) {
    final $$ActionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.actions,
      getReferencedColumn: (t) => t.dailyLogId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActionsTableFilterComposer(
            $db: $db,
            $table: $db.actions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> graftStatusRefs(
    Expression<bool> Function($$GraftStatusTableFilterComposer f) f,
  ) {
    final $$GraftStatusTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.graftStatus,
      getReferencedColumn: (t) => t.dailyLogId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GraftStatusTableFilterComposer(
            $db: $db,
            $table: $db.graftStatus,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DailyLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyLogsTable> {
  $$DailyLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayNumber => $composableBuilder(
    column: $table.dayNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weather => $composableBuilder(
    column: $table.weather,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scionBatchId => $composableBuilder(
    column: $table.scionBatchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get graftingCount => $composableBuilder(
    column: $table.graftingCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baggingCount => $composableBuilder(
    column: $table.baggingCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get laborCost => $composableBuilder(
    column: $table.laborCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get materialCost => $composableBuilder(
    column: $table.materialCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalCost => $composableBuilder(
    column: $table.totalCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get materialNotes => $composableBuilder(
    column: $table.materialNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get importanceLevel => $composableBuilder(
    column: $table.importanceLevel,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DailyLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyLogsTable> {
  $$DailyLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get dayNumber =>
      $composableBuilder(column: $table.dayNumber, builder: (column) => column);

  GeneratedColumn<String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<String> get weather =>
      $composableBuilder(column: $table.weather, builder: (column) => column);

  GeneratedColumn<int> get scionBatchId => $composableBuilder(
    column: $table.scionBatchId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get graftingCount => $composableBuilder(
    column: $table.graftingCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get baggingCount => $composableBuilder(
    column: $table.baggingCount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get laborCost =>
      $composableBuilder(column: $table.laborCost, builder: (column) => column);

  GeneratedColumn<double> get materialCost => $composableBuilder(
    column: $table.materialCost,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalCost =>
      $composableBuilder(column: $table.totalCost, builder: (column) => column);

  GeneratedColumn<String> get materialNotes => $composableBuilder(
    column: $table.materialNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get importanceLevel => $composableBuilder(
    column: $table.importanceLevel,
    builder: (column) => column,
  );

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> actionsRefs<T extends Object>(
    Expression<T> Function($$ActionsTableAnnotationComposer a) f,
  ) {
    final $$ActionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.actions,
      getReferencedColumn: (t) => t.dailyLogId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActionsTableAnnotationComposer(
            $db: $db,
            $table: $db.actions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> graftStatusRefs<T extends Object>(
    Expression<T> Function($$GraftStatusTableAnnotationComposer a) f,
  ) {
    final $$GraftStatusTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.graftStatus,
      getReferencedColumn: (t) => t.dailyLogId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GraftStatusTableAnnotationComposer(
            $db: $db,
            $table: $db.graftStatus,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DailyLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyLogsTable,
          DailyLog,
          $$DailyLogsTableFilterComposer,
          $$DailyLogsTableOrderingComposer,
          $$DailyLogsTableAnnotationComposer,
          $$DailyLogsTableCreateCompanionBuilder,
          $$DailyLogsTableUpdateCompanionBuilder,
          (DailyLog, $$DailyLogsTableReferences),
          DailyLog,
          PrefetchHooks Function({
            bool projectId,
            bool actionsRefs,
            bool graftStatusRefs,
          })
        > {
  $$DailyLogsTableTableManager(_$AppDatabase db, $DailyLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> projectId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> dayNumber = const Value.absent(),
                Value<String> area = const Value.absent(),
                Value<String> weather = const Value.absent(),
                Value<int?> scionBatchId = const Value.absent(),
                Value<int> graftingCount = const Value.absent(),
                Value<int> baggingCount = const Value.absent(),
                Value<double> laborCost = const Value.absent(),
                Value<double> materialCost = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<String?> materialNotes = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> importanceLevel = const Value.absent(),
              }) => DailyLogsCompanion(
                id: id,
                projectId: projectId,
                date: date,
                dayNumber: dayNumber,
                area: area,
                weather: weather,
                scionBatchId: scionBatchId,
                graftingCount: graftingCount,
                baggingCount: baggingCount,
                laborCost: laborCost,
                materialCost: materialCost,
                totalCost: totalCost,
                materialNotes: materialNotes,
                notes: notes,
                importanceLevel: importanceLevel,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int projectId,
                required DateTime date,
                required int dayNumber,
                required String area,
                required String weather,
                Value<int?> scionBatchId = const Value.absent(),
                Value<int> graftingCount = const Value.absent(),
                Value<int> baggingCount = const Value.absent(),
                Value<double> laborCost = const Value.absent(),
                Value<double> materialCost = const Value.absent(),
                Value<double> totalCost = const Value.absent(),
                Value<String?> materialNotes = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> importanceLevel = const Value.absent(),
              }) => DailyLogsCompanion.insert(
                id: id,
                projectId: projectId,
                date: date,
                dayNumber: dayNumber,
                area: area,
                weather: weather,
                scionBatchId: scionBatchId,
                graftingCount: graftingCount,
                baggingCount: baggingCount,
                laborCost: laborCost,
                materialCost: materialCost,
                totalCost: totalCost,
                materialNotes: materialNotes,
                notes: notes,
                importanceLevel: importanceLevel,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DailyLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                projectId = false,
                actionsRefs = false,
                graftStatusRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (actionsRefs) db.actions,
                    if (graftStatusRefs) db.graftStatus,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (projectId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.projectId,
                                    referencedTable: $$DailyLogsTableReferences
                                        ._projectIdTable(db),
                                    referencedColumn: $$DailyLogsTableReferences
                                        ._projectIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (actionsRefs)
                        await $_getPrefetchedData<
                          DailyLog,
                          $DailyLogsTable,
                          Action
                        >(
                          currentTable: table,
                          referencedTable: $$DailyLogsTableReferences
                              ._actionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DailyLogsTableReferences(
                                db,
                                table,
                                p0,
                              ).actionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dailyLogId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (graftStatusRefs)
                        await $_getPrefetchedData<
                          DailyLog,
                          $DailyLogsTable,
                          GraftStatusData
                        >(
                          currentTable: table,
                          referencedTable: $$DailyLogsTableReferences
                              ._graftStatusRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DailyLogsTableReferences(
                                db,
                                table,
                                p0,
                              ).graftStatusRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.dailyLogId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DailyLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyLogsTable,
      DailyLog,
      $$DailyLogsTableFilterComposer,
      $$DailyLogsTableOrderingComposer,
      $$DailyLogsTableAnnotationComposer,
      $$DailyLogsTableCreateCompanionBuilder,
      $$DailyLogsTableUpdateCompanionBuilder,
      (DailyLog, $$DailyLogsTableReferences),
      DailyLog,
      PrefetchHooks Function({
        bool projectId,
        bool actionsRefs,
        bool graftStatusRefs,
      })
    >;
typedef $$ActionsTableCreateCompanionBuilder =
    ActionsCompanion Function({
      Value<int> id,
      required int dailyLogId,
      required String type,
      required String itemName,
    });
typedef $$ActionsTableUpdateCompanionBuilder =
    ActionsCompanion Function({
      Value<int> id,
      Value<int> dailyLogId,
      Value<String> type,
      Value<String> itemName,
    });

final class $$ActionsTableReferences
    extends BaseReferences<_$AppDatabase, $ActionsTable, Action> {
  $$ActionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DailyLogsTable _dailyLogIdTable(_$AppDatabase db) =>
      db.dailyLogs.createAlias(
        $_aliasNameGenerator(db.actions.dailyLogId, db.dailyLogs.id),
      );

  $$DailyLogsTableProcessedTableManager get dailyLogId {
    final $_column = $_itemColumn<int>('daily_log_id')!;

    final manager = $$DailyLogsTableTableManager(
      $_db,
      $_db.dailyLogs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dailyLogIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ActionsTableFilterComposer
    extends Composer<_$AppDatabase, $ActionsTable> {
  $$ActionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnFilters(column),
  );

  $$DailyLogsTableFilterComposer get dailyLogId {
    final $$DailyLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyLogId,
      referencedTable: $db.dailyLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyLogsTableFilterComposer(
            $db: $db,
            $table: $db.dailyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ActionsTable> {
  $$ActionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnOrderings(column),
  );

  $$DailyLogsTableOrderingComposer get dailyLogId {
    final $$DailyLogsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyLogId,
      referencedTable: $db.dailyLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyLogsTableOrderingComposer(
            $db: $db,
            $table: $db.dailyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActionsTable> {
  $$ActionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get itemName =>
      $composableBuilder(column: $table.itemName, builder: (column) => column);

  $$DailyLogsTableAnnotationComposer get dailyLogId {
    final $$DailyLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyLogId,
      referencedTable: $db.dailyLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActionsTable,
          Action,
          $$ActionsTableFilterComposer,
          $$ActionsTableOrderingComposer,
          $$ActionsTableAnnotationComposer,
          $$ActionsTableCreateCompanionBuilder,
          $$ActionsTableUpdateCompanionBuilder,
          (Action, $$ActionsTableReferences),
          Action,
          PrefetchHooks Function({bool dailyLogId})
        > {
  $$ActionsTableTableManager(_$AppDatabase db, $ActionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> dailyLogId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> itemName = const Value.absent(),
              }) => ActionsCompanion(
                id: id,
                dailyLogId: dailyLogId,
                type: type,
                itemName: itemName,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int dailyLogId,
                required String type,
                required String itemName,
              }) => ActionsCompanion.insert(
                id: id,
                dailyLogId: dailyLogId,
                type: type,
                itemName: itemName,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ActionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dailyLogId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (dailyLogId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.dailyLogId,
                                referencedTable: $$ActionsTableReferences
                                    ._dailyLogIdTable(db),
                                referencedColumn: $$ActionsTableReferences
                                    ._dailyLogIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ActionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActionsTable,
      Action,
      $$ActionsTableFilterComposer,
      $$ActionsTableOrderingComposer,
      $$ActionsTableAnnotationComposer,
      $$ActionsTableCreateCompanionBuilder,
      $$ActionsTableUpdateCompanionBuilder,
      (Action, $$ActionsTableReferences),
      Action,
      PrefetchHooks Function({bool dailyLogId})
    >;
typedef $$ScionBatchesTableCreateCompanionBuilder =
    ScionBatchesCompanion Function({
      Value<int> id,
      required int projectId,
      required DateTime deliveryDate,
      required String batchName,
      Value<int?> quantity,
      Value<String> sourceType,
      Value<String?> supplierName,
      Value<String?> supplierContact,
      Value<DateTime?> harvestDate,
      Value<DateTime?> coldStorageStartDate,
      Value<int?> coldStorageDays,
      Value<double?> unitPrice,
      Value<double?> totalPrice,
      Value<String?> qualityRating,
      Value<String?> notes,
    });
typedef $$ScionBatchesTableUpdateCompanionBuilder =
    ScionBatchesCompanion Function({
      Value<int> id,
      Value<int> projectId,
      Value<DateTime> deliveryDate,
      Value<String> batchName,
      Value<int?> quantity,
      Value<String> sourceType,
      Value<String?> supplierName,
      Value<String?> supplierContact,
      Value<DateTime?> harvestDate,
      Value<DateTime?> coldStorageStartDate,
      Value<int?> coldStorageDays,
      Value<double?> unitPrice,
      Value<double?> totalPrice,
      Value<String?> qualityRating,
      Value<String?> notes,
    });

final class $$ScionBatchesTableReferences
    extends BaseReferences<_$AppDatabase, $ScionBatchesTable, ScionBatche> {
  $$ScionBatchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias(
        $_aliasNameGenerator(db.scionBatches.projectId, db.projects.id),
      );

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<int>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScionBatchesTableFilterComposer
    extends Composer<_$AppDatabase, $ScionBatchesTable> {
  $$ScionBatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deliveryDate => $composableBuilder(
    column: $table.deliveryDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batchName => $composableBuilder(
    column: $table.batchName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get supplierContact => $composableBuilder(
    column: $table.supplierContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get harvestDate => $composableBuilder(
    column: $table.harvestDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get coldStorageStartDate => $composableBuilder(
    column: $table.coldStorageStartDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get coldStorageDays => $composableBuilder(
    column: $table.coldStorageDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get qualityRating => $composableBuilder(
    column: $table.qualityRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScionBatchesTableOrderingComposer
    extends Composer<_$AppDatabase, $ScionBatchesTable> {
  $$ScionBatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deliveryDate => $composableBuilder(
    column: $table.deliveryDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batchName => $composableBuilder(
    column: $table.batchName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get supplierContact => $composableBuilder(
    column: $table.supplierContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get harvestDate => $composableBuilder(
    column: $table.harvestDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get coldStorageStartDate => $composableBuilder(
    column: $table.coldStorageStartDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get coldStorageDays => $composableBuilder(
    column: $table.coldStorageDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get qualityRating => $composableBuilder(
    column: $table.qualityRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScionBatchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScionBatchesTable> {
  $$ScionBatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get deliveryDate => $composableBuilder(
    column: $table.deliveryDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get batchName =>
      $composableBuilder(column: $table.batchName, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supplierName => $composableBuilder(
    column: $table.supplierName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get supplierContact => $composableBuilder(
    column: $table.supplierContact,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get harvestDate => $composableBuilder(
    column: $table.harvestDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get coldStorageStartDate => $composableBuilder(
    column: $table.coldStorageStartDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get coldStorageDays => $composableBuilder(
    column: $table.coldStorageDays,
    builder: (column) => column,
  );

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get qualityRating => $composableBuilder(
    column: $table.qualityRating,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScionBatchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScionBatchesTable,
          ScionBatche,
          $$ScionBatchesTableFilterComposer,
          $$ScionBatchesTableOrderingComposer,
          $$ScionBatchesTableAnnotationComposer,
          $$ScionBatchesTableCreateCompanionBuilder,
          $$ScionBatchesTableUpdateCompanionBuilder,
          (ScionBatche, $$ScionBatchesTableReferences),
          ScionBatche,
          PrefetchHooks Function({bool projectId})
        > {
  $$ScionBatchesTableTableManager(_$AppDatabase db, $ScionBatchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScionBatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScionBatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScionBatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> projectId = const Value.absent(),
                Value<DateTime> deliveryDate = const Value.absent(),
                Value<String> batchName = const Value.absent(),
                Value<int?> quantity = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String?> supplierName = const Value.absent(),
                Value<String?> supplierContact = const Value.absent(),
                Value<DateTime?> harvestDate = const Value.absent(),
                Value<DateTime?> coldStorageStartDate = const Value.absent(),
                Value<int?> coldStorageDays = const Value.absent(),
                Value<double?> unitPrice = const Value.absent(),
                Value<double?> totalPrice = const Value.absent(),
                Value<String?> qualityRating = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => ScionBatchesCompanion(
                id: id,
                projectId: projectId,
                deliveryDate: deliveryDate,
                batchName: batchName,
                quantity: quantity,
                sourceType: sourceType,
                supplierName: supplierName,
                supplierContact: supplierContact,
                harvestDate: harvestDate,
                coldStorageStartDate: coldStorageStartDate,
                coldStorageDays: coldStorageDays,
                unitPrice: unitPrice,
                totalPrice: totalPrice,
                qualityRating: qualityRating,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int projectId,
                required DateTime deliveryDate,
                required String batchName,
                Value<int?> quantity = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String?> supplierName = const Value.absent(),
                Value<String?> supplierContact = const Value.absent(),
                Value<DateTime?> harvestDate = const Value.absent(),
                Value<DateTime?> coldStorageStartDate = const Value.absent(),
                Value<int?> coldStorageDays = const Value.absent(),
                Value<double?> unitPrice = const Value.absent(),
                Value<double?> totalPrice = const Value.absent(),
                Value<String?> qualityRating = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => ScionBatchesCompanion.insert(
                id: id,
                projectId: projectId,
                deliveryDate: deliveryDate,
                batchName: batchName,
                quantity: quantity,
                sourceType: sourceType,
                supplierName: supplierName,
                supplierContact: supplierContact,
                harvestDate: harvestDate,
                coldStorageStartDate: coldStorageStartDate,
                coldStorageDays: coldStorageDays,
                unitPrice: unitPrice,
                totalPrice: totalPrice,
                qualityRating: qualityRating,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ScionBatchesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.projectId,
                                referencedTable: $$ScionBatchesTableReferences
                                    ._projectIdTable(db),
                                referencedColumn: $$ScionBatchesTableReferences
                                    ._projectIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ScionBatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScionBatchesTable,
      ScionBatche,
      $$ScionBatchesTableFilterComposer,
      $$ScionBatchesTableOrderingComposer,
      $$ScionBatchesTableAnnotationComposer,
      $$ScionBatchesTableCreateCompanionBuilder,
      $$ScionBatchesTableUpdateCompanionBuilder,
      (ScionBatche, $$ScionBatchesTableReferences),
      ScionBatche,
      PrefetchHooks Function({bool projectId})
    >;
typedef $$GraftStatusTableCreateCompanionBuilder =
    GraftStatusCompanion Function({
      Value<int> id,
      required int dailyLogId,
      required DateTime recordDate,
      required String status,
      Value<int> count,
      Value<String?> notes,
    });
typedef $$GraftStatusTableUpdateCompanionBuilder =
    GraftStatusCompanion Function({
      Value<int> id,
      Value<int> dailyLogId,
      Value<DateTime> recordDate,
      Value<String> status,
      Value<int> count,
      Value<String?> notes,
    });

final class $$GraftStatusTableReferences
    extends BaseReferences<_$AppDatabase, $GraftStatusTable, GraftStatusData> {
  $$GraftStatusTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DailyLogsTable _dailyLogIdTable(_$AppDatabase db) =>
      db.dailyLogs.createAlias(
        $_aliasNameGenerator(db.graftStatus.dailyLogId, db.dailyLogs.id),
      );

  $$DailyLogsTableProcessedTableManager get dailyLogId {
    final $_column = $_itemColumn<int>('daily_log_id')!;

    final manager = $$DailyLogsTableTableManager(
      $_db,
      $_db.dailyLogs,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dailyLogIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GraftStatusTableFilterComposer
    extends Composer<_$AppDatabase, $GraftStatusTable> {
  $$GraftStatusTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordDate => $composableBuilder(
    column: $table.recordDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$DailyLogsTableFilterComposer get dailyLogId {
    final $$DailyLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyLogId,
      referencedTable: $db.dailyLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyLogsTableFilterComposer(
            $db: $db,
            $table: $db.dailyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GraftStatusTableOrderingComposer
    extends Composer<_$AppDatabase, $GraftStatusTable> {
  $$GraftStatusTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordDate => $composableBuilder(
    column: $table.recordDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$DailyLogsTableOrderingComposer get dailyLogId {
    final $$DailyLogsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyLogId,
      referencedTable: $db.dailyLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyLogsTableOrderingComposer(
            $db: $db,
            $table: $db.dailyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GraftStatusTableAnnotationComposer
    extends Composer<_$AppDatabase, $GraftStatusTable> {
  $$GraftStatusTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get recordDate => $composableBuilder(
    column: $table.recordDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$DailyLogsTableAnnotationComposer get dailyLogId {
    final $$DailyLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.dailyLogId,
      referencedTable: $db.dailyLogs,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DailyLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.dailyLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GraftStatusTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GraftStatusTable,
          GraftStatusData,
          $$GraftStatusTableFilterComposer,
          $$GraftStatusTableOrderingComposer,
          $$GraftStatusTableAnnotationComposer,
          $$GraftStatusTableCreateCompanionBuilder,
          $$GraftStatusTableUpdateCompanionBuilder,
          (GraftStatusData, $$GraftStatusTableReferences),
          GraftStatusData,
          PrefetchHooks Function({bool dailyLogId})
        > {
  $$GraftStatusTableTableManager(_$AppDatabase db, $GraftStatusTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GraftStatusTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GraftStatusTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GraftStatusTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> dailyLogId = const Value.absent(),
                Value<DateTime> recordDate = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => GraftStatusCompanion(
                id: id,
                dailyLogId: dailyLogId,
                recordDate: recordDate,
                status: status,
                count: count,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int dailyLogId,
                required DateTime recordDate,
                required String status,
                Value<int> count = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => GraftStatusCompanion.insert(
                id: id,
                dailyLogId: dailyLogId,
                recordDate: recordDate,
                status: status,
                count: count,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GraftStatusTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({dailyLogId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (dailyLogId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.dailyLogId,
                                referencedTable: $$GraftStatusTableReferences
                                    ._dailyLogIdTable(db),
                                referencedColumn: $$GraftStatusTableReferences
                                    ._dailyLogIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GraftStatusTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GraftStatusTable,
      GraftStatusData,
      $$GraftStatusTableFilterComposer,
      $$GraftStatusTableOrderingComposer,
      $$GraftStatusTableAnnotationComposer,
      $$GraftStatusTableCreateCompanionBuilder,
      $$GraftStatusTableUpdateCompanionBuilder,
      (GraftStatusData, $$GraftStatusTableReferences),
      GraftStatusData,
      PrefetchHooks Function({bool dailyLogId})
    >;
typedef $$ReminderSettingsTableCreateCompanionBuilder =
    ReminderSettingsCompanion Function({
      Value<int> id,
      required int projectId,
      Value<bool> dailyReminderEnabled,
      Value<int> dailyReminderHour,
      Value<int> dailyReminderMinute,
      Value<bool> startDateReminderEnabled,
      Value<bool> endDateReminderEnabled,
      Value<DateTime?> expectedStartDate,
      Value<DateTime?> expectedEndDate,
      Value<bool> rainyDaysAlertEnabled,
      Value<int> consecutiveRainyDaysThreshold,
      Value<bool> lowTempAlertEnabled,
    });
typedef $$ReminderSettingsTableUpdateCompanionBuilder =
    ReminderSettingsCompanion Function({
      Value<int> id,
      Value<int> projectId,
      Value<bool> dailyReminderEnabled,
      Value<int> dailyReminderHour,
      Value<int> dailyReminderMinute,
      Value<bool> startDateReminderEnabled,
      Value<bool> endDateReminderEnabled,
      Value<DateTime?> expectedStartDate,
      Value<DateTime?> expectedEndDate,
      Value<bool> rainyDaysAlertEnabled,
      Value<int> consecutiveRainyDaysThreshold,
      Value<bool> lowTempAlertEnabled,
    });

final class $$ReminderSettingsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ReminderSettingsTable, ReminderSetting> {
  $$ReminderSettingsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias(
        $_aliasNameGenerator(db.reminderSettings.projectId, db.projects.id),
      );

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<int>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReminderSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $ReminderSettingsTable> {
  $$ReminderSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dailyReminderEnabled => $composableBuilder(
    column: $table.dailyReminderEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dailyReminderHour => $composableBuilder(
    column: $table.dailyReminderHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dailyReminderMinute => $composableBuilder(
    column: $table.dailyReminderMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get startDateReminderEnabled => $composableBuilder(
    column: $table.startDateReminderEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get endDateReminderEnabled => $composableBuilder(
    column: $table.endDateReminderEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expectedStartDate => $composableBuilder(
    column: $table.expectedStartDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expectedEndDate => $composableBuilder(
    column: $table.expectedEndDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get rainyDaysAlertEnabled => $composableBuilder(
    column: $table.rainyDaysAlertEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get consecutiveRainyDaysThreshold => $composableBuilder(
    column: $table.consecutiveRainyDaysThreshold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get lowTempAlertEnabled => $composableBuilder(
    column: $table.lowTempAlertEnabled,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReminderSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReminderSettingsTable> {
  $$ReminderSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dailyReminderEnabled => $composableBuilder(
    column: $table.dailyReminderEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dailyReminderHour => $composableBuilder(
    column: $table.dailyReminderHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dailyReminderMinute => $composableBuilder(
    column: $table.dailyReminderMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get startDateReminderEnabled => $composableBuilder(
    column: $table.startDateReminderEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get endDateReminderEnabled => $composableBuilder(
    column: $table.endDateReminderEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expectedStartDate => $composableBuilder(
    column: $table.expectedStartDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expectedEndDate => $composableBuilder(
    column: $table.expectedEndDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get rainyDaysAlertEnabled => $composableBuilder(
    column: $table.rainyDaysAlertEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get consecutiveRainyDaysThreshold => $composableBuilder(
    column: $table.consecutiveRainyDaysThreshold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get lowTempAlertEnabled => $composableBuilder(
    column: $table.lowTempAlertEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReminderSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReminderSettingsTable> {
  $$ReminderSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get dailyReminderEnabled => $composableBuilder(
    column: $table.dailyReminderEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dailyReminderHour => $composableBuilder(
    column: $table.dailyReminderHour,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dailyReminderMinute => $composableBuilder(
    column: $table.dailyReminderMinute,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get startDateReminderEnabled => $composableBuilder(
    column: $table.startDateReminderEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get endDateReminderEnabled => $composableBuilder(
    column: $table.endDateReminderEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expectedStartDate => $composableBuilder(
    column: $table.expectedStartDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expectedEndDate => $composableBuilder(
    column: $table.expectedEndDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get rainyDaysAlertEnabled => $composableBuilder(
    column: $table.rainyDaysAlertEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get consecutiveRainyDaysThreshold => $composableBuilder(
    column: $table.consecutiveRainyDaysThreshold,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get lowTempAlertEnabled => $composableBuilder(
    column: $table.lowTempAlertEnabled,
    builder: (column) => column,
  );

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReminderSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReminderSettingsTable,
          ReminderSetting,
          $$ReminderSettingsTableFilterComposer,
          $$ReminderSettingsTableOrderingComposer,
          $$ReminderSettingsTableAnnotationComposer,
          $$ReminderSettingsTableCreateCompanionBuilder,
          $$ReminderSettingsTableUpdateCompanionBuilder,
          (ReminderSetting, $$ReminderSettingsTableReferences),
          ReminderSetting,
          PrefetchHooks Function({bool projectId})
        > {
  $$ReminderSettingsTableTableManager(
    _$AppDatabase db,
    $ReminderSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReminderSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReminderSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReminderSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> projectId = const Value.absent(),
                Value<bool> dailyReminderEnabled = const Value.absent(),
                Value<int> dailyReminderHour = const Value.absent(),
                Value<int> dailyReminderMinute = const Value.absent(),
                Value<bool> startDateReminderEnabled = const Value.absent(),
                Value<bool> endDateReminderEnabled = const Value.absent(),
                Value<DateTime?> expectedStartDate = const Value.absent(),
                Value<DateTime?> expectedEndDate = const Value.absent(),
                Value<bool> rainyDaysAlertEnabled = const Value.absent(),
                Value<int> consecutiveRainyDaysThreshold = const Value.absent(),
                Value<bool> lowTempAlertEnabled = const Value.absent(),
              }) => ReminderSettingsCompanion(
                id: id,
                projectId: projectId,
                dailyReminderEnabled: dailyReminderEnabled,
                dailyReminderHour: dailyReminderHour,
                dailyReminderMinute: dailyReminderMinute,
                startDateReminderEnabled: startDateReminderEnabled,
                endDateReminderEnabled: endDateReminderEnabled,
                expectedStartDate: expectedStartDate,
                expectedEndDate: expectedEndDate,
                rainyDaysAlertEnabled: rainyDaysAlertEnabled,
                consecutiveRainyDaysThreshold: consecutiveRainyDaysThreshold,
                lowTempAlertEnabled: lowTempAlertEnabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int projectId,
                Value<bool> dailyReminderEnabled = const Value.absent(),
                Value<int> dailyReminderHour = const Value.absent(),
                Value<int> dailyReminderMinute = const Value.absent(),
                Value<bool> startDateReminderEnabled = const Value.absent(),
                Value<bool> endDateReminderEnabled = const Value.absent(),
                Value<DateTime?> expectedStartDate = const Value.absent(),
                Value<DateTime?> expectedEndDate = const Value.absent(),
                Value<bool> rainyDaysAlertEnabled = const Value.absent(),
                Value<int> consecutiveRainyDaysThreshold = const Value.absent(),
                Value<bool> lowTempAlertEnabled = const Value.absent(),
              }) => ReminderSettingsCompanion.insert(
                id: id,
                projectId: projectId,
                dailyReminderEnabled: dailyReminderEnabled,
                dailyReminderHour: dailyReminderHour,
                dailyReminderMinute: dailyReminderMinute,
                startDateReminderEnabled: startDateReminderEnabled,
                endDateReminderEnabled: endDateReminderEnabled,
                expectedStartDate: expectedStartDate,
                expectedEndDate: expectedEndDate,
                rainyDaysAlertEnabled: rainyDaysAlertEnabled,
                consecutiveRainyDaysThreshold: consecutiveRainyDaysThreshold,
                lowTempAlertEnabled: lowTempAlertEnabled,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReminderSettingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.projectId,
                                referencedTable:
                                    $$ReminderSettingsTableReferences
                                        ._projectIdTable(db),
                                referencedColumn:
                                    $$ReminderSettingsTableReferences
                                        ._projectIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReminderSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReminderSettingsTable,
      ReminderSetting,
      $$ReminderSettingsTableFilterComposer,
      $$ReminderSettingsTableOrderingComposer,
      $$ReminderSettingsTableAnnotationComposer,
      $$ReminderSettingsTableCreateCompanionBuilder,
      $$ReminderSettingsTableUpdateCompanionBuilder,
      (ReminderSetting, $$ReminderSettingsTableReferences),
      ReminderSetting,
      PrefetchHooks Function({bool projectId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$DailyLogsTableTableManager get dailyLogs =>
      $$DailyLogsTableTableManager(_db, _db.dailyLogs);
  $$ActionsTableTableManager get actions =>
      $$ActionsTableTableManager(_db, _db.actions);
  $$ScionBatchesTableTableManager get scionBatches =>
      $$ScionBatchesTableTableManager(_db, _db.scionBatches);
  $$GraftStatusTableTableManager get graftStatus =>
      $$GraftStatusTableTableManager(_db, _db.graftStatus);
  $$ReminderSettingsTableTableManager get reminderSettings =>
      $$ReminderSettingsTableTableManager(_db, _db.reminderSettings);
}
