import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/stations/components/filter/filter_bottom_sheet.dart';
import 'package:megaplug/widgets/app_widgets/app_modal_bottom_sheet.dart';

import '../../../../../../../config/helpers/time_debuncer.dart';
import '../../controller/stations_controller.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StationsController>(
      id: StationsController.searchViewControllerId,
      builder: (stationsController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Res.searchIcon,
                  ),
                  10.pw,
                  Expanded(
                    child: TextField(
                      readOnly: stationsController.mapView,
                      // optional: prevents keyboard from showing
                      onTap: () {
                        if (stationsController.mapView) {
                          stationsController.toggleMapView();
                        }
                      },
                      focusNode: stationsController.searchFocusNode,
                      controller:
                          stationsController.searchTextEditingController,
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: context.kTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                        border: InputBorder.none,
                        hintText: 'search_hint'.tr,
                        hintStyle: TextStyle(
                          color: context.kHintTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        suffixIcon: stationsController
                                .searchTextEditingController.text.isEmpty
                            ? null
                            : GestureDetector(
                                onTap: () {
                                  stationsController.searchTextEditingController
                                      .clear();
                                  stationsController.handleSearchText(text: '');
                                },
                                child: Icon(Icons.clear),
                              ),
                      ),
                      onChanged: (String? value) {
                        if (value == null) {
                          return;
                        }
                        AppTimeDebuncer.instance
                            .debounce(Duration(milliseconds: 1500), () {
                          stationsController.handleSearchText(text: value);
                        });
                      },
                    ),
                  ),
                  10.pw,
                  GestureDetector(
                    onTap: () {
                      stationsController.searchFocusNode.unfocus();
                      if (stationsController.stationFilterApiResult
                          .isFailure()) {
                        stationsController.getStationFilter();
                      }
                      showAppModalBottomSheet(
                        context: context,
                        child: FilterBottomSheet(),
                      );
                    },
                    child: SvgPicture.asset(
                      Res.filterIcon,
                    ),
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
