class GeneralResponse {
  GeneralResponse({
    this.success,
    this.message,
  });

  GeneralResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }

  bool? success;
  String? message;

  GeneralResponse copyWith({
    bool? success,
    String? message,
  }) =>
      GeneralResponse(
        success: success ?? this.success,
        message: message ?? this.message,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }
}
