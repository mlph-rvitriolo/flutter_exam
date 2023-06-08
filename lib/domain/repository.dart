import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:retry/retry.dart';

import '../../utils/logger.dart';

abstract class HttpRepository<T> {
  bool isOk(final int statusCode) => statusCode == HttpStatus.ok;
  bool isForbidden(final int statusCode) => statusCode == HttpStatus.forbidden;
  bool isNotFound(final int statusCode) => statusCode == HttpStatus.notFound;
  bool isBadRequest(final int statusCode) =>
      statusCode == HttpStatus.badRequest;
  bool isUnauthorized(final int statusCode) =>
      statusCode == HttpStatus.unauthorized;

  Future<Response> getResponseWithRetry(String url, http.Client client) async {
    late Stopwatch stopWatch;
    if (kDebugMode) {
      stopWatch = Stopwatch()..start();
    }
    final httpClient = getHttpClient(client, url);
    if (kDebugMode) {
      await httpClient;
      stopWatch.stop();
      log.d('Duration:[${stopWatch.elapsed}]');
      _showLogForApi(stopWatch.elapsed.inSeconds, url);
    }
    return retry(
      () => httpClient,
      retryIf: (e) => e is SocketException,
    );
  }

  @visibleForTesting
  Future<Response> getHttpClient(
      final Client httpClient, final String url) async {
    return httpClient.get(Uri.parse(url));
  }

  void _showLogForApi(final int inSeconds, String url) {
    if (inSeconds < 1) {
      log.i('Good performance! \n$url');
    } else if (inSeconds < 3) {
      log.w('Slow response... Please check the API. \n$url');
    } else if (inSeconds < 10) {
      log.e('Bad performance... Please check the API. \n$url');
    } else {
      log.e('Timeout or bad performance? Please check the API. \n$url');
    }
  }
}
