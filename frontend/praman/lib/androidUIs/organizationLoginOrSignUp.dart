import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praman/Services/auth.dart';
import 'package:praman/Widgets/Appbar.dart';
import 'package:praman/Widgets/setSnackBar.dart';
import 'package:praman/androidUIs/AndroidUi.dart';
import 'package:praman/androidUIs/studentLoginOrSIgnUp.dart';

import 'package:provider/provider.dart';

class OrganizationLoginOrSignUp extends StatefulWidget {
  @override
  _OrganizationLoginOrSignUpState createState() =>
      _OrganizationLoginOrSignUpState();
}

enum FormType { login, register }

class _OrganizationLoginOrSignUpState extends State<OrganizationLoginOrSignUp> {
  TextEditingController _uidController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  FormType _formType = FormType.login;
  Auth authProvider;
  bool obscureText = false;
  String _value = null;
  List<DropdownMenuItem<String>> organizationType = [
    "School",
    "University",
    "Company",
    "NGO",
  ]
      .map((String e) => new DropdownMenuItem<String>(
            value: e,
            child: Text(e),
          ))
      .toList();

  void _toggleFormType() {
    if (_formType == FormType.login) {
      setState(() {
        _formType = FormType.register;
      });
    } else
      setState(() {
        _formType = FormType.login;
      });
  }

  TextFormField _aadharTextField() {
    return TextFormField(
      controller: _uidController,
      decoration: InputDecoration(
        labelText: 'UID number',
      ),
    );
  }

  TextFormField _passwordtextField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !obscureText,
      decoration: InputDecoration(
          labelText: 'Password',
          suffixIcon: IconButton(
            icon: obscureText
                ? Icon(Icons.visibility)
                : Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          )),
    );
  }

  TextFormField _nameTextField() {
    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: 'Name',
      ),
    );
  }

  FlatButton flatButton({@required Function onPressed, @required String text}) {
    return FlatButton(
      onPressed: onPressed,
      splashColor: Colors.black38,
      focusColor: Colors.black54,
      child: Text(
        text,
        style: GoogleFonts.abel(
          fontSize: 20,
        ),
      ),
    );
  }

  List<Widget> formBuilder(BuildContext context) {
    return <Widget>[
      SizedBox(
        height: MediaQuery.of(context).size.height * .1,
      ),
      Center(
        child: Text(
          (_formType == FormType.login ? "Login" : "SignIn") +
              " as Institution",
          style: GoogleFonts.robotoCondensed(fontSize: 20),
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * .1,
      ),
      _formType != FormType.login ? _nameTextField() : Container(),
      _aadharTextField(),
      _passwordtextField(),
      SizedBox(
        height: MediaQuery.of(context).size.height * .05,
      ),
      _formType == FormType.register
          ? DropdownButton<String>(
              items: organizationType,
              onChanged: (value) {
                setState(() {
                  _value = value;
                });
                print(_value);
              },
              hint: Text("Type of Institution"),
              value: _value,
            )
          : Container(),
      SizedBox(
        height: 20,
      ),
      RaisedButton(
        color: Colors.grey,
        child: Text(_formType == FormType.login ? "Login" : "Register"),
        onPressed: () {
          submitForm(context);
        },
      ),
      SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          flatButton(
            text: _formType == FormType.register ? "Login" : "Register",
            onPressed: _toggleFormType,
          ),
          flatButton(
            onPressed: () {},
            text: "Forgot Password",
          )
        ],
      ),
      SizedBox(
        height: 20,
      ),
      RaisedButton.icon(
        color: Colors.grey,
        onPressed: () {
          Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => StudentLoginOrSignupPage(),
              ));
        },
        icon: Icon(Icons.person),
        label: Text("Student?"),
      )
    ];
  }

  showBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(setSnackBar(
      msg,
    ));
  }

  Future submitForm(BuildContext context) async {
    if (_uidController.text == "" || _passwordController.text == "") {
      showBar(
        context,
        "Either UID number or password field is empty.",
      );
      return;
    }
    if (_uidController.text.length != 12) {
      showBar(
        context,
        "Invalid UID, UID should be 12 digits long.",
      );
      return;
    }
    if (_passwordController.text.length < 6) {
      showBar(
        context,
        "Password too short.",
      );

      return;
    }
    try {
      print("Trying");
      _formType == FormType.login
          ? await authProvider.loginInstitution(
              uid: _uidController.text,
              password: _passwordController.text,
            )
          : await authProvider.registerInstitution(
              uid: _uidController.text,
              password: _passwordController.text,
              type: _value,
              name: _nameController.text,
            );

      _formType == FormType.login
          ? Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => AndroidUi(),
              ))
          : showBar(context, "Registered Successfully");
    } catch (e) {
      print(e);
      if (e is PlatformException) showBar(context, e.message);
    }
    _uidController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthBase>(context);

    return Scaffold(
        appBar: getAppbar(),
        body: Builder(
          builder: (context) => SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: formBuilder(context),
            ),
          ),
        ));
  }
}
