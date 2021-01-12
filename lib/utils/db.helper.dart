import 'dart:convert';

import 'package:flutter/services.dart';

const String _DB_CONN_FILE_PATH = 'assets/db_connection.json';

Future<Map<String, dynamic>> loadDbConnFile() async {
  String json = await rootBundle.loadString(_DB_CONN_FILE_PATH);
  return jsonDecode(json) as Map<String, dynamic>;
}
