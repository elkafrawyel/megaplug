import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/presentation/station_details/components/amenities_view.dart';
import 'package:megaplug/presentation/station_details/components/reviews_view.dart';

class StationDetailsController extends GetxController {
  static StationDetailsController get to => Get.find<StationDetailsController>();

  List<Widget> pages = [
    SizedBox(),
    AmenitiesView(
      data: [
        'Free Wi-Fi',
        'Free Parking',
        '24/7 Security',
        'Charging Stations',
        'Restrooms',
        'Cafeteria',
        'Waiting Area',
        'Air Conditioning',
        'Pet Friendly',
        'EV Maintenance',
        'Bike Parking',
        'Solar Power',
        'Rest Area',
        'Food Court',
        'ATM',
        'Gift Shop',
        'Car Wash',
        'Lounge',
        'Electric Bike Charging',
        'Public Transport Access',
        'Bike Repair',
        'Water Station',
        'First Aid',
      ],
    ),
    ReviewsView(),
  ];
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;
    update();
  }
}
