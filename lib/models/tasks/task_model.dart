class Task {
  int? id;
  String? title;
  String? data;
  String? time;
  bool? status = false;

  Task({this.id, this.title, this.data, this.time, this.status});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    data = json['data'];
    time = json['time'];
    // status = json['status'];
  }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['title'] = this.title;
  //   data['data'] = this.data;
  //   data['time'] = this.time;
  //   data['status'] = this.status;
  //   return data;
  // }
}
