
class StationMainFilterTypeModel {
  final String id;
  final String name;

  final String slug;

  StationMainFilterTypeModel({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory StationMainFilterTypeModel.fromJson(Map<String, dynamic> json) {
    return StationMainFilterTypeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
    };
  }
}
