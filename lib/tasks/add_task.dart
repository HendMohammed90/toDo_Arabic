import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_arabic/shared/cubit/app-cubit.dart';
import 'package:todo_arabic/shared/cubit/app-state.dart';

class AddTaskScreen extends StatelessWidget {
  var textData = TextEditingController();
  var timeData = TextEditingController();
  var dateOfData = TextEditingController();
  var formKey = GlobalKey<FormState>();
  // SqlDate databaseInstanse = SqlDate();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..db,
      child: BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
        if (state is AppInsertDatabaseState) {
          Navigator.of(context).pop();
        }
      }, builder: (context, state) {
        return Container(
          color: Color(0xff757575),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 30,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Text(
                    'Add Your Task',
                    style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    // validator: (String? val) {
                    //   if (val!.isEmpty) {
                    //     return 'Write your task';
                    //   }
                    //   return val;
                    // },
                    // textDirection: localized.TextDirection.ltr,
                    controller: textData,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'What We Should Do',
                      suffixIcon: Icon(Icons.task),
                    ),
                    onChanged: (val) {
                      textData.text = val;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    // validator: (String? val) {
                    //   if (val!.isEmpty) {
                    //     return 'Choose your time';
                    //   }
                    //   return val;
                    // },
                    keyboardType: TextInputType.datetime,
                    controller: timeData,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: '00:00:00',
                      suffixIcon: Icon(Icons.lock_clock_sharp),
                    ),
                    onChanged: (val) {
                      timeData.text = val;
                    },
                    onTap: () {
                      print('Time tapped');
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        print(
                          value?.format(context),
                        );
                        timeData.text = value!.format(context);
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    // validator: (String? val) {
                    //   if (val!.isEmpty) {
                    //     return 'Choose your date';
                    //   }
                    //   return val;
                    // },
                    keyboardType: TextInputType.datetime,
                    controller: dateOfData,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Choose your date',
                      suffixIcon: Icon(Icons.date_range),
                    ),
                    onChanged: (val) {
                      dateOfData.text = val;
                    },
                    onTap: () {
                      // print('Date tapped');
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.parse('1990-01-01'),
                        lastDate: DateTime.parse('2022-12-30'),
                      ).then(
                        (value) {
                          print(
                            DateFormat.yMMM().format(value!),
                          );
                          dateOfData.text = DateFormat.yMMM().format(value);
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                      minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: () {
                      // print(newTaskData);
                      // pushTaskItem(newTaskData);
                      // Provider.of<Tasklest>(context, listen: false)
                      //     .addTask(newTaskData);
                      // Navigator.of(context).pop();
                      // if (formKey.currentState!.validate()) {
                      // SqlDate.insertData(
                      //     date: timeData.value,
                      //     title: textData.value,
                      //     time: timeData.value);
                      // Provider.of<Tasklest>(context, listen: false)
                      //     .addTask(textData.value, timeData.value, timeData.value);
                      AppCubit.get(context).insertData(
                          title: textData.text,
                          date: dateOfData.text,
                          time: timeData.text);
                      // databaseInstanse.insertData(
                      //     time: timeData.text,
                      //     title: textData.text,
                      //     date: dateOfData.text);
                      // SqlDate.getSingleData();

                      // }
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
