import 'package:flutter_exam/domain/model/user_list/user.dart';
import 'package:flutter_exam/domain/repositories/user_list/user_list_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_list_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final repo = UserListRepository();
  group('getUserList', () {
    test('returns an User List if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(Uri.parse(
              'https://gist.githubusercontent.com/dustincatap/66d48847b3ca07af7cef789d6ac8fee8/raw/550798be0efa8b98f6924cfb4ad812cd290f568a/users.json')))
          .thenAnswer((_) async => http.Response(
              '[{"id": "1", "name": "John", "imageUrl": "https://www.alchinlong.com/wp-content/uploads/2015/09/sample-profile.png"},'
              '{"id": "1", "name": "John", "imageUrl": "https://www.alchinlong.com/wp-content/uploads/2015/09/sample-profile.png"},'
              '{"id": "2", "name": "Chris", "imageUrl": "https://www.alchinlong.com/wp-content/uploads/2015/09/sample-profile.png"},'
              '{"id": "3", "name": "Mark", "imageUrl": "https://www.alchinlong.com/wp-content/uploads/2015/09/sample-profile.png"}]',
              200));

      expect(await repo.getUserList(client), isA<List<User>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse(
              'https://gist.githubusercontent.com/dustincatap/66d48847b3ca07af7cef789d6ac8fee8/raw/550798be0efa8b98f6924cfb4ad812cd290f568a/users.json')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(repo.getUserList(client), throwsException);
    });
  });
}
