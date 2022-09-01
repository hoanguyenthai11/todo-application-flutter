import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/tasks_data.dart';
import 'package:todo_app/styles/constant.dart';
import 'package:todo_app/styles/text_style.dart';
import 'package:todo_app/widgets/input_form.dart';
import 'package:todo_app/widgets/my_buttons.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedColor = 0;
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Add Task'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputForm(
                title: 'Title',
                hint: 'Enter your title',
                controller: _titleController,
              ),
              InputForm(
                title: 'Note',
                hint: 'Enter your note',
                controller: _noteController,
              ),
              InputForm(
                title: 'Date',
                hint: '${DateFormat.yMd().format(_selectedDate)}',
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputForm(
                      title: 'Start Date',
                      hint: _startTime,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getTimeFromUser(true);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InputForm(
                      title: 'End Date',
                      hint: _endTime,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getTimeFromUser(false);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPalette(),
                  MyButton(
                      label: 'Create Task',
                      onTap: () {
                        _validateDate();
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: titleStyle,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Wrap(
          children: [
            ...List<Widget>.generate(3, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? kFirstColor
                        : index == 1
                            ? kSecondColor
                            : kThirdColor,
                    child: _selectedColor == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16.0,
                          )
                        : null,
                  ),
                ),
              );
            })
          ],
        )
      ],
    );
  }

  _validateDate() async {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      var date = DateFormat.yMd().format(_selectedDate);

      var task = Provider.of<TaskData>(context, listen: false).addTask(
          DateTime.now().toString(),
          _titleController.text,
          _noteController.text,
          _isCompleted,
          date,
          _startTime,
          _endTime,
          _selectedColor);
      Navigator.of(context).pop();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Required',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
          duration: Duration(milliseconds: 1000),
        ),
      );
    }
  }

  void _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    }
  }

  void _getTimeFromUser(bool isStartTime) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print('');
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(':')[0]),
          minute: int.parse(_startTime.split(':')[1].split(' ')[0]),
        ));
  }
}
