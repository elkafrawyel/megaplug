import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/helpers/url_launcher_helper.dart';
import 'package:megaplug/config/information_viewer.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/data/api_responses/contact_info_response.dart';
import 'package:megaplug/data/api_responses/station_details_response.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../config/res.dart';
import '../home/components/home_appbar.dart';

class ContactInfoScreen extends StatefulWidget {
  const ContactInfoScreen({super.key});

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  ContactInfoResponse? contactInfoResponse;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _getSocialLinks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: context.kBackgroundColor,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'contact_info'.tr,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            110.ph,
            Image.asset(
              Res.contactUsImage,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: 'Contact Social information',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            30.ph,
            loading
                ? SizedBox(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  )
                : contactInfoResponse == null
                    ? SizedBox()
                    : Column(
                        children: (contactInfoResponse?.data ?? [])
                            .map(
                              (element) => GestureDetector(
                                onTap: () {
                                  if (element.url == null) return;
                                  if (element.isWhatsApp ?? false) {
                                    UrlLauncherHelper.openWhatsApp(element.url!);
                                  } else if (element.isPhone ?? false) {
                                    UrlLauncherHelper.makePhoneCall(element.url!);
                                  }else{
                                    UrlLauncherHelper.openLink(element.url!);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0,
                                    vertical: 4.0,
                                  ),
                                  child: Card(
                                    elevation: 0.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0,
                                        vertical: 8.0,
                                      ),
                                      child: Row(
                                        children: [
                                          if (element.icon != null) SvgPicture.network(element.icon!),
                                          20.pw,
                                          AppText(
                                            text: element.label ?? '',
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList())
          ],
        ),
      ),
    );
  }

  void _getSocialLinks() async {
    loading = true;
    ApiResult<ContactInfoResponse> apiResult = await APIClient.instance.get(
      endPoint: Res.apiContactInfo,
      fromJson: ContactInfoResponse.fromJson,
    );
    loading = false;
    if (apiResult.isSuccess()) {
      contactInfoResponse = apiResult.getData();
    } else {
      InformationViewer.showErrorToast(msg: apiResult.getError());
    }
  }
}
