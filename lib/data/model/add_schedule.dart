import 'package:get_jadwal/data/model/detail_schedule.dart';

class AddSchedule {
  AddSchedule({
      this.status, 
      this.message, 
      this.data,});

  AddSchedule.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ScheduleItem.fromJson(json['data']) : null;
  }
  String? status;
  String? message;
  ScheduleItem? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}