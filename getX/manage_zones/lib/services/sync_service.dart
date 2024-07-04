import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:manage_zones/data/constants.dart';
import 'package:manage_zones/data/database.dart';

class SyncService {
  final LocalDatabase _localDatabase = LocalDatabase.instance;

  void startSync() async {
    Timer.periodic(const Duration(seconds: 60), (Timer timer) {
      syncWithServer();
    });
  }

  Future<void> syncWithServer() async {
    final db = await _localDatabase.database;
    final changes = await db.query('changes', orderBy: 'timestamp ASC');

    for (var change in changes) {
      final tableName = change['table_name'].toString();
      final operation = change['operation'].toString();
      final rowId = change['row_id'];
      final rowData = change['row_data'] as Map<String, dynamic>;

      await syncChangeWithServer(tableName, operation, rowData);

      // Remove the change from the log after successful sync
      await db.delete('changes', where: 'id = ?', whereArgs: [change['id']]);
    }
  }

  Future<void> syncChangeWithServer(
      String tableName, String operation, Map<String, dynamic>? data) async {
    final url = Uri.parse("${Api.postZonesUrl}/");

    switch (operation) {
      case 'insert':
        await http.post(url, body: data);
        break;
    }
  }
}
