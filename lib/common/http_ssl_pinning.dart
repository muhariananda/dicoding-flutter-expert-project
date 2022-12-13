import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class HttpSslPinning {
  static http.Client? _client;
  static http.Client get client => _client ?? http.Client();

  static Future<http.Client> get _instance async =>
      _client ??= await _generateClient();

  static Future<void> init() async {
    _client = await _instance;
  }

  static Future<SecurityContext> get _globalContext async {
    final sslCert =
        await rootBundle.load('ceritificates/certificates.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setClientAuthoritiesBytes(sslCert.buffer.asUint8List());
    return securityContext;
  }

  static Future<http.Client> _generateClient() async {
    HttpClient httpClient = HttpClient(context: await _globalContext);
    httpClient.badCertificateCallback = (cert, host, port) => false;
    IOClient ioClient = IOClient(httpClient);
    return ioClient;
  }
}
