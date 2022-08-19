class Todo {
  int? id;
  String? title;
  bool? done;

  Todo({required this.id, required this.title, required this.done});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    done = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['done'] = done;
    return data;
  }
}
