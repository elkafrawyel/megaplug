class ReviewModel {
  ReviewModel({
    this.id,
    this.user,
    this.userName,
    this.rating,
    this.review,
    this.transactionId,
    this.createdAt,
    this.createdAtHuman,
  });

  ReviewModel.fromJson(dynamic json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    userName = json['user_name'];
    rating = json['rating'];
    review = json['review'];
    transactionId = json['transaction_id'];
    createdAt = json['created_at'];
    createdAtHuman = json['created_at_human'];
  }

  num? id;
  User? user;
  String? userName;
  num? rating;
  String? review;
  String? transactionId;
  String? createdAt;
  String? createdAtHuman;

  ReviewModel copyWith({
    num? id,
    User? user,
    String? userName,
    num? rating,
    String? review,
    String? transactionId,
    String? createdAt,
    String? createdAtHuman,
  }) =>
      ReviewModel(
        id: id ?? this.id,
        user: user ?? this.user,
        userName: userName ?? this.userName,
        rating: rating ?? this.rating,
        review: review ?? this.review,
        transactionId: transactionId ?? this.transactionId,
        createdAt: createdAt ?? this.createdAt,
        createdAtHuman: createdAtHuman ?? this.createdAtHuman,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['user_name'] = userName;
    map['rating'] = rating;
    map['review'] = review;
    map['transaction_id'] = transactionId;
    map['created_at'] = createdAt;
    map['created_at_human'] = createdAtHuman;
    return map;
  }
}

class User {
  User({
    this.id,
    this.name,
    this.avatar,
  });

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  num? id;
  String? name;
  String? avatar;

  User copyWith({
    num? id,
    String? name,
    String? avatar,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['avatar'] = avatar;
    return map;
  }
}
