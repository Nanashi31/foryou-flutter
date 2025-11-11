import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

class Clientes extends Table {
  TextColumn get idCliente => text()();
  TextColumn get nombre => text()();
  TextColumn get usuario => text()();
  TextColumn get telefono => text()();
  TextColumn get domicilio => text()();
  TextColumn get correo => text()();

  @override
  Set<Column> get primaryKey => {idCliente};
}

@DriftDatabase(tables: [Clientes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
