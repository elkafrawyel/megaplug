import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../config/clients/storage/storage_client.dart';
import '../../config/res.dart';
import '../home/components/home_appbar.dart';

class HowToChargeScreen extends StatefulWidget {
  const HowToChargeScreen({super.key});

  @override
  State<HowToChargeScreen> createState() => _HowToChargeScreenState();
}

class _HowToChargeScreenState extends State<HowToChargeScreen> {
  late YoutubePlayerController _controller;

  bool isFullScreen = false;

  List<String> steps = [
    'Add credit to your wallet.',
    'Connect the charger cable with the car & charger. Note: To use the AC charger, you need to have your own Type 2 charging cable. The DC charger is equipped with cables for DC charging “CCS2”.',
    'Start the charging session by scanning your phone onto the charger reader, located at the top of the AC charger and on the side of the DC charger.',
    'The blue LED light indicates the start of the charging session.',
    'End the charging session by pressing ‘stop charging’ in the InfinityEV app.',
    'Disconnect the cable on the AC charger from the charger side first, and then from your EV. On the DC charger, remove the cable from the vehicle.'
  ];

  @override
  void initState() {
    String url = 'https://www.youtube.com/watch?v=4h0G2LIvSHY';
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        loop: false,
        mute: false,
        enableCaption: false,
      ),
    )..addListener(() {
        isFullScreen = _controller.value.isFullScreen;
        setState(() {});
      });
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool pop, dynamic val) async {
        if (isFullScreen) {
          _controller.toggleFullScreenMode();
        } else {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Get.back();
          });
        }
      },
      child: Scaffold(
        backgroundColor: context.kBackgroundColor,
        appBar: isFullScreen
            ? null
            : HomeAppbar(
                svgAssetPath: Res.homeAppBarBg,
                title: 'how_to_charge'.tr,
                showBackButton: true,
              ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Offstage(
                offstage: isFullScreen,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    text: 'Watch tutorial video for more Details',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: isFullScreen
                      ? EdgeInsets.zero
                      : const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 12.0,
                        ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(isFullScreen ? 0 : 18),
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: context.kPrimaryColor,
                      liveUIColor: Colors.transparent,
                      progressColors: ProgressBarColors(
                        playedColor: context.kPrimaryColor,
                        handleColor: context.kHintTextColor,
                      ),
                      thumbnail: Center(
                        child: Image.asset(
                          StorageClient().isAr()
                              ? Res.arabicLogo
                              : Res.englishLogo,
                          fit: BoxFit.contain,
                          width: isFullScreen ? 250 : 150,
                          height: isFullScreen ? 250 : 150,
                        ),
                      ),
                      onEnded: (youtubeMetaDate) {
                        _handleBackButton();
                      },
                      onReady: () {
                        setState(() {});
                      },
                      topActions: [
                        BackButton(
                          onPressed: _handleBackButton,
                          color: Theme.of(context).primaryColor,
                        )
                      ],
                      bottomActions: [
                        CurrentPosition(
                          controller: _controller,
                        ),
                        10.pw,
                        ProgressBar(
                          isExpanded: true,
                          controller: _controller,
                        ),
                        10.pw,
                        FullScreenButton(
                          controller: _controller,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Offstage(
                offstage: isFullScreen,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AppText(
                    text: 'How can i charge my electric vehicle ?',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    maxLines: 2,
                  ),
                ),
              ),
              Offstage(
                offstage: isFullScreen,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AppText(
                    text:
                        'After downloading the Megaplug app, please follow the below steps:',
                    fontWeight: FontWeight.w500,
                    maxLines: 3,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => 10.ph,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: '${index + 1}. ',
                        color: Color(0xff6D7698),
                      ),
                      Expanded(
                        child: AppText(
                          text: steps[index],
                          maxLines: 10,
                          color: Color(0xff6D7698),
                        ),
                      ),
                    ],
                  ),
                  itemCount: steps.length,
                ),
              ),
              Offstage(
                offstage: isFullScreen,
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: AppText(
                          text: 'start_charging'.tr,
                          color: context.kColorOnPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleBackButton() {
    if (isFullScreen) {
      _controller.toggleFullScreenMode();
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Get.back();
      });
    }
  }
}
