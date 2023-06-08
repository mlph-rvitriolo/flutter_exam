import 'package:flutter/material.dart';
import 'package:flutter_exam/shared/widgets/center_app_bar.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../domain/model/user_list/user.dart';

class UserListDetailsView extends StatefulWidget {
  const UserListDetailsView(this.user, {super.key});
  final User user;

  @override
  State<UserListDetailsView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CenterAppBar(
          'User List Details',
          context,
        ),
        body: _buildUserListDetails(user: widget.user));
  }

  Widget _buildUserListDetails({required User user}) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                const Center(child: CircularProgressIndicator()),
                Center(
                  /// Cache the image
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.user.imageUrl,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              user.name,
              style: Theme.of(context).textTheme.displayLarge,
            ),
          )
        ],
      ),
    );
  }
}
