import 'package:brewcrew/models/brew.dart';
import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../brew_tile.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {


    final brews = Provider.of<List<Brew>>(context)??[];



      brews.forEach((brew) {
        print(brew.name);
        print(brew.sugars);
        print(brew.strength);
        print(brew.group);
      });


    return ListView.builder(
    itemCount: brews.length,
        itemBuilder: (context,index){
      return BrewTile(brewt:brews[index]);
    }
    );
  }
}