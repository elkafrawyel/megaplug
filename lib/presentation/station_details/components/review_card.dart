import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_network_image.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../../config/res.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: AppNetworkImage(
            imageUrl:
                'https://images.healthshots.com/healthshots/en/uploads/2020/12/08182549/positive-person.jpg',
            width: 50,
            height: 50,
            isCircular: true,
          ),
          title: AppText(
            text: 'Mahmoud Ashraf',
            fontWeight: FontWeight.bold,
          ),
          subtitle: AppText(
            text: '1 month ago',
            color: context.kHintTextColor,
            fontSize: 12,
          ),
          trailing: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xffFAFAFA)),
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
                    text: '4.9',
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: AppText(
            text:
                'I really love this car 😍... Lacinia ullamcorper mattis id eu neque egestas feugiat. Eget aliquet nulla dignissim eget tortor auctor elementum magna ornare suscipit accumsan arcu.',
            maxLines: 5,
          ),
        )
      ],
    );
  }
}
