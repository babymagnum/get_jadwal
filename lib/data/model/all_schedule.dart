class AllSchedule {
  AllSchedule({
      this.status, 
      this.message, 
      this.data,});

  AllSchedule.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AllScheduleData.fromJson(json['data']) : null;
  }
  String? status;
  String? message;
  AllScheduleData? data;

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

class AllScheduleData {
  AllScheduleData({
      this.monday, 
      this.tuesday, 
      this.wednesday, 
      this.thursday, 
      this.friday,});

  AllScheduleData.fromJson(dynamic json) {
    monday = json['monday'];
    tuesday = json['tuesday'];
    wednesday = json['wednesday'];
    thursday = json['thursday'];
    friday = json['friday'];
  }
  int? monday;
  int? tuesday;
  int? wednesday;
  int? thursday;
  int? friday;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['monday'] = monday;
    map['tuesday'] = tuesday;
    map['wednesday'] = wednesday;
    map['thursday'] = thursday;
    map['friday'] = friday;
    return map;
  }

}