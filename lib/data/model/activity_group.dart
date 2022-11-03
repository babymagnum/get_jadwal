class ActivityGroup {
  ActivityGroup({
      this.total, 
      this.limit, 
      this.skip, 
      this.data,});

  ActivityGroup.fromJson(dynamic json) {
    total = json['total'];
    limit = json['limit'];
    skip = json['skip'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ActivityGroupData.fromJson(v));
      });
    }
  }
  int? total;
  int? limit;
  int? skip;
  List<ActivityGroupData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = total;
    map['limit'] = limit;
    map['skip'] = skip;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ActivityGroupData {
  ActivityGroupData({
      this.id, 
      this.title, 
      this.createdAt,});

  ActivityGroupData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
  }
  int? id;
  String? title;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['created_at'] = createdAt;
    return map;
  }

}