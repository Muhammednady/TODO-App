


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sqflite/sqflite.dart';

class Transformer extends StatelessWidget {
  final int id;
  final Database database;
   Transformer({required this.id,required this.database});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
      TextButton(onPressed: (){
        database.rawUpdate('UPDATE tasks SET status = done, WHERE id = $id');

      }, child: Text('turn to Done',style: TextStyle(fontSize: 30),)),
      TextButton(onPressed: (){
        
       database.rawUpdate('UPDATE tasks SET status = archived, WHERE id = $id');

      }, child: Text('turn to Done',style: TextStyle(fontSize: 30))),
    ],),);
  }
}