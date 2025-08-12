import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/data/api_responses/station_details_response.dart';
import 'package:megaplug/widgets/app_widgets/app_network_image.dart';

import '../../../config/res.dart';
import '../../../widgets/app_widgets/app_text.dart';
import '../../home/pages/stations/controller/stations_controller.dart';

// final List<String> imgList = [
//   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
// ];

class StationBanners extends StatefulWidget {
  final List<Images> sliders;

  const StationBanners({required this.sliders, super.key});

  @override
  State<StatefulWidget> createState() {
    return _StationBannersState();
  }
}

class _StationBannersState extends State<StationBanners> {
  late Images _current;

  @override
  void initState() {
    super.initState();
    _current = widget.sliders.isNotEmpty ? widget.sliders.first : Images(url: '');
  }

  @override
  Widget build(BuildContext context) {
    return widget.sliders.isEmpty
        ? SizedBox()
        : Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CarouselSlider(
                items: createSliders(widget.sliders),
                // items: createSliders(imgList),
                options: CarouselOptions(
                    autoPlay: true,
                    viewportFraction: 1,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    aspectRatio: 1.6,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = widget.sliders[index];
                      });
                    }),
              ),
              PositionedDirectional(
                top: 0,
                start: 0,
                end: 0,
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(0, 0, 0, .5),
                        Color.fromRGBO(0, 0, 0, 0),
                      ],
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                top: 30,
                start: 0,
                end: 0,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: InkWell(
                        onTap: Get.back,
                        child: SvgPicture.asset(Res.backIcon),
                      ),
                    ),
                    Spacer(),
                    AppText(
                      text: 'station_details'.tr,
                      color: Colors.white,
                      centerText: true,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.find<StationsController>().showComingSoonDialog(Get.context!);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(Res.shareIcon),
                      ),
                    ),
                  ],
                ),
              ),
              PositionedDirectional(
                bottom: 10.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.sliders.map((slider) {
                    return _current == slider
                        ? Container(
                            width: 30.0,
                            height: 7.0,
                            margin: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 2.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.kPrimaryColor,
                            ),
                          )
                        : Container(
                            width: 7.0,
                            height: 7.0,
                            margin: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 2.0,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          );
                  }).toList(),
                ),
              ),
            ],
          );
  }

  List<Widget> createSliders(List<Images> sliderList) {
    return sliderList
        .map(
          (item) => AppNetworkImage(
            imageUrl: item.url,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.45,
            radius: 0.0,
          ),
        )
        .toList();
  }
}
