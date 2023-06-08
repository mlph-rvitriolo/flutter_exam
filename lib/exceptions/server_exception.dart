import 'package:http/http.dart';

import '../utils/logger.dart';

class ServerException implements Exception {
  ServerException(Response responseParam) {
    response = responseParam;
    log.e('ServerException statusCode: ${responseParam.statusCode}');
  }

  Response? response;
}
