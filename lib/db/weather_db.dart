import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_app/data/model/weather.dart';

class WeatherDB{
  static final WeatherDB instance = WeatherDB._init();

  static Database? _database;

  WeatherDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _openDB();
    return _database!;
  }
  
  Future<Database> _openDB() async{
    return openDatabase(
      join(await getDatabasesPath(), 'weather_database.db'),
      onCreate: (db, version) async {
        // return await db.transaction((txn) async {
        //       await txn.execute('''
        //       CREATE TABLE weather_city(id INT PRIMARY KEY, name TEXT)
        //       ''');
        // });
        return db.execute(
          "CREATE TABLE weather_city(id INT PRIMARY KEY, name TEXT)",
        );
      },
      version:1,
    );
  }

  Future<void> insertWeatherCity(Weather weatherCity) async {
    final db = await instance.database;
    await db.insert(
      'weather_city',
      weatherCity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> weatherCity() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('weather_city');

    return List.generate(maps.length, (i) {
      return  maps[i]['name'];}
    );
  }

  Future<void> updateWeatherCity(Weather weatherCity) async {
    final db = await instance.database;
    await db.update(
      'weather_city',
      weatherCity.toMap(),
       where: "id = ?",
      whereArgs: [weatherCity.id],
    );
  }

  Future<void> deleteWeatherCity(int id) async {
    final db = await instance.database;
    await db.delete(
      'weather_city',
       where: "id = ?",
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}