class DetailSchedule {
  DetailSchedule({
      this.status, 
      this.message, 
      this.data,});

  DetailSchedule.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ScheduleItem.fromJson(v));
      });
    }
  }
  String? status;
  String? message;
  List<ScheduleItem>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ScheduleItem {
  ScheduleItem({
      this.id, 
      this.userId, 
      this.title, 
      this.day, 
      this.createdAt, 
      this.updatedAt,});

  ScheduleItem.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    day = json['day'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  int? id;
  String? userId;
  String? title;
  String? day;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['title'] = title;
    map['day'] = day;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    return map;
  }

}