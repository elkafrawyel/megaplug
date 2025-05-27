import 'package:flutter/material.dart';
import 'package:megaplug/config/extension/space_extension.dart';

import '../../../../../../widgets/bottom_sheet_header.dart';

class BottomSheetParent extends StatelessWidget {
  final Widget child;

  const BottomSheetParent({super.key, required this.child});

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
            10.ph,
            child,
            10.ph,
          ],
        ),
      ),
    );
  }
}
