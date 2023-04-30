import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/shared/states.dart';
import 'package:path/path.dart';

import '../modules/archived_tasks.dart';
import '../modules/done_tasks.dart';
import '../modules/new_tasks.dart';

class AppCubit extends Cubit<AppStates> {
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  int itemIndex = 0;
  Database? database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];

  IconData fabIcon = Icons.edit;
  bool isBottomSheetopen = false;

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  void changeState(int index) {
    itemIndex = index; //UI---------> event ---------> bloc

    emit(BottomNavChangeState()); //bloc---------> State ---------> UI
  }

  void changeBottomSheetState(
      {required IconData icon, required bool issheetshown}) {
    fabIcon = icon;
    isBottomSheetopen = issheetshown;

    emit(AppChangeBottomSheetState());
  }

  Future<void> createDataBase() async {
    String path = await getDatabasesPath();
    String fullpath = join(path, 'todo.db');
    openDatabase(
      fullpath,
      version: 1,
      onCreate: (Database db, int version) async {
        print('DataBase created !');

        db
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table tasks created !');
        }).catchError((error) {
          print('error is ${error.toString()}');
        });
      },
      onOpen: (Database db) {
        getDataFromDataBase(db);

        print('Data base opened !');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  void insertData({String? title, String? date, String? time}) async {
    database!.transaction((Transaction txn) async {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value is inserted successfully');
        emit(AppInsertDataBaseState());

        getDataFromDataBase(database!);

        print('tasks from get: $newtasks');

        emit(AppGetDataBaseState());
      }).catchError((error) {
        print('$error is error');
      });
      return null;
    });
  }

  void getDataFromDataBase(Database database) {
    emit(AppGetDataBaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      newtasks = value.where((element) => element['status'] == 'new').toList();
      donetasks =
          value.where((element) => element['status'] == 'done').toList();
      archivedtasks =
          value.where((element) => element['status'] == 'archived').toList();

      emit(AppGetDataBaseState());
    });
  }

  void updateDataInDataBase({required String status, required int id}) {
    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      emit(AppUpdateDataBaseState());
    });

    
  }
   delete(int id) {
      database!
          .rawDelete('DELETE FROM tasks WHERE id = ?', ['$id']).then((value) {
        print('$value is deleted successfully from table tasks');
        emit(AppDeleteDataBaseState());

        getDataFromDataBase(database!);
      });
    }

 
}
