import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paymob_egypt/flutter_paymob_egypt.dart';
import 'package:flutter_paymob_egypt/src/models/billing_data.dart';

import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/environment.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
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
import '../home/pages/wallet/controller/wallet_controller.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController controller = TextEditingController();
  GlobalKey<AppTextFormFieldState> textFieldKey = GlobalKey<AppTextFormFieldState>();

  @override
  void initState() {
    super.initState();
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
        padding: const EdgeInsets.symmetric(vertical: 58.0, horizontal: 28),
        child: ElevatedButton(
          onPressed: () async {
            if (textFieldKey.currentState?.validate() ?? false) {
              UserModel? userModel = ProfileController.to.userModel;
              Get.to(
                () => FlutterPaymobPayment(
                  cardInfo: CardInfo(
                    apiKey: dotenv.env['API_KEY'] ?? '',
                    iframesID: dotenv.env['IFRAME_ID'] ?? '',
                    integrationID: dotenv.env['CARD_ID'] ?? '',
                  ),
                  totalPrice: num.parse(controller.text),
                  successResult: (data) async {
                    print("Payment Information ===> $data");
                    // InformationViewer.showSuccessToast(msg: 'Payment Successful');
                    WalletController.to.refreshApi();
                    await Future.delayed(Duration(seconds: 3));
                    Get.until((route) => route.settings.name == '/HomeScreen');
                  },
                  errorResult: (error) async {
                    AppLogger.logWithGetX('Payment Failed\n${error.toString()}');
                    await Future.delayed(Duration(seconds: 3));
                    Get.back();
                  },
                  billingData: BillingData(
                    email: userModel?.email ?? 'NA',
                    phoneNumber: userModel?.phone ?? 'NA',
                    firstName: userModel?.name ?? 'NA',
                  ),
                  appBar: AppBarModel(
                    centerTitle: true,
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
          padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 18),
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
