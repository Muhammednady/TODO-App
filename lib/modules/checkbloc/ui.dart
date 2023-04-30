import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/modules/checkbloc/provider.dart';

class Check extends StatelessWidget {
  Check({super.key});

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: Drawer(),
        body: ChangeNotifierProvider<Model>(
          create: (BuildContext context) => Model(),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<Model>(
                  builder: (context, model, child) {
                    return FloatingActionButton(
                      onPressed: () {
                        model.plus();
                        //model.counter++;
                       // model.notifyListeners();
                        
                      },
                      child: Icon(Icons.add),
                    );
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                Consumer<Model>(
                  builder: (context, model, child) {
                    return Text(
                      '${model.counter}',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
                    );
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                Consumer<Model>(builder: (BuildContext c, Model m, Widget? w) {
                  return FloatingActionButton(
                    onPressed: () {
                      m.minus();
                      
                    },
                    child: Icon(Icons.remove),
                  );
                })
              ],
            ),
          ),
        ));
  }
}
