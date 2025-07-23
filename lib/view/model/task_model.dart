class TaskData {
  String? title;
  String? description;

  TaskData({this.title, this.description});

  factory TaskData.fromJson(Map<String, dynamic> json) {
    return TaskData(
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
