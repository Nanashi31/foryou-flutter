// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ClientesTable extends Clientes with TableInfo<$ClientesTable, Cliente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idClienteMeta = const VerificationMeta(
    'idCliente',
  );
  @override
  late final GeneratedColumn<String> idCliente = GeneratedColumn<String>(
    'id_cliente',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usuarioMeta = const VerificationMeta(
    'usuario',
  );
  @override
  late final GeneratedColumn<String> usuario = GeneratedColumn<String>(
    'usuario',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _telefonoMeta = const VerificationMeta(
    'telefono',
  );
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
    'telefono',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _domicilioMeta = const VerificationMeta(
    'domicilio',
  );
  @override
  late final GeneratedColumn<String> domicilio = GeneratedColumn<String>(
    'domicilio',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correoMeta = const VerificationMeta('correo');
  @override
  late final GeneratedColumn<String> correo = GeneratedColumn<String>(
    'correo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    idCliente,
    nombre,
    usuario,
    telefono,
    domicilio,
    correo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clientes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Cliente> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id_cliente')) {
      context.handle(
        _idClienteMeta,
        idCliente.isAcceptableOrUnknown(data['id_cliente']!, _idClienteMeta),
      );
    } else if (isInserting) {
      context.missing(_idClienteMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('usuario')) {
      context.handle(
        _usuarioMeta,
        usuario.isAcceptableOrUnknown(data['usuario']!, _usuarioMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioMeta);
    }
    if (data.containsKey('telefono')) {
      context.handle(
        _telefonoMeta,
        telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta),
      );
    } else if (isInserting) {
      context.missing(_telefonoMeta);
    }
    if (data.containsKey('domicilio')) {
      context.handle(
        _domicilioMeta,
        domicilio.isAcceptableOrUnknown(data['domicilio']!, _domicilioMeta),
      );
    } else if (isInserting) {
      context.missing(_domicilioMeta);
    }
    if (data.containsKey('correo')) {
      context.handle(
        _correoMeta,
        correo.isAcceptableOrUnknown(data['correo']!, _correoMeta),
      );
    } else if (isInserting) {
      context.missing(_correoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idCliente};
  @override
  Cliente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cliente(
      idCliente: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id_cliente'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      usuario: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario'],
      )!,
      telefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefono'],
      )!,
      domicilio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}domicilio'],
      )!,
      correo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}correo'],
      )!,
    );
  }

  @override
  $ClientesTable createAlias(String alias) {
    return $ClientesTable(attachedDatabase, alias);
  }
}

class Cliente extends DataClass implements Insertable<Cliente> {
  final String idCliente;
  final String nombre;
  final String usuario;
  final String telefono;
  final String domicilio;
  final String correo;
  const Cliente({
    required this.idCliente,
    required this.nombre,
    required this.usuario,
    required this.telefono,
    required this.domicilio,
    required this.correo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id_cliente'] = Variable<String>(idCliente);
    map['nombre'] = Variable<String>(nombre);
    map['usuario'] = Variable<String>(usuario);
    map['telefono'] = Variable<String>(telefono);
    map['domicilio'] = Variable<String>(domicilio);
    map['correo'] = Variable<String>(correo);
    return map;
  }

  ClientesCompanion toCompanion(bool nullToAbsent) {
    return ClientesCompanion(
      idCliente: Value(idCliente),
      nombre: Value(nombre),
      usuario: Value(usuario),
      telefono: Value(telefono),
      domicilio: Value(domicilio),
      correo: Value(correo),
    );
  }

  factory Cliente.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cliente(
      idCliente: serializer.fromJson<String>(json['idCliente']),
      nombre: serializer.fromJson<String>(json['nombre']),
      usuario: serializer.fromJson<String>(json['usuario']),
      telefono: serializer.fromJson<String>(json['telefono']),
      domicilio: serializer.fromJson<String>(json['domicilio']),
      correo: serializer.fromJson<String>(json['correo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idCliente': serializer.toJson<String>(idCliente),
      'nombre': serializer.toJson<String>(nombre),
      'usuario': serializer.toJson<String>(usuario),
      'telefono': serializer.toJson<String>(telefono),
      'domicilio': serializer.toJson<String>(domicilio),
      'correo': serializer.toJson<String>(correo),
    };
  }

  Cliente copyWith({
    String? idCliente,
    String? nombre,
    String? usuario,
    String? telefono,
    String? domicilio,
    String? correo,
  }) => Cliente(
    idCliente: idCliente ?? this.idCliente,
    nombre: nombre ?? this.nombre,
    usuario: usuario ?? this.usuario,
    telefono: telefono ?? this.telefono,
    domicilio: domicilio ?? this.domicilio,
    correo: correo ?? this.correo,
  );
  Cliente copyWithCompanion(ClientesCompanion data) {
    return Cliente(
      idCliente: data.idCliente.present ? data.idCliente.value : this.idCliente,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      usuario: data.usuario.present ? data.usuario.value : this.usuario,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      domicilio: data.domicilio.present ? data.domicilio.value : this.domicilio,
      correo: data.correo.present ? data.correo.value : this.correo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cliente(')
          ..write('idCliente: $idCliente, ')
          ..write('nombre: $nombre, ')
          ..write('usuario: $usuario, ')
          ..write('telefono: $telefono, ')
          ..write('domicilio: $domicilio, ')
          ..write('correo: $correo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(idCliente, nombre, usuario, telefono, domicilio, correo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cliente &&
          other.idCliente == this.idCliente &&
          other.nombre == this.nombre &&
          other.usuario == this.usuario &&
          other.telefono == this.telefono &&
          other.domicilio == this.domicilio &&
          other.correo == this.correo);
}

class ClientesCompanion extends UpdateCompanion<Cliente> {
  final Value<String> idCliente;
  final Value<String> nombre;
  final Value<String> usuario;
  final Value<String> telefono;
  final Value<String> domicilio;
  final Value<String> correo;
  final Value<int> rowid;
  const ClientesCompanion({
    this.idCliente = const Value.absent(),
    this.nombre = const Value.absent(),
    this.usuario = const Value.absent(),
    this.telefono = const Value.absent(),
    this.domicilio = const Value.absent(),
    this.correo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientesCompanion.insert({
    required String idCliente,
    required String nombre,
    required String usuario,
    required String telefono,
    required String domicilio,
    required String correo,
    this.rowid = const Value.absent(),
  }) : idCliente = Value(idCliente),
       nombre = Value(nombre),
       usuario = Value(usuario),
       telefono = Value(telefono),
       domicilio = Value(domicilio),
       correo = Value(correo);
  static Insertable<Cliente> custom({
    Expression<String>? idCliente,
    Expression<String>? nombre,
    Expression<String>? usuario,
    Expression<String>? telefono,
    Expression<String>? domicilio,
    Expression<String>? correo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (idCliente != null) 'id_cliente': idCliente,
      if (nombre != null) 'nombre': nombre,
      if (usuario != null) 'usuario': usuario,
      if (telefono != null) 'telefono': telefono,
      if (domicilio != null) 'domicilio': domicilio,
      if (correo != null) 'correo': correo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientesCompanion copyWith({
    Value<String>? idCliente,
    Value<String>? nombre,
    Value<String>? usuario,
    Value<String>? telefono,
    Value<String>? domicilio,
    Value<String>? correo,
    Value<int>? rowid,
  }) {
    return ClientesCompanion(
      idCliente: idCliente ?? this.idCliente,
      nombre: nombre ?? this.nombre,
      usuario: usuario ?? this.usuario,
      telefono: telefono ?? this.telefono,
      domicilio: domicilio ?? this.domicilio,
      correo: correo ?? this.correo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idCliente.present) {
      map['id_cliente'] = Variable<String>(idCliente.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (usuario.present) {
      map['usuario'] = Variable<String>(usuario.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (domicilio.present) {
      map['domicilio'] = Variable<String>(domicilio.value);
    }
    if (correo.present) {
      map['correo'] = Variable<String>(correo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientesCompanion(')
          ..write('idCliente: $idCliente, ')
          ..write('nombre: $nombre, ')
          ..write('usuario: $usuario, ')
          ..write('telefono: $telefono, ')
          ..write('domicilio: $domicilio, ')
          ..write('correo: $correo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientesTable clientes = $ClientesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [clientes];
}

typedef $$ClientesTableCreateCompanionBuilder =
    ClientesCompanion Function({
      required String idCliente,
      required String nombre,
      required String usuario,
      required String telefono,
      required String domicilio,
      required String correo,
      Value<int> rowid,
    });
typedef $$ClientesTableUpdateCompanionBuilder =
    ClientesCompanion Function({
      Value<String> idCliente,
      Value<String> nombre,
      Value<String> usuario,
      Value<String> telefono,
      Value<String> domicilio,
      Value<String> correo,
      Value<int> rowid,
    });

class $$ClientesTableFilterComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get idCliente => $composableBuilder(
    column: $table.idCliente,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get usuario => $composableBuilder(
    column: $table.usuario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get domicilio => $composableBuilder(
    column: $table.domicilio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get correo => $composableBuilder(
    column: $table.correo,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClientesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get idCliente => $composableBuilder(
    column: $table.idCliente,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get usuario => $composableBuilder(
    column: $table.usuario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get domicilio => $composableBuilder(
    column: $table.domicilio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get correo => $composableBuilder(
    column: $table.correo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get idCliente =>
      $composableBuilder(column: $table.idCliente, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get usuario =>
      $composableBuilder(column: $table.usuario, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get domicilio =>
      $composableBuilder(column: $table.domicilio, builder: (column) => column);

  GeneratedColumn<String> get correo =>
      $composableBuilder(column: $table.correo, builder: (column) => column);
}

class $$ClientesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientesTable,
          Cliente,
          $$ClientesTableFilterComposer,
          $$ClientesTableOrderingComposer,
          $$ClientesTableAnnotationComposer,
          $$ClientesTableCreateCompanionBuilder,
          $$ClientesTableUpdateCompanionBuilder,
          (Cliente, BaseReferences<_$AppDatabase, $ClientesTable, Cliente>),
          Cliente,
          PrefetchHooks Function()
        > {
  $$ClientesTableTableManager(_$AppDatabase db, $ClientesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> idCliente = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> usuario = const Value.absent(),
                Value<String> telefono = const Value.absent(),
                Value<String> domicilio = const Value.absent(),
                Value<String> correo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientesCompanion(
                idCliente: idCliente,
                nombre: nombre,
                usuario: usuario,
                telefono: telefono,
                domicilio: domicilio,
                correo: correo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String idCliente,
                required String nombre,
                required String usuario,
                required String telefono,
                required String domicilio,
                required String correo,
                Value<int> rowid = const Value.absent(),
              }) => ClientesCompanion.insert(
                idCliente: idCliente,
                nombre: nombre,
                usuario: usuario,
                telefono: telefono,
                domicilio: domicilio,
                correo: correo,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClientesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientesTable,
      Cliente,
      $$ClientesTableFilterComposer,
      $$ClientesTableOrderingComposer,
      $$ClientesTableAnnotationComposer,
      $$ClientesTableCreateCompanionBuilder,
      $$ClientesTableUpdateCompanionBuilder,
      (Cliente, BaseReferences<_$AppDatabase, $ClientesTable, Cliente>),
      Cliente,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientesTableTableManager get clientes =>
      $$ClientesTableTableManager(_db, _db.clientes);
}
