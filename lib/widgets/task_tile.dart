import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/styles/constant.dart';
import '../models/tasks.dart';

class TaskTile extends StatelessWidget {
  final Task? task;

  TaskTile(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getColor(task?.color ?? 0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task!.title,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${task!.startTime} - ${task!.endTime}',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[100],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  task?.note ?? '',
                  style: GoogleFonts.lato(
                    textStyle:
                        const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 1,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task!.isCompleted ? 'COMPLETED' : 'TODO',
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

_getColor(int index) {
  switch (index) {
    case 0:
      return kFirstColor;
    case 1:
      return kSecondColor;
    case 2:
      return kThirdColor;
    default:
      return kFirstColor;
  }
}
