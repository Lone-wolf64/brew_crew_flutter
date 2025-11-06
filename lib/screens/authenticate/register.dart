import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;

  Register({required this.toggleView});


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field states
  String email = '';
  String password = '';
  String error = '';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to Brew Crew'),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(Icons.person, color: Colors.black,),
            label: Text('Sign in', style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.2, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) =>
                (val as String).isEmpty
                    ? 'Enter an email'
                    : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) =>
                val == null || val.length < 6
                    ? 'Enter a password 6+ characters long'
                    : null,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  if (_formKey.currentState!.validate()) {
                    dynamic result = await auth.registerWithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      setState(() {
                        error = 'please supply a valid email';
                        loading = false;
                      });
                    }
                  }

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[100],
                ),
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
