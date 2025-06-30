import 'package:flutter/material.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

class AmenitiesView extends StatelessWidget {
  final List<String> data;

  const AmenitiesView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
          runSpacing: 20,
          children: data
              .map(
                (element) => SizedBox(
                  width: (MediaQuery.of(context).size.width - 34) / 2, // 2 per row with spacing
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.wifi,
                        color: context.kPrimaryColor,
                      ),
                      10.pw,
                      Expanded(
                        child: AppText(
                          text: element,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          maxLines: 3,
                        ),
                      )
                    ],
                  ),
                ),
              )
              .toList()),
    );
  }
}
