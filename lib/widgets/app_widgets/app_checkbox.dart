import 'package:flutter/material.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

class AppCheckbox extends StatefulWidget {
  final String text;
  final bool value;
  final ValueChanged<bool?>? onChange;

  const AppCheckbox({
    super.key,
    required this.text,
    required this.value,
    this.onChange,
  });

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool? value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          activeColor: context.kPrimaryColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: value,
          onChanged: (bool? value) {
            if (widget.onChange != null) {
              widget.onChange!(value);
            }
            setState(() {
              this.value = value;
            });
          },
        ),
        5.pw,
        AppText(
          text: widget.text,
        )
      ],
    );
  }
}
