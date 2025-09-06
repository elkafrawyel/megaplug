class ContactInfoResponse {
  ContactInfoResponse({
    this.success,
    this.message,
    this.data,
  });

  ContactInfoResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ContactInfoModel.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<ContactInfoModel>? data;

  ContactInfoResponse copyWith({
    bool? success,
    String? message,
    List<ContactInfoModel>? data,
  }) =>
      ContactInfoResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ContactInfoModel {
  ContactInfoModel({
    this.url,
    this.label,
    this.icon,
    this.isPhone,
    this.isWhatsApp,
  });

  ContactInfoModel.fromJson(dynamic json) {
    url = json['url'];
    label = json['label'];
    icon = json['icon'];
    isPhone = json['is_phone'];
    isWhatsApp = json['is_whatsapp'];
  }

  String? url;
  String? label;
  String? icon;
  bool? isPhone;
  bool? isWhatsApp;

  ContactInfoModel copyWith({
    String? url,
    String? label,
    String? icon,
    bool? isPhone,
    bool? isWhatsApp,
  }) =>
      ContactInfoModel(
        url: url ?? this.url,
        label: label ?? this.label,
        icon: icon ?? this.icon,
        isPhone: isPhone ?? this.isPhone,
        isWhatsApp: isWhatsApp ?? this.isWhatsApp,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['label'] = label;
    map['icon'] = icon;
    map['is_phone'] = isPhone;
    map['is_whatsapp'] = isWhatsApp;
    return map;
  }
}
