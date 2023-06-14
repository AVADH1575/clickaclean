import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FavouriteHistoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavouriteHistoryScreen();
  }
}
class _FavouriteHistoryScreen extends State<FavouriteHistoryScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String value = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Favourites"),
        backgroundColor: Color.fromRGBO(125, 121, 204, 1),centerTitle: true,),

      body: Container(
        child:
        Align(
          alignment: FractionalOffset.center,
          child:Center(child: Text("No data found"),),),

      ),
    );
  }
}