class ConnectorTypeModel {
  final String id;
  final String image;
  final String text;

  bool isSelected;

  ConnectorTypeModel({
    required this.id,
    required this.image,
    required this.text,
    this.isSelected = false,
  });
}
