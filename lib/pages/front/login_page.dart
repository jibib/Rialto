import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rialto/pages/front/front_page.dart';

class LoginPage extends FrontPage {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildWelcomeText(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _buildForm(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _buildLoginButton(),
            ),
            _buildSignUpButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return _buildButton("sign up", () {
      Navigator.of(context).pushNamed('/sign-up');
    });
  }

  Widget _buildLoginButton() {
    return _buildButton("login", () async {
      _formKey.currentState.save();
      try {
        AuthResult auth =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Successfully logged in!"),
          ),
        );
        Navigator.of(context).pushReplacementNamed('/home');
      } catch (e) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to login! (${e.code})"),
          ),
        );
      }
    });
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.7,
      height: 50,
      child: RaisedButton(
        child: Text(
          text,
          style: TextStyle(
            color: Theme
                .of(context)
                .accentColor,
            fontSize: 16,
          ),
        ),
        color: Theme
            .of(context)
            .primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Welcome to ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Rialto",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _buildForm() {
    const double borderRadius = 10.0;
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.7,
            child: TextFormField(
              validator: (email) {
                return null;
              },
              onSaved: (email) => _email = email,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(borderRadius),
                  ),
                ),
                hintText: 'Email',
                filled: true,
                fillColor: Theme
                    .of(context)
                    .accentColor,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * 0.7,
            child: TextFormField(
              validator: (password) {
                return null;
              },
              onSaved: (password) => _password = password,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(borderRadius),
                  ),
                ),
                filled: true,
                fillColor: Theme
                    .of(context)
                    .accentColor,
                hintText: 'Password',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
