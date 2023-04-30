import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/models/components.dart';
import 'package:todoapp/shared/cubit.dart';
import 'package:todoapp/shared/states.dart';

import '../models/consonants.dart';

class NewTasksScreen extends StatelessWidget {
  NewTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: ((context, state) {
        if (state is AppGetDataBaseLoadingState) {
          print('AppGetDataBaseLoadingState ----> newTasksScreen');
        }
        if (state is AppGetDataBaseState) {
          print('AppGetDataBaseState =======>>>> newTasksScreen');
        }
      }),
      builder: (context, state) {
        var tasks = BlocProvider.of<AppCubit>(context).newtasks;

        return buildScreen(tasks);
      },
    );
  }
}
