class UnreadNotificationsCountResponse {
  UnreadNotificationsCountResponse({
    this.success,
    this.message,
    this.data,
  });

  UnreadNotificationsCountResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? UnreadNotificationsCountModel.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  UnreadNotificationsCountModel? data;

  UnreadNotificationsCountResponse copyWith({
    bool? success,
    String? message,
    UnreadNotificationsCountModel? data,
  }) =>
      UnreadNotificationsCountResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class UnreadNotificationsCountModel {
  UnreadNotificationsCountModel({
    this.unreadCount,
    this.message,
  });

  UnreadNotificationsCountModel.fromJson(dynamic json) {
    unreadCount = json['unread_count'];
    message = json['message'];
  }

  num? unreadCount;
  String? message;

  UnreadNotificationsCountModel copyWith({
    num? unreadCount,
    String? message,
  }) =>
      UnreadNotificationsCountModel(
        unreadCount: unreadCount ?? this.unreadCount,
        message: message ?? this.message,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unread_count'] = unreadCount;
    map['message'] = message;
    return map;
  }
}
