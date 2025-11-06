import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});



  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>(context);
    print(user);

    // return either authentic or home widget

    if(user == null){
      return Authenticate();
    } else {
      return Home();
    }


    return Authenticate();
  }
}
