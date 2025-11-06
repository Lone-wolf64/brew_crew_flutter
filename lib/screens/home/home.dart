import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';

import '../../models/user.dart';
// Make sure Brew model is imported

class Home extends StatelessWidget {
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void showSettingsPane() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>>(
      create: (context) {
        final user = Provider.of<CustomUser>(context, listen: false);
        return DatabaseService(uid: user.uid).brews;
      },
      initialData: const [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            TextButton(
              onPressed: () => showSettingsPane(),
              child: Row(
                children: [
                  Icon(Icons.settings, color: Colors.black),
                  SizedBox(width: 5),
                  Text('Settings', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                await auth.signOut();
              },
              child: Row(
                children: [
                  Icon(Icons.person, color: Colors.black),
                  SizedBox(width: 5),
                  Text('Logout', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/img.png'),fit: BoxFit.cover)
          ),
            child: BrewList()),
      ),
    );
  }
}
