import 'package:flutter/services.dart';

bool isEmail(String input) {
  final emailRegEx = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  return emailRegEx.hasMatch(input);
}

bool isPhone(String input) {
  final phoneRegEx =
      RegExp(r"^\+?\d{7,15}$"); // Accepts international and local formats
  return phoneRegEx.hasMatch(input);
}

bool isEgyptianPhone(String input) {
  final phoneRegEx = RegExp(r'^(?:\+2)?01[0-2,5][0-9]{8}$');
  return phoneRegEx.hasMatch(input);
}


class DecimalLimiter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    // Allow empty field
    if (newText.isEmpty) return newValue;

    // Allow only valid decimal numbers
    final number = double.tryParse(newText);
    if (number == null) return oldValue;

    // Limit to max 999.99
    if (number > 999.99) return oldValue;

    // Allow max 2 decimal places
    if (newText.contains('.')) {
      final decimals = newText.split('.')[1];
      if (decimals.length > 2) return oldValue;
    }

    return newValue;
  }
}
