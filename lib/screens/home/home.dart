import 'package:agnostica/models/brew.dart';
import 'package:agnostica/screens/home/brew_list.dart';
import 'package:agnostica/screens/home/settings_form.dart';
import 'package:agnostica/services/auth.dart';
import 'package:agnostica/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(
      context: context, 
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 60.0
          ),
          child: SettingsForm(),
        );
      }
      );
    }

    return StreamProvider<List<Brew>>.value(
        value: DatabaseService().brews,
        child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar (
          title: Text('Hello'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async{
                await _auth.signOut();
              },
              label: Text('Sign out')
              ),
              FlatButton.icon(
                icon: Icon(Icons.settings),
                label: Text('Settings'),
                onPressed: ()=> _showSettingsPanel(),
              )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BrewList()),
      ),
    );
  }
}