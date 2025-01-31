class Task {
  int? id;
  String? title;
  String? descrption;

  Task({this.id, this.title, this.descrption});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      descrption: json['descrption'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'descrption': descrption,
      };
}
