import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

///  this scroll controller must provide to SingleChildScrollView so it
///  can scroll on keyboard opening or user actions

Future showAppModalBottomSheet({
  required BuildContext context,
  required Widget child,
})async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: false,
    builder: (BuildContext context) {
      return Padding(
        // This ensures the sheet content avoids the keyboard and fits content height
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Wrap(
          children: [child],
        ),
      )
          .animate()
          .fade(
            begin: 0,
            end: 1,
            curve: Curves.easeIn,
          )
          .slide(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
            duration: Duration(milliseconds: 700),
            curve: Curves.easeIn,
          );
    },
  );
}
