class ToDo {
  String? id;
  String? todoTime;
  String? todoTask;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoTime,
    required this.todoTask,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoTime: '07:30', todoTask: 'Morning Exercise', isDone: true),
      ToDo(id: '02', todoTime: '08:00', todoTask: 'Buy Groceries', isDone: true),
      ToDo(id: '03', todoTime: '09:00', todoTask: 'Check Emails', ),
      ToDo(id: '04', todoTime: '09:25', todoTask: 'Team Meeting', ),
      ToDo(id: '05', todoTime: '10:00', todoTask: 'Work on mobile apps for 2 hours', ),
      ToDo(id: '06', todoTime: '21:00', todoTask: 'Dinner with Jenny', ),
    ];
  }
}