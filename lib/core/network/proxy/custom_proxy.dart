import 'dart:io';

import 'custom_proxy_http_override.dart';

/// Allows you to set and enable a proxy for your app
class CustomProxy {
  /// A string representing an IP address for the proxy server
  final String ipAddress;

  /// The port number for the proxy server
  /// Can be null if port is default.
  final int port;

  /// Set this to true
  /// - Warning: Setting this to true in production apps can be dangerous. Use with care!
  bool allowBadCertificates;

  /// Initializer
  CustomProxy(
      {required this.ipAddress,required this.port, this.allowBadCertificates = false});

  /// Enable the proxy
  void enable() {
    HttpOverrides.global =
        CustomProxyHttpOverride.withProxy(toString());
  }

  /// Disable the proxy
  void disable() {
    HttpOverrides.global = null;
  }

  @override
  String toString() {
    String proxy = ipAddress;
    proxy += ":$port";
    return proxy;
  }
}