import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ConnectorTypeModel {
  final String id;
  final String image;
  final String text;
  RxBool isSelected;

  ConnectorTypeModel({
    required this.id,
    required this.image,
    required this.text,
    bool isSelected = false
   }): isSelected = isSelected.obs;

}
