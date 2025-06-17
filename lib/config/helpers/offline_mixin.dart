import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

/// This mixin can listen to incoming notification
mixin OfflineMixin<T extends StatefulWidget> on State<T> {
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void initState() {
    _subscription = Connectivity().onConnectivityChanged.listen(
          _onNewNotify,
        );
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void onNotify({bool? isConnected});

  void _onNewNotify(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      onNotify(isConnected: true);
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      onNotify(isConnected: true);
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      onNotify(isConnected: true);
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      onNotify(isConnected: true);
    } else if (connectivityResult.contains(ConnectivityResult.none)) {
      onNotify(isConnected: false);
    } else {
      onNotify(isConnected: false);
    }
  }
}
