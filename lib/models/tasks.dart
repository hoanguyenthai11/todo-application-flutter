class Task {
  late String id;
  late String title;
  late String note;
  bool isCompleted;
  late String date;
  late String startTime;
  late String endTime;
  late int color;

  Task(
      {required this.id,
      required this.title,
      required this.note,
      this.isCompleted = false,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.color});

  Task.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        note = map['note'],
        isCompleted = map['isCompleted'],
        date = map['date'],
        startTime = map['startTime'],
        endTime = map['endTime'],
        color = map['color'];

  Map toMap() {
    return {
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
    };
  }

  void update() {
    isCompleted = !isCompleted;
  }
}
