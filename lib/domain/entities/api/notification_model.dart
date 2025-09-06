class NotificationModel {
  NotificationModel({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  NotificationModel.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    data = json['data'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  String? id;
  String? type;
  String? notifiableType;
  num? notifiableId;
  dynamic data;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  NotificationModel copyWith({
    String? id,
    String? type,
    String? notifiableType,
    num? notifiableId,
    dynamic data,
    String? readAt,
    String? createdAt,
    String? updatedAt,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        type: type ?? this.type,
        notifiableType: notifiableType ?? this.notifiableType,
        notifiableId: notifiableId ?? this.notifiableId,
        data: data ?? this.data,
        readAt: readAt ?? this.readAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['notifiable_type'] = notifiableType;
    map['notifiable_id'] = notifiableId;
    map['data'] = data;
    map['read_at'] = readAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is NotificationModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
