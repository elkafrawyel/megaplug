import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

  @override
  void initState() {
    String url = 'https://www.youtube.com/watch?v=4h0G2LIvSHY';
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        loop: false,
        mute: false,
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Offstage(
                  offstage: isFullScreen,
                  child: AppText(
                    text: 'Watch tutorial video for more Details',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Theme.of(context).primaryColor,
                    liveUIColor: Colors.transparent,
                    progressColors: ProgressBarColors(
                      playedColor: Theme.of(context).primaryColor,
                      handleColor:
                          Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                    thumbnail: Center(
                      child: SvgPicture.asset(
                        Res.logo,
                        fit: BoxFit.contain,
                        width: isFullScreen ? 250 : 150,
                        height: isFullScreen ? 250 : 150,
                        // colorFilter: const ColorFilter.mode(
                        //   Colors.white,
                        //   BlendMode.srcIn,
                        // ),
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
                      ProgressBar(
                        isExpanded: true,
                        controller: _controller,
                      ),
                      FullScreenButton(
                        controller: _controller,
                      ),
                    ],
                  ),
                ),
                Offstage(
                  offstage: isFullScreen,
                  child: AppText(
                    text: 'How can i charge my electric vehicle ?',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                20.ph,
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
