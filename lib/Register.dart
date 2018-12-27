import 'package:flutter/material.dart';
import 'package:flutter_login/DBHelper.dart';
import 'package:flutter_login/User.dart';

class app extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Register(),
    );
  }


}
class Register extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterState();
  }


}

class RegisterState extends State<Register>
{
  User user = new User("", "", "");
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String username;
  String Password;
  String name;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
          appBar: AppBar(
            title: Text("Register"),
          ),
          body:
        Container(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(8.0),
              child: Form(key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(hintText: "Username"),
                        validator: (val) =>
                          val.length == 0 ? "Enter Username" :null,
                          onSaved: (val) => this.username = val,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: "Passwrod"),
                        validator: (val) =>
                        val.length == 0 ? "Enter Password" :null,
                        onSaved: (val) => this.Password = val,
                        obscureText: true,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: "Name"),
                        validator: (val) =>
                        val.length == 0 ? "Enter name" :null,
                        onSaved: (val) => this.name = val
                      ),
                  SizedBox(
                      width: double.infinity,
                      height: 60.0,
                      child:Padding(padding: EdgeInsets.all(8.0),
                      child: MaterialButton(
                        onPressed: (){
                          Submit();

                        },
                        textColor: Colors.white,
                        child: Text("Register",
                          style: TextStyle(
                              color: Colors.white
                          ),),
                        color: Colors.blue,
                      ))
                  )

                    ],
                  )),)
            ],
          ),


    ));
  }
  void Submit()
  {
    if(this.formKey.currentState.validate())
      {
        formKey.currentState.save();
      } else
        {
          return null;
        }
    var user = User(username,Password,name);
    print("password ${Password}");
    var dbHelper = DBHelper();
    dbHelper.saveUser(user);

  }
}