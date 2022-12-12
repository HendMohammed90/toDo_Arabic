import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_arabic/models/tasks/task_model.dart';
import 'package:todo_arabic/shared/cubit/app-cubit.dart';
import 'package:todo_arabic/shared/cubit/app-state.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: ListView(
                children: [
                  FutureBuilder(
                      future: cubit.getData(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Task>?> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, i) {
                                return ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      '${snapshot.data![i].id}',
                                      style: const TextStyle(
                                        color: Color(0xFF414770),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    '${snapshot.data![i].title}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xff414770),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  subtitle: Text(
                                    '${snapshot.data![i].data} at ${snapshot.data![i].time}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xfff46036),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: Checkbox(
                                    onChanged: (val) {
                                      snapshot.data![i].status = true;
                                      cubit.update(snapshot.data![i].id, true);
                                      // this.activate();
                                      // setState(() {
                                      //   snapshot.data![i].status = true;
                                      // });
                                    },
                                    value: cubit.status,
                                    activeColor: Color(0xFF171123),
                                  ),
                                );
                              });
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${snapshot.error} occurred',
                              style: TextStyle(fontSize: 18),
                            ),
                          );
                        }
                        return Text("No data to build");
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
