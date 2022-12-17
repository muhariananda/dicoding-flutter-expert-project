import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class HttpSslPinning {
  static http.Client? _client;
  static http.Client get client => _client ?? http.Client();

  static Future<http.Client> get _instance async =>
      _client ??= await _generateSecureClient();

  static Future<void> init() async {
    _client = await _instance;
  }

  static Future<HttpClient> _secureHttpClient() async {
    final sslCert =
        await rootBundle.load('certificates/moviedb_certificates.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    HttpClient httpClient = HttpClient(context: securityContext);
    httpClient.badCertificateCallback = (cert, host, port) => false;

    return httpClient;
  }

  static Future<http.Client> _generateSecureClient() async {
    IOClient ioClient = IOClient(await _secureHttpClient());
    return ioClient;
  }
}
