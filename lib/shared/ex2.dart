// import 'package:brew_crew/models/user.dart';
// import 'package:brew_crew/services/database.dart';
// import 'package:firebase_auth/firebase_auth.dart' show User;
// import 'package:flutter/material.dart';
// import 'package:brew_crew/shared/constants.dart';
// import 'package:provider/provider.dart';
//
// import '../../models/user.dart';
// import '../../shared/loading.dart';
//
// class SettingsForm extends StatefulWidget {
//   @override
//   State<SettingsForm> createState() => _SettingsFormState();
// }
//
// class _SettingsFormState extends State<SettingsForm> {
//   final formKey = GlobalKey<FormState>();
//   final List<String> sugars = ['0', '1', '2', '3', '4'];
//
//   //form values
//   String _currentName = '';
//   String _currentSugars = '0';
//   int? _currentStrength = null;
//
//   @override
//   Widget build(BuildContext context) {
//
//     final user = Provider.of<CustomUser>(context);
//
//     return StreamBuilder<UserData>(
//         stream: DatabaseService(uid: user.uid).userData,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             UserData? userData = snapshot.data;
//             return Form(
//               child: Column(
//                 children: <Widget>[
//                   Text('Update your brew settings.',
//                       style: TextStyle(fontSize: 18.0)),
//                   SizedBox(height: 20.0,),
//                   TextFormField(
//                     initialValue: userData?.name,
//                     decoration: textInputDecoration,
//                     validator: (val) =>
//                     val!.isEmpty
//                         ? 'Please enter a name'
//                         : null,
//                     onChanged: (val) =>
//                         setState(() {
//                           _currentName = val;
//                         }),
//                   ),
//                   SizedBox(height: 20.0,),
//                   //dropdown
//                   DropdownButtonFormField<String>(
//                     value: _currentSugars,
//                     items: sugars.map((sugar) {
//                       return DropdownMenuItem(
//
//                         value: sugar,
//                         child: Text('$sugar sugars'),);
//                     }).toList(),
//                     onChanged: (val) =>
//                         setState(() => _currentSugars = val! as String),),
//                   SizedBox(height: 8.0,),
//                   //slider
//                   Slider(value: (_currentStrength ?? 100).toDouble(),
//                     activeColor: Colors.brown[_currentStrength ?? 100],
//                     inactiveColor: Colors.brown[_currentStrength ?? 100],
//                     min: 100.0,
//                     max: 900.0,
//                     divisions: 8,
//                     onChanged: (val) =>
//                         setState(() {
//                           _currentStrength = val.round();
//                         }),),
//                   ElevatedButton(onPressed: () async {
//                     print(_currentName);
//                     print(_currentSugars);
//                     print(_currentStrength);
//                   },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.brown,
//                       ),
//                       child: Text(
//                         'Update', style: TextStyle(color: Colors.white),))
//                 ],
//               ),
//             );
//           } else {
//             return Loading();
//           }
//         }
//     );
//   }
// }
