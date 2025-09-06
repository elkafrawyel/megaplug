import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/domain/entities/api/amenity_model.dart';

import '../../config/extension/station_status.dart';

class StationDetailsResponse {
  StationDetailsResponse({
    this.success,
    this.message,
    this.data,
  });

  StationDetailsResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  StationDetailsResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      StationDetailsResponse(
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

class Data {
  Data({
    this.station,
    this.reviews,
  });

  Data.fromJson(dynamic json) {
    station = json['station'] != null ? Station.fromJson(json['station']) : null;
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews?.add(ReviewModel.fromJson(v));
      });
    }
  }

  Station? station;
  List<ReviewModel>? reviews;

  Data copyWith({
    Station? station,
    List<ReviewModel>? reviews,
  }) =>
      Data(
        station: station ?? this.station,
        reviews: reviews ?? this.reviews,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (station != null) {
      map['station'] = station?.toJson();
    }
    if (reviews != null) {
      map['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

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
  dynamic transactionId;
  String? createdAt;
  String? createdAtHuman;

  ReviewModel copyWith({
    num? id,
    User? user,
    String? userName,
    num? rating,
    String? review,
    dynamic transactionId,
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
  dynamic avatar;

  User copyWith({
    num? id,
    String? name,
    dynamic avatar,
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

class Station {
  Station({
    this.id,
    this.nameEn,
    this.nameAr,
    this.image,
    this.images,
    this.status,
    this.addressEn,
    this.addressAr,
    this.location,
    this.averageRating,
    this.totalReviews,
    this.todayWorkingHours,
    this.amenities,
    this.connectors,
  });

  Station.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    status = json['status'];
    addressEn = json['address_en'];
    addressAr = json['address_ar'];
    location = json['location'];
    averageRating = json['average_rating'];
    totalReviews = json['total_reviews'];
    todayWorkingHours = json['today_working_hours'] != null ? TodayWorkingHours.fromJson(json['today_working_hours']) : null;

    if (json['amenities'] != null) {
      amenities = [];
      json['amenities'].forEach((v) {
        amenities?.add(AmenityModel.fromJson(v));
      });
    }

    if (json['connectors'] != null) {
      connectors = [];
      json['connectors'].forEach((v) {
        connectors?.add(ApiConnectorModel.fromJson(v));
      });
    }
  }

  num? id;
  String? nameEn;
  String? nameAr;
  dynamic image;
  List<Images>? images;
  String? status;
  String? addressEn;
  String? addressAr;
  String? location;
  num? averageRating;
  num? totalReviews;
  TodayWorkingHours? todayWorkingHours;
  List<AmenityModel>? amenities;
  List<ApiConnectorModel>? connectors;

  Station copyWith({
    num? id,
    String? nameEn,
    String? nameAr,
    dynamic image,
    List<Images>? images,
    String? status,
    String? addressEn,
    String? addressAr,
    String? location,
    num? averageRating,
    num? totalReviews,
    TodayWorkingHours? todayWorkingHours,
    List<AmenityModel>? amenities,
    List<ApiConnectorModel>? connectors,
  }) =>
      Station(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameAr: nameAr ?? this.nameAr,
        image: image ?? this.image,
        images: images ?? this.images,
        status: status ?? this.status,
        addressEn: addressEn ?? this.addressEn,
        addressAr: addressAr ?? this.addressAr,
        location: location ?? this.location,
        averageRating: averageRating ?? this.averageRating,
        totalReviews: totalReviews ?? this.totalReviews,
        todayWorkingHours: todayWorkingHours ?? this.todayWorkingHours,
        amenities: amenities ?? this.amenities,
        connectors: connectors ?? this.connectors,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['name_ar'] = nameAr;
    map['image'] = image;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['address_en'] = addressEn;
    map['address_ar'] = addressAr;
    map['location'] = location;
    map['average_rating'] = averageRating;
    map['total_reviews'] = totalReviews;
    if (todayWorkingHours != null) {
      map['today_working_hours'] = todayWorkingHours?.toJson();
    }

    if (amenities != null) {
      map['amenities'] = amenities?.map((v) => v.toJson()).toList();
    }
    if (connectors != null) {
      map['connectors'] = connectors?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return StorageClient().isAr() ? nameAr! : nameEn!;
  }

  String address() {
    return StorageClient().isAr() ? addressAr! : addressEn!;
  }

  LatLng latLng() {
    return LatLng(
      double.parse(jsonDecode(location!)['lat'].toString()),
      double.parse(jsonDecode(location!)['lng'].toString()),
    );
  }

  final _available = 'Available';
  final _inUse = 'InUse';
  final _unavailable = 'Unavailable';

  StationStatus getStationStatus() {
    if (status == _available) {
      return StationStatus.available;
    } else if (status == _unavailable) {
      return StationStatus.unavailable;
    } else if (status == _inUse) {
      return StationStatus.inUse;
    } else {
      return StationStatus.area;
    }
  }
}

class TodayWorkingHours {
  TodayWorkingHours({
    this.weekday,
    this.is24Hours,
    this.startTime,
    this.endTime,
    this.isActive,
  });

  TodayWorkingHours.fromJson(dynamic json) {
    weekday = json['weekday'];
    is24Hours = json['is_24_hours'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    isActive = json['is_active'];
  }

  String? weekday;
  bool? is24Hours;
  String? startTime;
  String? endTime;
  bool? isActive;

  TodayWorkingHours copyWith({
    String? weekday,
    bool? is24Hours,
    String? startTime,
    String? endTime,
    bool? isActive,
  }) =>
      TodayWorkingHours(
        weekday: weekday ?? this.weekday,
        is24Hours: is24Hours ?? this.is24Hours,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        isActive: isActive ?? this.isActive,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['weekday'] = weekday;
    map['is_24_hours'] = is24Hours;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    map['is_active'] = isActive;
    return map;
  }
}

class Images {
  Images({
    this.id,
    this.url,
    this.isPrimary,
    this.orderIndex,
  });

  Images.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    isPrimary = json['is_primary'];
    orderIndex = json['order_index'];
  }

  num? id;
  String? url;
  bool? isPrimary;
  num? orderIndex;

  Images copyWith({
    num? id,
    String? url,
    bool? isPrimary,
    num? orderIndex,
  }) =>
      Images(
        id: id ?? this.id,
        url: url ?? this.url,
        isPrimary: isPrimary ?? this.isPrimary,
        orderIndex: orderIndex ?? this.orderIndex,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['is_primary'] = isPrimary;
    map['order_index'] = orderIndex;
    return map;
  }
}

class ApiConnectorModel {
  ApiConnectorModel({
    this.typeName,
    this.typeImage,
    this.status,
    this.count,
    this.powerDisplay,
    this.pricePerKw,
    this.isDc,
    this.connectorIds,
  });

  ApiConnectorModel.fromJson(dynamic json) {
    typeName = json['type_name'];
    typeImage = json['type_image'];
    status = json['status'];
    count = json['count'];
    powerDisplay = json['power_display'];
    pricePerKw = json['price_per_kw'];
    isDc = json['is_dc'];
    connectorIds = json['connector_ids'] != null ? json['connector_ids'].cast<num>() : [];
  }

  String? typeName;
  String? typeImage;
  String? status;
  num? count;
  String? powerDisplay;
  String? pricePerKw;
  bool? isDc;
  List<num>? connectorIds;

  ApiConnectorModel copyWith({
    String? typeName,
    String? typeImage,
    String? status,
    num? count,
    String? powerDisplay,
    String? pricePerKw,
    bool? isDc,
    List<num>? connectorIds,
  }) =>
      ApiConnectorModel(
        typeName: typeName ?? this.typeName,
        typeImage: typeImage ?? this.typeImage,
        status: status ?? this.status,
        count: count ?? this.count,
        powerDisplay: powerDisplay ?? this.powerDisplay,
        pricePerKw: pricePerKw ?? this.pricePerKw,
        isDc: isDc ?? this.isDc,
        connectorIds: connectorIds ?? this.connectorIds,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type_name'] = typeName;
    map['type_image'] = typeImage;
    map['status'] = status;
    map['count'] = count;
    map['power_display'] = powerDisplay;
    map['price_per_kw'] = pricePerKw;
    map['is_dc'] = isDc;
    map['connector_ids'] = connectorIds;
    return map;
  }
}
