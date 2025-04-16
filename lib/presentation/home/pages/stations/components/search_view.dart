import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/extension/station_filter_type.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/stations/components/filter_bottom_sheet.dart';
import 'package:megaplug/widgets/app_widgets/app_modal_bottom_sheet.dart';

import '../../../../../config/helpers/time_debuncer.dart';
import '../../../../../domain/controllers/stations_controller.dart';

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
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'search_hint'.tr,
                        hintStyle: TextStyle(
                          color: context.kHintTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        suffixIcon: stationsController
                                .searchTextEditingController.text.isEmpty
                            ? null
                            : GestureDetector(
                                onTap: () {
                                  stationsController.clearSearchBox();
                                },
                                child: Icon(Icons.clear),
                              ),
                      ),
                      onChanged: (String? value) {
                        if (value == null) {
                          return;
                        }
                        TimeDebuncer.instance
                            .debounce(Duration(milliseconds: 500), () {
                          stationsController.handleSearchText(text: value);
                        });
                      },
                    ),
                  ),
                  10.pw,
                  GestureDetector(
                    onTap: () {
                      stationsController.getAllConnectors();
                      showAppModalBottomSheet(
                        initialChildSize: 0.7,
                        maxChildSize: 0.8,
                        minChildSize: 0.6,
                        context: context,
                        builder: (
                          context,
                          scrollController,
                        ) =>
                            FilterBottomSheet(
                          scrollController: scrollController,
                        ),
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
