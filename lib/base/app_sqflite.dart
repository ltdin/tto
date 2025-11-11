import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:news/base/app_helpers.dart';
import 'package:news/constant/number.dart';
import 'package:news/models/article_model.dart';
import 'package:news/models/article_sqlite_model.dart';
import 'package:news/models/zone_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppSqflite {
// make this a singleton class
  AppSqflite._privateConstructor();
  static final AppSqflite instance = AppSqflite._privateConstructor();

  // attributes
  static Database _database;
  static const String _DB_NAME = 'news.db';

  // TABLE
  static const String _NEWS_TABLE = 'newsDetail';
  static const String _LIST_CATEGORY_TABLE = 'listCategory';

  // COLUMN
  static const String _COLUMN_NEWS_ID = 'idNews';
  static const String _COLUMN_TIME_SAVE = 'timeSave';
  static const String _COLUMN_NEWS_DATA = 'data';
  static const String _COLUMN_ID_CATEGORY = 'idCategory';
  static const String _COLUMN_IS_UPDATE = 'isUpdate';
  static const int _DATABASE_VERSION = 4;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();

    return _database;
  }

  _initDatabase() async {
    // path file db
    final path = await getDatabasesPath();

    // open connect db
    return await openDatabase(join(path, _DB_NAME),
        version: _DATABASE_VERSION,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onDowngrade: _onDowngrade);
  }

  // onCreate
  void _onCreate(Database db, int version) async {
    printDebug('Test Create db :  $db');
    // When creating the db, create the table
    await db.execute(
      "CREATE TABLE $_LIST_CATEGORY_TABLE ($_COLUMN_ID_CATEGORY TEXT PRIMARY KEY, content TEXT, isUpdate INTEGER )",
    );
    await db.execute(
        "CREATE TABLE $_NEWS_TABLE ($_COLUMN_NEWS_ID TEXT PRIMARY KEY , $_COLUMN_NEWS_DATA TEXT, $_COLUMN_TIME_SAVE TEXT)");
  }

  // onUpgrade
  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    printDebug('Test Upgrade db :  $db');
    // Upgrade the table
    if (oldVersion < newVersion) {
      db.execute(
          "CREATE TABLE $_NEWS_TABLE ($_COLUMN_NEWS_ID TEXT PRIMARY KEY , $_COLUMN_NEWS_DATA TEXT, $_COLUMN_TIME_SAVE TEXT)");
    }
  }

  // onDowngrade
  void _onDowngrade(Database db, int oldVersion, int newVersion) {
    db.setVersion(oldVersion);
  }

  Future<bool> databaseExists(String path) =>
      databaseFactory.databaseExists(path);

  //  ========  TABLE CATEGORY    ======= //
  Map<String, dynamic> _toJson(List<Article> articles) => {
        'data': List<Article>.from(articles.map((x) => x)),
      };

  // Save list of category
  Future<void> insertListCategory({
    ZoneList zone,
    List<Article> articles,
  }) async {
    final String jsonString = json.encode(_toJson(articles));
    final Database db = await instance.database;
    db.insert(
      _LIST_CATEGORY_TABLE,
      {
        "idCategory": zone.zoneId,
        "content": jsonString,
        "isUpdate": IS_NOT_UPDATE,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    printDebug('Save db local ListCategory : ${zone.name} ');
  }

  // Get list of category from idCategory
  Future<ArticleSqlite> queryListNewsFromIdCategory({String idCategory}) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _LIST_CATEGORY_TABLE,
      where: '$_COLUMN_ID_CATEGORY = ?',
      whereArgs: [idCategory],
    );
    if (maps?.isNotEmpty ?? false) {
      return ArticleSqlite.fromJson(maps[0]);
    } else {
      return null;
    }
  }

  // Update all IsUpdate = True
  Future<void> updateAllIsUpdateTrue() async {
    final Database db = await instance.database;
    await db.update(_LIST_CATEGORY_TABLE, {'$_COLUMN_IS_UPDATE': IS_UPDATE});
  }

  //  ========   TABLE NEWS   ======= //

  // Save news to database
  Future<void> insertNews({Article news}) async {
    final Database db = await instance.database;
    db.insert(
      _NEWS_TABLE,
      {
        '$_COLUMN_NEWS_ID': news.newsId,
        '$_COLUMN_NEWS_DATA': json.encode(news.toJson()),
        '$_COLUMN_TIME_SAVE': DateTime.now().toString(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    printDebug('Insert news to local : ${news?.newsId}');
  }

  // Get all news from database
  Future<List<Article>> queryAllNews() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps =
        await db.query(_NEWS_TABLE, orderBy: '$_COLUMN_TIME_SAVE DESC');

    if (maps?.isNotEmpty ?? false) {
      if (maps.length > 15) {
        for (int i = 15; i < maps.length; i++) {
          final parseJson = json.decode(maps[i]['$_COLUMN_NEWS_DATA']);
          final news = Article.fromJson(parseJson);
          await deleteNewsFromId(idNews: news.newsId);
        }
      }
      return List.generate(
        maps.length,
        (i) => Article.fromJson(json.decode(maps[i]['$_COLUMN_NEWS_DATA'])),
      );
    } else {
      return [];
    }
  }

  // Get news from idNews
  Future<Article> queryNewsFromId(String idNews) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _NEWS_TABLE,
      where: '$_COLUMN_NEWS_ID = ?',
      whereArgs: [idNews],
    );

    return maps[0] != null ? Article.fromJson(maps[0]) : null;
  }

  // Check exist news
  Future<bool> checkExistNewsFromId(String idNews) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      _NEWS_TABLE,
      where: '$_COLUMN_NEWS_ID = ?',
      whereArgs: [idNews],
    );
    if (maps != null && maps.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  // Remove news from id
  Future<void> deleteNewsFromId({@required String idNews}) async {
    final Database db = await instance.database;

    await db.delete(
      _NEWS_TABLE,
      where: '$_COLUMN_NEWS_ID = ?',
      whereArgs: [idNews],
    );
    printDebug('Test delete News from id : $idNews');
  }

  // close
  void close() {
    _database?.close();
  }
}
