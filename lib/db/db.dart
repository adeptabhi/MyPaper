import 'dart:convert';
import 'dart:io';
import 'package:mypaper/db/table_name.dart';
import 'package:mypaper/other/msg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as SQL;

class DB {
  int version = 1;
  Database? db;
  static final DB inst = DB();

  Future<void> openDB() async {
    try {
      Directory directory = await getApplicationDocumentsDirectory();
      String path = join(directory.path, 'MyPaper.db');
      if (Platform.isWindows || Platform.isLinux) {
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
        db = await databaseFactory.openDatabase(
          path,
          options: OpenDatabaseOptions(version: version),
        );
      } else {
        db = await SQL.openDatabase(path, version: version);
        logInfo('name', msg: 'call');
      }
      logInfo('DB', msg: '${directory.path}/MyPaper.db');
      await _onCreateTable();
    } catch (ex) {
      logError('DB/openDB', msg: ex);
    }
  }

  Future<void> _onCreateTable() async {
    List<String> sqlList = [
      '${TableName.sets} (id INTEGER, topic TEXT, question TEXT, options TEXT, answer INTEGER, userAnswer INTEGER, path TEXT)',
    ];
    await DB.inst.batchCreateTable(sqlList);
  }

  Future<bool> createTable(String sqlQuery) async {
    try {
      await db!.execute(sqlQuery);
      logSuccess('DB/createTable', msg: 'Table Created');
      return true;
    } catch (ex) {
      logError('DB/createTable', msg: '$ex');
    }
    return false;
  }

  Future<bool> batchCreateTable(List<String> sqlList) async {
    try {
      await db!.transaction((txn) async {
        var batch = txn.batch();
        for (String sql in sqlList) {
          batch.execute("CREATE TABLE IF NOT EXISTS $sql");
        }
        await batch.commit();
        logSuccess(
          'DB/batchCreateTable',
          msg: '${sqlList.length} Tables Created',
        );
      });
      return true;
    } catch (ex) {
      logError('DB/batchCreateTable', msg: '$ex');
    }
    return false;
  }

  Future<bool> insert({required String tblName, required dynamic mdl}) async {
    try {
      await db!.insert(
        tblName,
        mdl.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      logSuccess('DB/insert', msg: 'Data Inserted: $tblName');
      return true;
    } catch (ex) {
      logError("DB/insert", msg: '$ex');
    }
    return false;
  }

  Future<bool> batchInsert({
    required String tblName,
    required List<dynamic> mdlList,
  }) async {
    try {
      await db!.transaction((txn) async {
        var batch = txn.batch();
        for (var record in mdlList) {
          batch.insert(
            tblName,
            record.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        await batch.commit();
      });
      logSuccess(
        'DB/batchInsert',
        msg: 'Row:${mdlList.length}, Data Inserted: $tblName',
      );
      return true;
    } catch (ex) {
      logError('DB/batchInsert', msg: '$ex');
    }
    return false;
  }

  Future<bool> update({
    required String tblName,
    required dynamic mdl,
    String? where,
    List? whereArgs,
  }) async {
    try {
      await db!.update(
        tblName,
        mdl.toJson(),
        where: where,
        whereArgs: whereArgs,
      );
      logSuccess('DB/update', msg: 'Data Updated: $tblName');
      return true;
    } catch (ex) {
      logError('DB/update', msg: '$ex');
    }
    return false;
  }

  Future<bool> rawUpdate({required String sqlQuery, required List list}) async {
    try {
      await db!.rawUpdate(sqlQuery, list);
      logSuccess('DB/rawUpdate', msg: 'Data Updated');
      return true;
    } catch (ex) {
      logError('DB/rawUpdate', msg: '$ex');
    }
    return false;
  }

  Future<List> select({
    required String tblName,
    String? where,
    List? whereArgs,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    try {
      final result = await db!.query(
        tblName,
        where: where,
        whereArgs: whereArgs,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
      logInfo('DB/select', msg: jsonEncode(result));
      logSuccess(
        'DB/select',
        msg:
            'Selected $tblName - where:$where whereArgs:$whereArgs rows:${result.length}',
      );
      return result;
    } catch (ex) {
      logError('DB/select', msg: '$ex');
      return [];
    }
  }

  Future<List> rawSelect({
    required String sqlQuery,
    List where = const [],
  }) async {
    List list = [];
    try {
      list = await db!.rawQuery(sqlQuery, where);
      logSuccess('DB/rawSelect', msg: 'Row:${list.length}, Data Selected');
    } catch (ex) {
      logError('Db/rawSelect', msg: '$ex');
    }
    return list;
  }

  Future<bool> delete({
    required String tblName,
    String? where,
    List? whereArgs,
  }) async {
    try {
      await db!.delete(tblName, where: where, whereArgs: whereArgs);
      logError(
        'DB/delete',
        msg: 'Table:$tblName where:$where whereArgs:$whereArgs',
      );
      return true;
    } catch (ex) {
      logError('DB/delete', msg: '$ex');
    }
    return false;
  }

  Future<bool> batchDelete(List<String> tableList) async {
    try {
      await db!.transaction((txn) async {
        var batch = txn.batch();
        for (String tableName in tableList) {
          batch.rawDelete("DELETE FROM $tableName");
        }
        await batch.commit();
        logError('db/batchDelete', msg: 'Deleted Table Data: $tableList');
      });
      return true;
    } catch (ex) {
      logError('db/batchDelete', msg: '$ex');
    }
    return false;
  }

  Future<bool> dropTable(String tblName) async {
    try {
      await db!.rawDelete('DROP TABLE IF EXISTS $tblName');
      logError('DB/dropTable', msg: 'Table Droped: $tblName');
      return true;
    } catch (ex) {
      logError('DB/dropTable', msg: '$ex');
    }
    return false;
  }

  Future<bool> doesTableExist(String tableName) async {
    bool isTable = false;
    try {
      final result = await db!.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'",
      );
      isTable = result.isNotEmpty;
    } catch (ex) {
      logError('DB/doesTableExist', msg: '$ex');
    }
    return isTable;
  }
}
