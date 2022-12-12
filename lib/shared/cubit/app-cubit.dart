import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_arabic/models/tasks/task_model.dart';
import 'package:todo_arabic/shared/cubit/app-state.dart';
import 'package:todo_arabic/tasks/archived_tasks/arshived_tasks.dart';
import 'package:todo_arabic/tasks/done_tasks/done_tasks.dart';
import 'package:todo_arabic/tasks/new_tasks/newTasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  int index = 0;
  List<Widget> screns = [NewTasks(), DoneTasks(), ArchivedTasks()];
  List<dynamic> titels = ['Tasks Home', 'Done Task', 'Archived Task'];
  List<dynamic> main_tasks = [];
  List<dynamic> done_tasks = [];

  // List<dynamic>
  bool status = false;

  static AppCubit get(context) => BlocProvider.of(context);

  void changeIndex(ind) {
    index = ind;
    emit(AppChangeBottomNavBarState());
  }

  static Database? database;

  Future<Database?> get db async {
    if (database == null) {
      database = await initDb();
      return database;
    }
    return database;
  }

  initDb() async {
    String data_base_path = await getDatabasesPath();
    String path = join(data_base_path, '_database.db');
    Database myDb = await openDatabase(path, onCreate: _onCreate, version: 1);
    emit(AppCreateDatabaseState());
    return myDb;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, data TEXT , time TEXT , status TEXT )')
        .then((value) {
      print('Table has been created');
    }).catchError(
      (error) {
        print(
            'Error has been habend while inserting in the data :${error.toString()}');
      },
    );
    print('Data Has been Created');
  }

  Future insertData(
      {@required dynamic title,
      @required dynamic date,
      @required dynamic time}) async {
    // Insert some records in a transaction
    Database? myDb = await db;
    emit(AppGetDatabaseState());
    return await myDb!.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO tasks( title, data , time ) VALUES( "$title","$date" , "$time" )');
      print('inserted1: $id1');
    }).then((value) {
      main_tasks.add(value);
      emit(AppInsertDatabaseState());
      // print(value);
    }).catchError((error) {
      print(
        error.toString(),
      );
    });
  }

  Future<List<Task>?> getData() async {
    Database? myDb = await db;
    var tasks = await myDb!.rawQuery('SELECT * FROM tasks');
    // var result = await tasks.map((e) => Task.fromJson(e)).toList();
    var result;
    main_tasks = [];
    done_tasks = [];
    for (var element in tasks) {
      // print(element);
      if (element['status'] != null) {
        done_tasks.add(element);
        result = done_tasks.map((e) => Task.fromJson(e)).toList();
      } else {
        main_tasks.add(element);
        result = main_tasks.map((e) => Task.fromJson(e)).toList();
      }
    }
    // print(result['id']);
    return result;
  }

  void update(int? id, bool? status) async {
    // Update some record
    Database? myDb = await db;
    myDb!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
      emit(AppUpdateDatabaseState());
      done_tasks.add(value);
      for (var elem in main_tasks) {
        main_tasks.remove(elem[value]);
      }
      print(value);
      // status = true;
      emit(AppUpdateDatabaseState());
      print('updated value is : $value');
    });
  }
}
