import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';

import '../config/res.dart';

class BottomSheetHeader extends StatelessWidget {
  final bool hideBack;

  const BottomSheetHeader({super.key, this.hideBack = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
              color: Color(0xffF2F2F3),
              borderRadius: BorderRadius.circular(8),
            ),
            width: 100,
            height: 7,
          ),
        ),
        if (!hideBack)
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffF2F2F3),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(Res.closeIcon),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
