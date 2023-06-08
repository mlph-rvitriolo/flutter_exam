import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../../exceptions/server_exception.dart';
import '../../../utils/logger.dart';
import '../../model/user_list/user.dart';
import '../../repository.dart';

class UserListRepository extends HttpRepository<User> {
  Future<List<User>> getUserList(http.Client client) async {
    String url =
        'https://gist.githubusercontent.com/dustincatap/66d48847b3ca07af7cef789d6ac8fee8/raw/550798be0efa8b98f6924cfb4ad812cd290f568a/users.json';
    final Response response = await getResponseWithRetry(url, client);
    if (isOk(response.statusCode)) {
      final List<dynamic> decodedJson = json.decode(response.body);
      final list = decodedJson.map((v) => User.fromJson(v)).toList();
      if (list.isEmpty) {
        return [];
      }
      return list;
    }
    final body = json.decode(response.body);
    log.e(body);
    throw ServerException(response);
  }
}
