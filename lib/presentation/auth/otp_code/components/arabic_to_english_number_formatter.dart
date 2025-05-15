import 'package:flutter/services.dart';

class ArabicToEnglishNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    const arabicToEnglishNumbers = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9'
    };

    String newText = newValue.text.split('').map((char) {
      return arabicToEnglishNumbers[char] ?? char;
    }).join();

    return TextEditingValue(
      text: newText,
      selection: newValue.selection,
    );
  }
}
