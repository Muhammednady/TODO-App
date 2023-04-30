import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../archived_tasks.dart';
import '../done_tasks.dart';
import '../new_tasks.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterInialState());

  int counter = 0;

  void plus() {
    counter++;
    emit(CounterPlusState(counter));
  }

  void minus() {
    counter--;

    emit(CounterMinusState(counter));
  }
}

abstract class CounterStates {}

//---------------------------------------------------
class CounterInialState extends CounterStates {}

class CounterPlusState extends CounterStates {
  final int counter;

  CounterPlusState(this.counter);
}

class CounterMinusState extends CounterStates {

  final counter;

  CounterMinusState(this.counter);
}


//=========================[Tasks Bloc]===============================================

