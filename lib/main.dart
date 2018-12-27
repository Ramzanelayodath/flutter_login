import 'package:flutter/material.dart';
import 'package:flutter_login/DBHelper.dart';
import 'package:flutter_login/Home.dart';
import 'package:flutter_login/Register.dart';
import 'package:flutter_login/User.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}

class Home extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }

}

class HomeState extends State<Home> {
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String username;
  String password;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: Colors.blue,
        ),
        body: Align(alignment: Alignment.center, child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
                child: Column(
                    children: <Widget>[
                      Form(key: formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Username'),
                                validator: (val) =>
                                val.length == 0 ? "Enter Username" : null,
                                onSaved: (val) => this.username = val,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Password'),
                                obscureText: true,
                                validator: (val) =>
                                val.length == 0 ? "Enter Password" : null,
                                onSaved: (val) => this.password = val,
                              ),

                            ],
                          )),
                      Padding(padding: EdgeInsets.all(8.0),
                          child: SizedBox(
                              width: double.infinity,
                              height: 50.0,
                              child: MaterialButton(
                                onPressed: () {
                                Login();
                                },
                                textColor: Colors.white,
                                child: Text("Login",
                                  style: TextStyle(
                                      color: Colors.white
                                  ),),
                                color: Colors.blue,
                              )
                          )),
                      FlatButton(onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      }, child: Text("Register"))

                    ]
                )
            )
        )));
  }

  void Login() {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
      getData(username,password);
    }
    else {
      return null;
    }
  }

  void getData(String username,String password) {
    String ret_password = "";
    var dbHelper = DBHelper();
    dbHelper.getUser(username).then((List<User> employee){
      for(int i =0; i< employee.length; i++)
      {
        print("returned data "+employee[i].password);
        ret_password = employee[i].password;
      }
        if(employee.length == 0)
        {
          showDialog(context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: Text("Oops.."),
              content: Text("User not exists"),
              actions: <Widget>[
                FlatButton(
                  child: Text("close"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
        }
        else {
              if(ret_password == password)
                {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (_) => Homeb(username: username,)));
                }
                else{
                  print("Password Not match");
                  showDialog(context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("Oops.."),
                          content: Text("Password not match"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("close"),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });

              }
          }
   }


    );
  }
  }


