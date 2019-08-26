import 'package:aun_ubru/screens/my_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authuen extends StatefulWidget {
  @override
  _AuthuenState createState() => _AuthuenState();
}

class _AuthuenState extends State<Authuen> {
//Explicit
  Color myColor = Colors.blue.shade900; //สี
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String email = '', password = '';
  final formKey = GlobalKey<FormState>();

//Method
  Widget loginButton() {
    return FloatingActionButton(
      backgroundColor: myColor,
      child: Icon(
        Icons.navigate_next,
        size: 36.0,
      ),
      onPressed: () {
        formKey.currentState.save();
        print('email = $email, password = $password');
        checkAuthen();
        // checkAuthen();
      },
    );
  }

  Future<void> checkAuthen() async {
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((response) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      myAlert(title, message);
    });
  }

  void myAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: showTitle(title),
            content: Text(message),
            actions: <Widget>[okButton()],
          );
        });
  }

  Widget okButton() {
    return FlatButton(
      child: Text('OK'),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget showTitle(String title) {
    //Alert
    return ListTile(
      leading: Icon(
        Icons.add_alert,
        color: Colors.red,
      ),
      title: Text(title, style: TextStyle(color: Colors.red)),
    );
  }

  Widget backButton() {
    return IconButton(
      icon: Icon(
        Icons.navigate_before,
        color: myColor,
        size: 36.0,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress, //.com @
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          size: 36.0,
          color: myColor,
        ),
        labelText: 'Email :',
        labelStyle: TextStyle(color: myColor),
      ),
      onSaved: (String value) {
        email = value;
      },
    ); //เส้นพิมได้
  }

  Widget passwordText() {
    return TextFormField(
      obscureText: true, //สตาร์ password
      decoration: InputDecoration(
          icon: Icon(
            Icons.https,
            size: 36.0,
            color: myColor,
          ),
          labelText: 'Password :',
          labelStyle: TextStyle(color: myColor)),
      onSaved: (String value) {
        password = value;
      },
    ); //เส้นพิมพ์ได้
  }

  Widget showName() {
    return ListTile(
      leading: ImageIcon(
        AssetImage(
          'images/doc.png',
        ),
        size: 36.0,
        color: myColor,
      ), //icon img
      title: Text(
        'Aun UBRN',
        style: TextStyle(
          fontSize: 30.0,
          color: myColor,
          fontFamily: 'PTSansNarrow',
        ),
      ),
    );
  }

  Widget showAuthen() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/ice.jpg'),
              fit: BoxFit.cover)), //ใส่รูปพื้นหลัง cover สวยงาม
      alignment: Alignment.center, //กำหนดกึ่งกลาง
      child: Container(
        padding: EdgeInsets.all(20.0), //กำหนดกรอบ
        color: Color.fromRGBO(255, 255, 255, 0.5), //แอลฟา
        width: 300.0, //กำหนดขนาด

        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min, //ขนาดพอดีอักษร
            mainAxisAlignment: MainAxisAlignment.center, //ลงล่าง center ตรงกลาง
            children: <Widget>[
              showName(),
              emailText(),
              passwordText(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            showAuthen(),
            backButton(),
          ],
        ),
      ),
      floatingActionButton: loginButton(),
    );
  }
}
