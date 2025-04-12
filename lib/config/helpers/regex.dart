bool isEmail(String input) {
  final emailRegEx = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  return emailRegEx.hasMatch(input);
}

bool isPhone(String input) {
  final phoneRegEx = RegExp(r"^\+?\d{7,15}$"); // Accepts international and local formats
  return phoneRegEx.hasMatch(input);
}


bool isEgyptianPhone(String input) {
  final cleaned = input.replaceAll(RegExp(r'\s+|-'), ''); // Remove spaces/dashes
  return cleaned.startsWith('+20') || cleaned.startsWith('0');
}