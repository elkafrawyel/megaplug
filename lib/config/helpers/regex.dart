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
  final phoneRegEx = RegExp(
      r'^(01)[0-2,5]{1}[0-9]{8}$'); // Accepts international and local formats
  return phoneRegEx.hasMatch(input);
}
