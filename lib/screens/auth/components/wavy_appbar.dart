import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/res.dart';

class WavyAppBar extends StatefulWidget {
  final bool withBackButton;
  final bool animated;

  const WavyAppBar({
    super.key,
    this.withBackButton = true,
    this.animated = true,
  });

  @override
  State<WavyAppBar> createState() => _WavyAppBarState();
}

class _WavyAppBarState extends State<WavyAppBar> {
  bool _isLogoVisible = false;
  bool _isBackVisible = false;

  @override
  void initState() {
    super.initState();
    // Start animation after a short delay
    if (widget.animated) {
      Future.delayed(Duration(milliseconds: 300), () {
        setState(() {
          _isLogoVisible = true;
        });
      });

      if (widget.withBackButton) {
        Future.delayed(Duration(milliseconds: 800), () {
          setState(() {
            _isBackVisible = true;
          });
        });
      }
    } else {
      _isBackVisible = true;
      _isLogoVisible = true;
    }
  }

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
        AnimatedPositionedDirectional(
          duration: Duration(milliseconds: 1500),
          // Animation duration
          curve: Curves.easeInOut,
          // Smooth transition
          top: _isLogoVisible ? kToolbarHeight : -300,
          // Moves up from bottom
          start: 0,
          end: 0,
          child: AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: _isLogoVisible ? 1 : 0.5,
            child: Image.asset(
              Res.authLogo,
              width: 150,
              height: 150,
            ),
          ),
        ),
        if (widget.withBackButton)
          AnimatedPositionedDirectional(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            start: _isBackVisible ? 18 : -50,
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
