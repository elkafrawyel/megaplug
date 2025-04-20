import 'dart:async';

class AppTimeDebuncer {
  /// private constructor
  AppTimeDebuncer._();

  /// the one and only instance of this singleton
  static final instance = AppTimeDebuncer._();

  Timer? _debounce;

  debounce(Duration duration, Function() action) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(duration, () {
      action();
    });
  }

  cancel() => _debounce?.cancel();
}
