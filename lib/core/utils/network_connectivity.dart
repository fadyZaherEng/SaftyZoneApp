import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivity {
  NetworkConnectivity._();

  static final _instance = NetworkConnectivity._();

  static NetworkConnectivity get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();

  Stream get myStream => _controller.stream;

  void initializeInternetConnectivityStream() {
    _networkConnectivity.onConnectivityChanged.listen((result) {
      return _controller.sink.add(result);
    });
  }

  Future<bool> isInternetConnected() async {
    final result = await InternetAddress.lookup('www.google.com');
    bool isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    return isOnline;
  }

  bool isShowNoInternetDialog = false;

  void disposeStream() => _controller.close();
}
