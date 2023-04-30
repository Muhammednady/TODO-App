import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/modules/checkbloc/bloc.dart';

import '../models/consonants.dart';
import '../modules/archived_tasks.dart';
import '../modules/done_tasks.dart';
import '../modules/new_tasks.dart';
import '../models/components.dart';
import '../shared/cubit.dart';
import '../shared/states.dart';

class HomeLayout extends StatelessWidget {
  HomeLayout({super.key});

  var scaffoldkey = GlobalKey<ScaffoldState>();

  var formkey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..createDataBase(), //single instance seen by all widgets in subtree(or blocprovider scope)(Dependency injection)
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDataBaseState) {
            Navigator.pop(context);
          }
          if (state is AppGetDataBaseState) {
            print('App Get Data Base State from Home layout SCREEN');
          }
          if (state is AppGetDataBaseLoadingState) {
            print('App Get Data Base ======= Loading ===== State');
          }
          if (state is AppCreateDataBaseState) {
            print('App Create Data Base State ');
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar: AppBar(
              title: Text('${cubit.titles[cubit.itemIndex]}'),
               centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
                child: Icon(cubit.fabIcon),
                onPressed: () {
                  // insertData();
                  if (!cubit.isBottomSheetopen) {
                    scaffoldkey.currentState!
                        .showBottomSheet((context) {
                          return Container(
                            padding: EdgeInsets.all(20),
                            color: Colors.grey[300],
                            child: Form(
                              key: formkey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DefaultTextFormField(
                                      hintText: 'task title',
                                      label: 'task title',
                                      type: TextInputType.text,
                                      controll: titleController,
                                      prefix: Icons.title,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Title cant be empty';
                                        }
                                        return null;
                                      }),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DefaultTextFormField(
                                      hintText: 'task date',
                                      label: 'task date',
                                      onclicked: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2023-05-05'))
                                            .then((value) {
                                          if (value != null) {
                                            String date = DateFormat.yMMMEd()
                                                .format(value);
                                            dateController.text = date;
                                          } else {
                                            AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.info,
                                                body: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Text(
                                                      "Please, pick a date"),
                                                )).show();
                                          }
                                        });
                                      },
                                      type: TextInputType.datetime,
                                      controll: dateController,
                                      prefix: Icons.date_range,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'Date cant be empty';
                                        }
                                        return null;
                                      }),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DefaultTextFormField(
                                      hintText: 'task time',
                                      label: 'task time',
                                      onclicked: () async {
                                        TimeOfDay(hour: 02, minute: 30);

                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          if (value != null) {
                                            timeController.text =
                                                value!.format(context);
                                          } else {
                                            AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.info,
                                                body: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Text(
                                                      "Please, pick a time"),
                                                )).show();
                                          }
                                        });
                                      },
                                      type: TextInputType.datetime,
                                      controll: timeController,
                                      prefix: Icons.watch_later_outlined,
                                      validate: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'time cant be empty';
                                        }
                                        return null;
                                      }),
                                ],
                              ),
                            ),
                          );
                        })
                        .closed
                        .then((value) {
                          cubit.changeBottomSheetState(
                              icon: Icons.edit, issheetshown: false);
                        });

                    cubit.changeBottomSheetState(
                        icon: Icons.add, issheetshown: true);
                  } else {
                    if (formkey.currentState!.validate()) {
                      cubit.insertData(
                          title: titleController.text,
                          time: timeController.text,
                          date: dateController.text);

                      cubit.changeBottomSheetState(
                          icon: Icons.edit, issheetshown: false);
                    }
                  }
                }),
            body: state is AppGetDataBaseLoadingState
                ? Center(child: CircularProgressIndicator(value: 20))
                : cubit.screens[cubit.itemIndex],
            bottomNavigationBar: BottomNavigationBar(
                onTap: (int value) {
                  AppCubit.get(context).changeState(value);

                  BlocProvider.of<AppCubit>(context);
                },
                currentIndex: cubit.itemIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_circle_outline), label: 'Done'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined), label: 'Archived'),
                ]),
          );
        },
      ),
    );
  }
}
