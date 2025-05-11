import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';

class ConnectorTypeModel {
  ConnectorTypeModel({
    this.id,
    this.nameEn,
    this.nameAr,
    this.image,
    this.symbol,
    this.isDc,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    bool isSelected = false,
  }) : isSelected = isSelected.obs;

  ConnectorTypeModel.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    symbol = json['symbol'];
    isDc = json['is_dc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  num? id;
  String? nameEn;
  String? nameAr;
  String? image;
  String? symbol;
  bool? isDc;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  RxBool isSelected = false.obs;

  ConnectorTypeModel copyWith({
    num? id,
    String? nameEn,
    String? nameAr,
    String? image,
    String? symbol,
    bool? isDc,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) =>
      ConnectorTypeModel(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameAr: nameAr ?? this.nameAr,
        image: image ?? this.image,
        symbol: symbol ?? this.symbol,
        isDc: isDc ?? this.isDc,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['name_ar'] = nameAr;
    map['image'] = image;
    map['symbol'] = symbol;
    map['is_dc'] = isDc;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

  @override
  String toString() {
    return StorageClient().isAr() ? nameAr ?? '' : nameEn ?? '';
  }
}
