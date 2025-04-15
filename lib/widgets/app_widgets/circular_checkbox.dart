import 'package:flutter/material.dart';
import 'package:megaplug/config/theme/color_extension.dart';

class CircularCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CircularCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: !value ? Border.all(color: Colors.black, width: 0.5) : null,
          color: value ? context.kPrimaryColor : Colors.transparent,
        ),
        child: value ? Icon(Icons.check, size: 20, color: Colors.white) : null,
      ),
    );
  }
}
