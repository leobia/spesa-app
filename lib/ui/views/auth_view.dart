import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:spesa_app/core/utils/auth.dart';
import 'package:spesa_app/ui/views/home_view.dart';

class AuthView extends StatefulWidget {
  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

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
                labelText: "Your email",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordField,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                fillColor: Colors.deepPurpleAccent,
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text("Forgotten password?"),
                style: ButtonStyle(),
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
                  bool shouldNavigate = await signInOrRegister(
                      _emailField.text, _passwordField.text);
                  if (shouldNavigate) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeView()));
                  }
                },
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              Expanded(
                child: new Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                  child: Divider(
                    color: Colors.grey,
                    height: 36,
                    thickness: 0.80,
                  ),
                ),
              ),
              Text("OR"),
              Expanded(
                child: new Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: Divider(
                    color: Colors.grey,
                    height: 36,
                    thickness: 0.80,
                  ),
                ),
              ),
            ]),
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
                text: "Continue with Google",
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                onPressed: () async {
                  var shouldNavigate = await signInWithGoogle();
                  if (shouldNavigate) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeView()));
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
