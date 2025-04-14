class Environment {
  static const AppMode appMode = AppMode.testing;
  final String _liveBaseUrl =
      'http://138.68.71.240/api/v1/';
  final String _testBaseUrl =
      'http://138.68.71.240/api/v1/';

  url() {
    switch (appMode) {
      case AppMode.testing:
      case AppMode.staging:
        return _testBaseUrl;
      case AppMode.live:
        return _liveBaseUrl;
    }
  }
}

enum AppMode {
  testing,
  staging,
  live,
}
