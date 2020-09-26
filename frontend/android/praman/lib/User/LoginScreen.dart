import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum FormType { login, signup }

class _LoginScreenState extends State<LoginScreen> {
  FormType _formType = FormType.login;
  bool passwordObscure = true;
  TextField uidField() {
    return TextField(
      decoration: InputDecoration(
        hintText: "UID",
        suffixIcon: Icon(
          Icons.supervised_user_circle,
        ),
      ),
    );
  }

  TextField passwordField() {
    return TextField(
      obscureText: passwordObscure,
      decoration: InputDecoration(
          hintText: "Password",
          suffix: IconButton(
              icon: Icon(
                passwordObscure ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  passwordObscure = !passwordObscure;
                });
              })),
    );
  }

  FlatButton customFlattie({Function callbackF, String customTitle}) {
    return FlatButton(
        onPressed: callbackF,
        child: Text(
          customTitle,
          style: GoogleFonts.abel(
            fontSize: 20,
          ),
        ));
  }

  List<Widget> formBuilder() {
    return [
      uidField(),
      passwordField(),
      SizedBox(
        height: 30,
      ),
      RaisedButton(
        onPressed: () {},
        child: Text(_formType != FormType.login ? "SignUp" : "Login"),
      ),
      SizedBox(
        height: 30,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          customFlattie(
              callbackF: () {
                setState(() {
                  if (_formType == FormType.login) {
                    _formType = FormType.signup;
                  } else {
                    _formType = FormType.login;
                  }
                });
              },
              customTitle: _formType == FormType.login ? "SignUp" : "Login"),
          customFlattie(callbackF: () {}, customTitle: "Forgot Password"),
        ],
      ),
      SizedBox(
        height: 30,
      ),
      RaisedButton(
        onPressed: () {},
        child: Text("Certifier?"),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Praman"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: formBuilder(),
            ),
          ),
        ),
      ),
    );
  }
}
