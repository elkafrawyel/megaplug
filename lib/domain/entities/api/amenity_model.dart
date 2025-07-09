import 'package:megaplug/config/clients/storage/storage_client.dart';

class AmenityModel {
  AmenityModel({
    this.id,
    this.nameEn,
    this.nameAr,
    this.imageUrl,
  });

  AmenityModel.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    imageUrl = json['image_url'];
  }

  num? id;
  String? nameEn;
  String? nameAr;
  String? imageUrl;

  AmenityModel copyWith({
    num? id,
    String? nameEn,
    String? nameAr,
    String? imageUrl,
  }) =>
      AmenityModel(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameAr: nameAr ?? this.nameAr,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['name_ar'] = nameAr;
    map['image_url'] = imageUrl;
    return map;
  }

  @override
  String toString() {
    return StorageClient().isAr() ? nameAr! : nameEn!;
  }
}
