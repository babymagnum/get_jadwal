class TodoItem {
  TodoItem({
      this.total, 
      this.limit, 
      this.skip, 
      this.data,});

  TodoItem.fromJson(dynamic json) {
    total = json['total'];
    limit = json['limit'];
    skip = json['skip'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TodoItemData.fromJson(v));
      });
    }
  }
  int? total;
  int? limit;
  int? skip;
  List<TodoItemData>? data;

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

class TodoItemData {
  TodoItemData({
      this.id, 
      this.title, 
      this.activityGroupId, 
      this.isActive, 
      this.priority,});

  TodoItemData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    activityGroupId = json['activity_group_id'];
    isActive = json['is_active'];
    priority = json['priority'];
  }
  int? id;
  String? title;
  int? activityGroupId;
  int? isActive;
  String? priority;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['activity_group_id'] = activityGroupId;
    map['is_active'] = isActive;
    map['priority'] = priority;
    return map;
  }

}