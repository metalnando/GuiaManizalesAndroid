import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show rootBundle;

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'guia_manizales.db');
    _db = await openDatabase(path, version: 1, onCreate: _crearTables);
    return _db!;
  }

  static Future<void> _crearTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE lugares(
        id TEXT PRIMARY KEY,
        nombre TEXT,
        description TEXT,
        lat REAL,
        lng REAL,
        imagen TEXT
      )
    ''');
    final raw = await rootBundle.loadString('assets/data/lugares.json');
    final List<dynamic> data = jsonDecode(raw);
    for (final lugar in data) {
      await db.insert('lugares', {
        'id': lugar['id'].toString(),
        'nombre': lugar['nombre'],
        'description': lugar['description'],
        'lat': lugar['lat'],
        'lng': lugar['lng'],
        'imagen': lugar['imagen']
      });
    }
  }

  static Future<List<Map<String, dynamic>>> obtenerLugares() async {
    final db = await database;
    return db.query('lugares');
  }
}