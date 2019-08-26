import 'package:aun_ubru/screens/authen.dart';
import 'package:aun_ubru/screens/my_service.dart';
import 'package:aun_ubru/screens/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
//Explicit
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//Method
  @override //เช็คสถานะ
  void initState() {
    super.initState();
    checkStatus();
  }

  Future<void> checkStatus() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }
  }

  Widget mySizebox() {
    return SizedBox(
      height: 16.0,
    );
  }

  Widget signInButton() {
    return Expanded(
      child: RaisedButton(
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.blue.shade400),
        ),
        onPressed: () {
          MaterialPageRoute materialPageRoute =
              MaterialPageRoute(builder: (BuildContext context) => Authuen());
              Navigator.of(context).push(materialPageRoute);
        },
      ),
    );
  }

  Widget signUpButton() {
    return Expanded(
      child: OutlineButton(
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.blue.shade400),
        ),
        onPressed: () {
          print('You Click SingUp');
          MaterialPageRoute materialPageRoute =
              MaterialPageRoute(builder: (BuildContext context) => Register());
          Navigator.of(context).push(materialPageRoute);
        },
      ),
    );
  }

  Widget showButton() {
    return Container(
      margin: EdgeInsets.only(left: 50.0, right: 50.0),
      child: Row(
        children: <Widget>[signInButton(), signUpButton()],
      ),
    );
  }

  Widget showLogo() {
    return Container(
        alignment: Alignment.center,
        child: Container(
          width: 150.0,
          height: 150.0,
          child: Image.asset('images/doc.png'),
        ));
  }

  Widget showAppName() {
    return Text(
      'AUN UBRU',
      style: TextStyle(
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.blue[400],
        fontFamily: 'PTSansNarrow',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: RadialGradient(
        colors: [Colors.white, Colors.blue],
        radius: 1.0,
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          showLogo(),
          mySizebox(),
          showAppName(),
          showButton(),
        ],
      ),
    ));
  }
}
