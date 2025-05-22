import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/constants.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/home_screen.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/app_text_field.dart';

import '../../../widgets/bottom_sheet_header.dart';

class RateView extends StatefulWidget {
  const RateView({super.key});

  @override
  State<RateView> createState() => _RateViewState();
}

class _RateViewState extends State<RateView> {
  final TextEditingController controller = TextEditingController();
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BottomSheetHeader(),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 12.0,
                ),
                child: AppText(
                  text: 'rate_station'.tr,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  centerText: true,
                ),
              ),
            ),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              unratedColor: Color(0xffE7E7E7),
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  this.rating = rating;
                });
              },
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: AppTextFormField(
                controller: controller,
                hintText: 'rate_hint'.tr,
                maxLines: 5,
                required: false,
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.9,
              child: ElevatedButton(
                onPressed: () {
                  Get.until((route) => route.settings.name == '/HomeScreen');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.kPrimaryColor,
                  padding: EdgeInsets.symmetric(vertical: kButtonHeight),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: AppText(
                  text: "rate".tr,
                  color: context.kColorOnPrimary,
                ),
              ),
            ),
            40.ph,
          ],
        ),
      ),
    );
  }
}
