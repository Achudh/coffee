import 'package:agnostica/models/user.dart';
import 'package:agnostica/screens/auth/auth.dart';
import 'package:agnostica/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if(user != null){
      return Home();
    }
    else {
      return Authenticate();
    }
    // return user or home
  }
}