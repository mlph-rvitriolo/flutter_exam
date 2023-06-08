import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exam/domain/model/user_list/user.dart';
import 'package:http/http.dart' as http;

import '../../../domain/repositories/user_list/user_list_repository.dart';

class UserListViewModel extends Bloc {
  final _repository = UserListRepository();
  List<User> _userList = [];

  final StreamController<List<User>> _userListStreamController =
      StreamController();
  Stream<List<User>> get userList => _userListStreamController.stream;

  UserListViewModel(super.initialState) {
    _loadUserList();
  }

  void _loadUserList() async {
    _userList = await _repository.getUserList(http.Client());

    /// remove all duplicate entry
    _userListStreamController.sink.add(_userList.toSet().toList());
  }

  @override
  void dispose() {
    _userListStreamController.close();
  }
}
