import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/station_details/components/review_card.dart';
import 'package:megaplug/presentation/station_details/controller/station_details_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StationDetailsController>(
      builder: (stationDetailsController) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  AppText(
                    text: 'total_reviews'.tr,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  5.pw,
                  AppText(
                    text: '(${stationDetailsController.stationDetailsResponse?.data?.station?.totalReviews?.toString() ?? '0'} ${'review'.tr})',
                    fontSize: 12,
                    color: context.kHintTextColor,
                  ),
                ],
              ),
            ),
            ...(stationDetailsController.stationDetailsResponse?.data?.reviews ?? []).map((review) {
              return ReviewCard(
                review: review,
              );
            }),
          ],
        );
      },
    );
  }
}
