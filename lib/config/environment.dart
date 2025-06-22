class Environment {
  static const AppMode appMode = AppMode.development;
  final String _liveBaseUrl = 'http://138.68.71.240/api/v1/';
  final String _stagingBaseUrl = 'http://138.68.71.240:82/api/v1/';
  final String _developmentBaseUrl = 'https://app.mega-plug.com//api/v1/';

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

  // payment gateway configuration
  static final String paymobApiKey =
      "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TVRBek5ETTJNU3dpYm1GdFpTSTZJbWx1YVhScFlXd2lmUS4tckhNR1pmVEpFcGhIZVVUam1NX0dORE54a01JV3o3WWZkTUp2bUhVTUtOaWczcjhQYWo5YzlieUoxWkJXNjRmdndIdV9kRWZ3TDZNaFVFOHJWTmZuQQ==";
  static final String iframeId = "910813";
  static final String integrationCardId = "5032726";
}

enum AppMode {
  development,
  staging,
  live,
}
