import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/cubit.dart';

Widget DefaultTextFormField({
  required String? hintText,
  required String? label,
  required TextInputType type,
  required TextEditingController? controll,
  void Function()? onclicked,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  void Function()? suffixpressed,
  required String? Function(String?) validate,
}) =>
    TextFormField(
      validator: validate,
      controller: controll,
      obscureText: isPassword,
      keyboardType: type,
      onTap: onclicked,
      decoration: InputDecoration(
        prefixIcon: Icon(prefix),
        hintText: hintText,
        labelText: label,
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixpressed, icon: Icon(suffix))
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget defaultTaskItem(context, {required Map task}) => Dismissible(
  onDismissed: (direction) {
    BlocProvider.of<AppCubit>(context).delete(task['id']);
  },
  key: Key("${task['id']}"),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text('${task['time']}'),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${task['title']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  Text('${task['date']}',
                      style: TextStyle(fontSize: 15, color: Colors.grey))
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateDataInDataBase(status: "done", id: task['id']);

                  AppCubit.get(context)
                      .getDataFromDataBase(AppCubit.get(context).database!);
                },
                icon: Icon(
                  Icons.check_box_rounded,
                  color: Colors.green,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateDataInDataBase(status: "archived", id: task['id']);

                  AppCubit.get(context)
                      .getDataFromDataBase(AppCubit.get(context).database!);
                },
                icon: Icon(
                  Icons.archive_outlined,
                  color: Colors.blue,
                )),
          ],
        ),
      ),
    );


Widget buildScreen(List<Map> tasks)=>  tasks.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.menu,
                      size: 100.0,
                      color: Colors.grey,
                    ),
                    Text(
                      'No tasks yet , please insert some',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900,color: Colors.grey),
                    )
                  ],
                ),
              )
            : ListView.separated(
                itemCount: tasks.length,
                itemBuilder: (context, i) =>
                    defaultTaskItem(context, task: tasks[i]),
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ),
              );