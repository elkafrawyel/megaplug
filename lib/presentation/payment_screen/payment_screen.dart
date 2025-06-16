import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paymob_egypt/flutter_paymob_egypt.dart';
import 'package:flutter_paymob_egypt/src/models/billing_data.dart';

import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/information_viewer.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/components/home_appbar.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/app_text_field.dart';
import '../../config/constants.dart';
import '../../config/helpers/regex.dart';
import '../../domain/entities/api/user_model.dart';
import '../home/pages/profile/controller/profile_controller.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController controller = TextEditingController();

  GlobalKey<AppTextFormFieldState> textFieldKey = GlobalKey<AppTextFormFieldState>();
  final String apiKey =
      "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBek5ETTJNU3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS4tckhNR1pmVEpFcGhIZVVUam1NX0dORE54a01JV3o3WWZkTUp2bUhVTUtOaWczcjhQYWo5YzlieUoxWkJXNjRmdndIdV9kRWZ3TDZNaFVFOHJWTmZuQQ==";

  final String iframeId = "910813";
  final String integrationCardId = "5032726";
  @override
  void initState() {
    super.initState();

    // Future.delayed(Duration(seconds: 1), () async {
    //   UserModel? userModel = ProfileController.to.userModel;
    //
    //   PaymentData.initialize(
    //     apiKey: apiKey,
    //     iframeId: iframeId,
    //     integrationCardId: integrationCardId,
    //     integrationMobileWalletId: "5141645",
    //     userData: UserData(
    //       email: userModel?.email ?? 'NA', // Optional: Defaults to 'NA'
    //       phone: userModel?.phone ?? 'NA', // Optional: Defaults to 'NA'
    //       name: userModel?.name ?? 'NA', // Optional: Defaults to 'NA'
    //     ),
    //
    //     // Optional Style Customizations
    //     style: Style(
    //       primaryColor: context.kPrimaryColor,
    //       // Default: Colors.blue
    //       scaffoldColor: Colors.white,
    //       // Default: Colors.white
    //       appBarBackgroundColor: context.kPrimaryColor,
    //       // Default: Colors.blue
    //       appBarForegroundColor: Colors.white,
    //       // Default: Colors.white
    //       textStyle: TextStyle(fontSize: 14),
    //       // Default: TextStyle()
    //       buttonStyle: ElevatedButton.styleFrom(
    //         backgroundColor: context.kPrimaryColor,
    //         foregroundColor: context.kColorOnPrimary,
    //       ),
    //       // Default: ElevatedButton.styleFrom()
    //       circleProgressColor: context.kPrimaryColor,
    //       // Default: Colors.blue
    //       unselectedColor: Colors.grey, // Default: Colors.grey
    //     ),
    //   );
    // });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'Payment',
        showBackButton: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 38.0, horizontal: 28),
        child: ElevatedButton(
          onPressed: () async {
            if (textFieldKey.currentState?.validate() ?? false) {
              UserModel? userModel = ProfileController.to.userModel;

              Get.to(
                () => FlutterPaymobPayment(
                  cardInfo: CardInfo(
                    apiKey: apiKey,
                    iframesID: iframeId,
                    integrationID: integrationCardId,
                  ),
                  totalPrice: num.parse(controller.text),
                  successResult: (data) {
                    print("Payment Information ===> $data");
                    InformationViewer.showSuccessToast(msg: 'Payment Successful');
                  },
                  errorResult: (error) {
                    InformationViewer.showSuccessToast(msg: 'Payment Failed');
                  },
                  billingData: BillingData(
                    email: userModel?.email ?? 'NA',
                    phoneNumber: userModel?.phone ?? 'NA',
                    firstName: userModel?.name ?? 'NA',
                  ),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: context.kPrimaryColor,
            padding: EdgeInsets.symmetric(vertical: kButtonHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: AppText(
            text: "Recharge Now".tr,
            color: context.kColorOnPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(text: 'Amount to charge'),
              10.ph,
              AppTextFormField(
                key: textFieldKey,
                controller: controller,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                hintText: 'Enter amount',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  DecimalLimiter(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
