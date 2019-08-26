import 'package:aun_ubru/screens/my_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
//Explicit
  Color nameColor = Colors.green.shade400;
  Color emailColor = Colors.blue.shade400;
  Color passwordColor = Colors.pink.shade400;
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//Method

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.face,
          size: 36.0,
          color: nameColor,
        ),
        labelText: 'Name :',
        labelStyle: TextStyle(color: nameColor),
        helperText: 'Type Your Display Name',
        helperStyle: TextStyle(color: nameColor),
        hintText: 'English only',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please Fill Name in Blank';
        }
      },
      onSaved: (String value) {
        nameString = value;
      },
    ); //กรอกข้อมูล
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          size: 36.0,
          color: emailColor,
        ),
        labelText: 'Email :',
        labelStyle: TextStyle(color: emailColor),
        helperText: 'Type Your E-mail',
        helperStyle: TextStyle(color: emailColor),
        hintText: 'Your@email.com',
      ),
      validator: (String value) {
        if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Please Type Email Format';
        }
      },
      onSaved: (String value) {
        emailString = value;
      },
    ); //กรอกข้อมูล
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.https,
          size: 36.0,
          color: passwordColor,
        ),
        labelText: 'Password :',
        labelStyle: TextStyle(color: passwordColor),
        helperText: 'Type Your Password',
        helperStyle: TextStyle(color: passwordColor),
        hintText: 'More 6 Charactor',
      ),
      validator: (String value) {
        if (value.length < 6) {
          return 'Password More 6 Charactor';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
    ); //กรอกข้อมูล
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print(
              'name = $nameString,email =$emailString,password=$passwordString'); //print 'ชื่อ =$,'
          registerThread();
        }
      },
    );
  }

  Future<void> registerThread() async {
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Success Register');
      setupDisplayName();
    }).catchError((response) {
      print('response = ${response.toString()}');
      String title = response.code; //popup
      String message = response.message; //popup
      myAlert(title, message); //popup
    });
  }

  Future<void> setupDisplayName() async {
    await firebaseAuth.currentUser().then((response) {
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = nameString;
      response.updateProfile(userUpdateInfo);
//สมัครไม่ย้อนกลับ
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => MyService());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

// ทำ popup
  void myAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0xFF, 0xFF, 0xA0, 0x00),
        title: Text('Registe'),
        actions: <Widget>[
          registerButton(),
        ],
      ),
      body: Form(
        key: formKey, //ตัวแปลเก็บไว้ในฟร์อมคีย์
        child: ListView(
          padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 70.0),
          children: <Widget>[
            nameText(),
            emailText(),
            passwordText(),
          ],
        ),
      ),
    );
  }
}
