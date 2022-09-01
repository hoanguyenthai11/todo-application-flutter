import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/tasks_data.dart';
import '../screens/add_task_page.dart';
import '../styles/constant.dart';
import '../models/tasks.dart';
import '../styles/text_style.dart';
import '../widgets/my_buttons.dart';
import '../widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Task> tasks;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Provider.of<TaskData>(context, listen: false).initSharedPreferences();
  }

  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.list),
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Task Management',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.notifications),
        ],
      ),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          const SizedBox(
            height: 10.0,
          ),
          _showTask(),
        ],
      ),
    );
  }

  _showTask() {
    var dataTask = Provider.of<TaskData>(context);
    return Expanded(
      child: ListView.builder(
        itemCount: dataTask.taskCount,
        itemBuilder: (context, index) {
          Task task = dataTask.tasks[index];
          if (task.date == DateFormat.yMd().format(_selectedDate)) {
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  curve: Curves.bounceIn,
                  child: Row(children: [
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (_) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                height: task.isCompleted
                                    ? MediaQuery.of(context).size.height * 0.20
                                    : MediaQuery.of(context).size.height * 0.30,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    task.isCompleted
                                        ? Container()
                                        : ButtonCustom(
                                            title: 'Task Complete',
                                            bgColor: Colors.blue,
                                            onTap: () {
                                              dataTask.updateTask(
                                                  dataTask.tasks[index]);
                                              Navigator.of(context).pop();
                                            },
                                            txtColor: Colors.white,
                                          ),
                                    ButtonCustom(
                                      title: 'Delete Task',
                                      bgColor: Colors.red,
                                      onTap: () {
                                        final tasks =
                                            dataTask.removeTask(task.id);

                                        Navigator.of(context).pop();
                                      },
                                      txtColor: Colors.white,
                                    ),
                                    ButtonCustom(
                                      title: 'Close',
                                      bgColor: Colors.white,
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      txtColor: Colors.black,
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: TaskTile(dataTask.tasks[index]),
                    ),
                  ]),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, left: 20.0),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: kPrimaryColor,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMd().format(
                    DateTime.now(),
                  ),
                  style: subHeadingStyle.copyWith(color: Colors.grey),
                ),
                const Text(
                  'Today',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          MyButton(
              label: '+ Add Task',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddTaskPage(),
                  ),
                );
              })
        ],
      ),
    );
  }
}

class ButtonCustom extends StatelessWidget {
  final String? title;
  final Color? bgColor;
  final Color? txtColor;
  final Function()? onTap;

  ButtonCustom({this.title, this.txtColor, this.bgColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.height * 0.45,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title!,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: txtColor, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
