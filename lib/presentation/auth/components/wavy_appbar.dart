import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/clients/storage/storage_client.dart';
import '../../../config/res.dart';

class WavyAppBar extends StatefulWidget {
  final bool withBackButton;

  const WavyAppBar({
    super.key,
    this.withBackButton = true,
  });

  @override
  State<WavyAppBar> createState() => _WavyAppBarState();
}

class _WavyAppBarState extends State<WavyAppBar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        SvgPicture.asset(
          Res.wavyAppBarBgIcon,
          width: width,
          fit: BoxFit.fitHeight,
        ),
        PositionedDirectional(
          top: 0,
          start: 0,
          end: 0,
          bottom: 0,
          child: AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: 1,
            child: Center(
              child: Image.asset(
                StorageClient().isAr() ? Res.arabicLogo : Res.englishLogo,
                width: 250,
                height: 250,
              ),
            ),
          ),
        ),
        if (widget.withBackButton)
          PositionedDirectional(
            start: 18,
            top: 70,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(
                Res.backIcon,
                matchTextDirection: true,
              ),
            ),
          )
      ],
    );
  }
}
