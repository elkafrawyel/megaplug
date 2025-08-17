import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/data/api_responses/station_details_response.dart';
import 'package:megaplug/widgets/app_widgets/app_network_image.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../../config/helpers/date_helper.dart';
import '../../../config/res.dart';

class ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: AppNetworkImage(
            imageUrl: review.user?.avatar ?? '',
            width: 50,
            height: 50,
            isCircular: true,
          ),
          title: AppText(
            text: review.user?.name ?? '',
            fontWeight: FontWeight.bold,
          ),
          subtitle: AppText(
            text: DateHelper().formatDateTime(review.createdAt!),
            color: context.kHintTextColor,
            maxLines: 2,
            fontSize: 12,
          ),
          trailing: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(0xffFAFAFA),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    Res.starIcon,
                  ),
                  5.pw,
                  AppText(
                    text: review.rating?.toString() ?? '0',
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),
            ),
          ),
        ),
        if (review.review != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 8.0,
            ),
            child: AppText(
              text: review.review ?? '',
              maxLines: 5,
              fontSize: 13,
            ),
          )
      ],
    );
  }
}
