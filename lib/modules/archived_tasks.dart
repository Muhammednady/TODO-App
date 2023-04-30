import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/components.dart';
import '../shared/cubit.dart';
import '../shared/states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: ((context, state) {}),
      builder: (context, state) {
        var tasks = BlocProvider.of<AppCubit>(context).archivedtasks;
        return buildScreen(tasks);
      },
    );
  }
}
