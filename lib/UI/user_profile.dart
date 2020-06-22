import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testcart/Utils/data.dart';
import 'package:testcart/Utils/service.dart';
import 'package:testcart/ViewModel/edit_profile_viewmodel.dart';


class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  @override
  Widget build(BuildContext context) {
    return Provider<EditProfileNotifier>(
      create: (_)=>service<EditProfileNotifier>(),
      builder: (context, child){
        if (sharedPreference.get('uid') == null){
          return Center(child: ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, 'Login');
          }, child: Text('Login')));
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              child: Image.asset('assets/user.png'),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                  "@username"
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                  "name"
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  child: Text('Log out'),
                  onPressed: (){},
                )
            )
          ],
        );
      },
    );
  }
}
