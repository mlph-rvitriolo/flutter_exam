import 'package:flutter/material.dart';
import 'package:flutter_exam/screens/user_list/view_model/user_list_view_model.dart';
import 'package:flutter_exam/screens/user_list_details/view/user_list_details_view.dart';
import 'package:flutter_exam/shared/widgets/center_app_bar.dart';

import '../../../domain/model/user_list/user.dart';

class UserListView extends StatefulWidget {
  const UserListView({super.key});

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  final _bloc = UserListViewModel('initialState');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CenterAppBar(
        'User List',
        context,
        shouldShowLeading: false,
      ),
      body: StreamBuilder(
          stream: _bloc.userList,
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasData) {
              return _buildUserList(userList: snapshot.data!);
            }
            if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _buildUserList({required List<User> userList}) {
    return ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserListDetailsView(userList[index])),
              );
            },
            child: ListTile(
              title: Text(userList[index].name),
              leading: const Icon(Icons.person),
            ),
          );
        });
  }
}
