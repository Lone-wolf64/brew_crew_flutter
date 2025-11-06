import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/models/brew_tile.dart';


class BrewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        final brew = brews[index];
        return BrewTile(brew: Brew(name: brew.name, strength: brew.strength, sugars: brew.sugars)); // Replace with your actual tile widget
      },
    );
  }
}


