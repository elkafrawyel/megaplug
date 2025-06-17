import 'package:flutter/material.dart';
import 'package:megaplug/config/extension/space_extension.dart';

import 'bottom_sheet_header.dart';

class BottomSheetParent extends StatelessWidget {
  final Widget child;
  final bool hideBack;

  const BottomSheetParent({super.key, required this.child, this.hideBack = false});

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
            BottomSheetHeader(hideBack: hideBack),
            10.ph,
            child,
            10.ph,
          ],
        ),
      ),
    );
  }
}
