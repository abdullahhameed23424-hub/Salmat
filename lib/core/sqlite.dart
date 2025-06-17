import 'package:my_project_new/modules/lessons/models/lesson.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//version was 15 we are testing on
//update to 16
class SqliteHelper {
  static late Database database;

  static Future<void> init() async {
    // Get a location using getDatabasesPath
    // open the database
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'myway.db');
    database = await openDatabase(
      path,
      version: 16,
      onCreate: (Database db, int version) async {
        try {
          await Future.wait([
            db.execute(
                'CREATE TABLE Lesson (id INTEGER PRIMARY KEY,lesson_name TEXT, unit_id INTEGER, unit_name TEXT, subject_id INTEGER, subject_name TEXT,file_size)'),
          ]);
        } catch (error) {
          //
        }
      },
      onUpgrade: (db, oldVersion, newVersion) {},
    );
  }

  static Future<void> insertLesson(
      Lesson lessonModel, String filename, int fileSize) async {
    try {
      await database.transaction((txn) async {
        await txn.rawInsert(
            'INSERT INTO Lesson(id, lesson_name, unit_id, unit_name, subject_id, subject_name,file_size) '
            'VALUES("${lessonModel.id}", "${lessonModel.name}", "${lessonModel.unitId}", "${lessonModel.unitName}",'
            '"${lessonModel.courseId}", "${lessonModel.courseName}",$fileSize)');
      });
    } catch (error) {
      print('error inserting $error');
    }
  }

  static Future<List<Map<String, dynamic>>> getSubjects() async {
    return await database
        .rawQuery('SELECT DISTINCT subject_id,subject_name FROM Lesson');
  }

  static Future<List<Map<String, dynamic>>> getUnits(int subjectId) async {
    return await database.rawQuery(
        'SELECT DISTINCT unit_id, unit_name FROM Lesson WHERE subject_id=$subjectId');
  }

  static Future<List<Map<String, dynamic>>> getLessons(int unitId) async {
    return await database
        .rawQuery('SELECT * FROM Lesson WHERE unit_id=$unitId');
  }

  static Future<List<Map<String, dynamic>>> getLesson(int lessonId) async {
    return await database.rawQuery('SELECT * FROM Lesson WHERE id=$lessonId');
  }

  static Future<void> deleteLesson(int lessonId) async {
    await database.rawDelete('DELETE FROM Lesson WHERE id=$lessonId');
  }
}
