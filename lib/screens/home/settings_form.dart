import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';
import '../../shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // Form values
  String _currentName = '';
  String _currentSugars = '0';
  int _currentStrength = 100;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    print('Using UID: ${user.uid}');

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        print('Connection state: ${snapshot.connectionState}');
        print('Has error: ${snapshot.hasError}');
        print('Error: ${snapshot.error}');
        print('Has data: ${snapshot.hasData}');
        print('Snapshot value: ${snapshot.data}');
        print('SettingForm UID:${user.uid}');

        if (snapshot.hasData) {
          UserData userData = snapshot.data!;

          // Initialize form values only once
          if (_currentName.isEmpty) {
            _currentName = userData.name;
            _currentSugars = userData.sugars;
            _currentStrength = userData.strength;
          }

          return Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),

                // Name field
                TextFormField(
                  initialValue: _currentName,
                  decoration: textInputDecoration,
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0),

                // Sugars dropdown
                DropdownButtonFormField<String>(
                  value: _currentSugars,
                  decoration: textInputDecoration,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val!),
                ),
                SizedBox(height: 20.0),

                // Strength slider
                Slider(
                  value: _currentStrength.toDouble(),
                  activeColor: Colors.brown[_currentStrength],
                  inactiveColor: Colors.brown[_currentStrength],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) =>
                      setState(() => _currentStrength = val.round()),
                ),

                // Submit button
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength,
                      );
                      Navigator.pop(context);
                      // You can call update logic here
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                  ),
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
