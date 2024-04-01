import 'package:flutter/material.dart';
import 'package:study_ui/data/user_request.dart';
import 'package:study_ui/data/user.dart';

class FreezedUserPage extends StatelessWidget {
  const FreezedUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userRequest = UserRequest();
    List<User> userList = <User>[];

    return Scaffold(
      body: FutureBuilder<List<User>>(
        // ①で作成した関数を実行
        // ※実行が終わったタイミングでbuilderが実行
        future: userRequest.getAllUser(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          // ①の実行結果(snapshot.data)を、userListの変数に代入
          userList = snapshot.data ?? <User>[];
          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shadowColor: Colors.black,
                child: Column(
                  // userListに入っている各値を表示する
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // UserName
                    Row(
                      children: [
                        Text(userList[index].id.toString() + ':'),
                        Text(userList[index].username),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      // Email
                      children: [
                        Text('Email:'),
                        Text(userList[index].email),
                      ],
                    ),
                    Row(
                      // Phone
                      children: [
                        Text('Phone:'),
                        Text(userList[index].phone),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
