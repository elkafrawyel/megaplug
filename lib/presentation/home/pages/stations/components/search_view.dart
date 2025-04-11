import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';

import '../../../../../domain/controllers/stations_controller.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StationsController>(
      builder: (stationsController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    Res.searchIcon,
                  ),
                  5.pw,
                  Expanded(
                    child: TextField(
                      controller:
                          stationsController.searchTextEditingController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'search_hint'.tr,
                        hintStyle: TextStyle(
                          color: context.kHintTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )
                      ),
                    ),
                  ),
                  10.pw,
                  SvgPicture.asset(
                    Res.filterIcon,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
