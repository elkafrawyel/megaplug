class Environment {
  static const AppMode appMode = AppMode.staging;
  final String _liveBaseUrl =
      'http://138.68.71.240/api/v1/';
  final String _stagingBaseUrl =
      'http://138.68.71.240:82/api/v1/';
  final String _developmentBaseUrl =
      'http://138.68.71.240:81/api/v1/';

  url() {
    switch (appMode) {
      case AppMode.development:
        return _developmentBaseUrl;
      case AppMode.staging:
        return _stagingBaseUrl;
      case AppMode.live:
        return _liveBaseUrl;
    }
  }
}

enum AppMode {
  development,
  staging,
  live,
}
