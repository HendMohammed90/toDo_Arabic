import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_arabic/shared/cubit/app-cubit.dart';
import 'package:todo_arabic/shared/cubit/app-state.dart';
import 'package:todo_arabic/tasks/add_task.dart';

class HomeLayout extends StatelessWidget {
  Widget buildWidget(context) => AddTaskScreen();
  var scaffoledKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..db,
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titels[cubit.index]),
            ),
            body: cubit.screns[cubit.index],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(context: context, builder: buildWidget);
              },
              child: Icon(Icons.add),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 20.0,
              currentIndex: cubit.index, //the defult is 0
              selectedFontSize: 18.0, //defult 14
              onTap: (ind) {
                cubit.changeIndex(ind);
              },

              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.menu_open), label: 'Menu'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chair_alt_rounded), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archived'),
              ],
            ),
          );
        },
      ),
    );
  }
}
