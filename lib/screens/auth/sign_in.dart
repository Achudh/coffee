import 'package:agnostica/services/auth.dart';
import 'package:agnostica/shared/constants.dart';
import 'package:agnostica/shared/loading.dart';
import 'package:flutter/material.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn(this.toggleView);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In'),
        actions: <Widget> [
          FlatButton.icon(
            onPressed: (){
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text('Sign Up'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0 ),
        child: Form(
           key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'enter email'),
                onChanged: (val){
                 setState(() => email = val);
                },
                validator: (val)=> val.isEmpty? 'Enter an email' : null
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'enter password'),
                obscureText: true,
                onChanged: (val){
                 setState(() => password = val);
                },
                validator: (val)=> val.length < 8? 'Enter a password more than 8 characters' : null 
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white
                  ),
                  ),
                onPressed: () async{
              if(_formKey.currentState.validate()){
                setState(() {
                  loading=true;
                });
                   dynamic result = await _auth.signin(email, password);
                     if(result == null){
                    setState(() {
                    error = 'cannot sign in with those credentials';
                    loading = false;
                    });
                  }
                 }
                }
              ),SizedBox(height: 14.0,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ]
          )
        ),
      )
    );
  }
}