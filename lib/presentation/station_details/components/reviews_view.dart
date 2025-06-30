import 'package:flutter/material.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/station_details/components/review_card.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              AppText(text: 'Total reviews',color: Colors.black,fontWeight: FontWeight.w500,),
              5.pw,
              AppText(
                text: '(20 review)',
                fontSize: 12,
                color: context.kHintTextColor,
              ),
            ],
          ),
        ),
        ReviewCard(),
        ReviewCard(),
        ReviewCard(),
        ReviewCard(),
        ReviewCard(),
      ],
    );
  }
}
