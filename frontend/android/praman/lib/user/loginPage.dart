import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:praman/widgets/AppBar.dart';

enum FormType { login, register }

class UserLoginpage extends StatefulWidget {
  @override
  _UserLoginpageState createState() => _UserLoginpageState();
}

class _UserLoginpageState extends State<UserLoginpage> {
  TextEditingController _aadharController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FormType _formType = FormType.login;

  bool obscureText = false;

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
      controller: _aadharController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
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
    return [
      SizedBox(
        height: MediaQuery.of(context).size.height * .1,
      ),
      Center(
        child: Text(
          (_formType == FormType.login ? "Login" : "SignIn"),
          style: GoogleFonts.robotoCondensed(fontSize: 25),
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * .1,
      ),
      _aadharTextField(),
      _passwordtextField(),
      SizedBox(
        height: 20,
      ),
      RaisedButton(
        color: Colors.grey,
        child: Text(_formType == FormType.login ? "Login" : "Register"),
        onPressed: () {},
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
      RaisedButton.icon(
        color: Colors.grey,
        onPressed: () {},
        icon: Icon(Icons.group),
        label: Text("Certifier?"),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getBasicAppbar(),
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: formBuilder(context),
              )),
        ),
      ),
    );
  }
}
