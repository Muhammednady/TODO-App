import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/modules/checkbloc/bloc.dart';
import 'package:todoapp/modules/checkbloc/provider.dart';

class CheckBloc extends StatelessWidget {
  CheckBloc({super.key});

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(),
        body: BlocProvider(
          create: (context) => CounterCubit(),
          child: BlocConsumer<CounterCubit, CounterStates>(
            listener: (context, state) {
                if(state is CounterInialState) print('initialState');
                if(state is CounterPlusState) print('plusState ${state.counter}');
                if(state is CounterMinusState) print('minusState ${state.counter}');
            },
            builder: (context, state) {
             CounterCubit cc =  BlocProvider.of(context);
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        cc.plus();
                       // cc.counter++; : ui(btn) --->event ----> bloc
                       // cc.emit(CounterPlusState()); :  bloc ---> state ---> ui(text)
                      },
                      child: Icon(Icons.add),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${cc.counter}',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        cc.minus();
                      },
                      child: Icon(Icons.remove),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
