import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/cubit.dart';

import '../models/components.dart';
import '../shared/states.dart';

class DoneTasksScreen extends StatelessWidget {
  DoneTasksScreen({super.key}) {}

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AppCubit>(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var tasks = BlocProvider.of<AppCubit>(context).donetasks;
        return buildScreen(tasks);
      },
    );
  }
}
