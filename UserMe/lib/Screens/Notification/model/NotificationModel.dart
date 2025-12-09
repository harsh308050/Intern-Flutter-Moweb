class AllNotifications {
  List<Notifications>? notifications;
  int? total;
  int? skip;
  int? limit;

  AllNotifications({this.notifications, this.total, this.skip, this.limit});

  AllNotifications.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = <Notifications>[];
      json['notifications'].forEach((v) {
        notifications!.add(new Notifications.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] = this.notifications!
          .map((v) => v.toJson())
          .toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }
}

class Notifications {
  int? id;
  String? title;
  String? description;
  String? type;
  String? dateTime;

  Notifications({
    this.id,
    this.title,
    this.description,
    this.type,
    this.dateTime,
  });

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['dateTime'] = this.dateTime;
    return data;
  }
}
