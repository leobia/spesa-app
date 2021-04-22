import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:spesa_app/core/utils/auth.dart';
import 'package:spesa_app/ui_components/text_separator.dart';

class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image(
                image: AssetImage('assets/login.png'),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailField,
              decoration: InputDecoration(
                labelText: 'Your email',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordField,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                fillColor: Colors.deepPurpleAccent,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(),
                child: Text('Forgotten password?'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.0),
                color: Theme.of(context).primaryColor,
              ),
              child: MaterialButton(
                onPressed: () async {
                  var shouldNavigate = await signInOrRegister(
                      _emailField.text, _passwordField.text);
                  if (shouldNavigate) {
                    await Navigator.pushNamed(context, '/home');
                  }
                },
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextSeparator(
              textMargin: 20.0,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
              ),
              child: SignInButton(
                Buttons.Google,
                text: 'Continue with Google',
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                onPressed: () async {
                  var shouldNavigate = await signInWithGoogle();
                  if (shouldNavigate) {
                    await Navigator.pushNamed(context, '/home');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
