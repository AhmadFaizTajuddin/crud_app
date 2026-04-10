import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/mahasiswa.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), 'mahasiswa.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE mahasiswa(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            nrp TEXT
          )
        ''');
      },
    );
  }

  Future<int> insert(Mahasiswa mhs) async {
    var dbClient = await db;
    return await dbClient.insert("mahasiswa", mhs.toMap());
  }

  Future<List<Mahasiswa>> getAll() async {
    var dbClient = await db;
    var result = await dbClient.query("mahasiswa");

    return result.map((e) => Mahasiswa.fromMap(e)).toList();
  }

  Future<int> update(Mahasiswa mhs) async {
    var dbClient = await db;
    return await dbClient.update(
      "mahasiswa",
      mhs.toMap(),
      where: "id=?",
      whereArgs: [mhs.id],
    );
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      "mahasiswa",
      where: "id=?",
      whereArgs: [id],
    );
  }
}