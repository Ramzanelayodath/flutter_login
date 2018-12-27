import 'package:flutter/material.dart';
class Homeb extends StatefulWidget
{
  String username = "";
  Homeb({
    this.username
  });
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }



}

class HomeState extends State<Homeb>
{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("HOME"),
        ),
        body: Container(
          child: Text(widget.username),
        ),

    );
  }



}