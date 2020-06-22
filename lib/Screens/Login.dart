import 'package:flutter/material.dart';
import '../auth.dart';
import 'checkStatus.dart';


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/images/corona_guard.png"), width: MediaQuery.of(context).size.width-20),
              Flexible(
                    child:FractionallySizedBox(
                    heightFactor: 0.2,
                  )), 
              signInGoogleButton(context),
            ],
          ),
        ),
      );
  }
}

// TODO: for the storage reading thing
class RememberMeButton extends StatefulWidget {
  @override
  RememberMeButtonState createState() => RememberMeButtonState(); 
}

class RememberMeButtonState extends State<RememberMeButton> {

  @override
  Widget build(BuildContext context) {

    return Row(
      children: <Widget>[
        Radio(value: 0, groupValue: null, onChanged: null),
        Text('Remember Me'),
      ],
    );
  }
  
}

// primary stream builder to check whether the user is signed in or not
  // get the file io to work
  // read the key and transfer the values
// afterwards stateful for the one in which user isn't signed in, the sign in screen will pop up and then the the drop down and personal survey maybe
// if the user is signed in then the user will be fdirected to the maps page and there will be a second page for changign their status and the survey thing

Widget signInGoogleButton(BuildContext context) {
  return OutlineButton(
      splashColor: Colors.black,
      onPressed: (){
          authService.googleSignIn(); 
          Navigator.of(context).push(_createRoute());
          } ,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.yellow[400],
                ),
              ),
            )
          ],
        ),
      ),
    );
}

Route _createRoute(){
    return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => CheckStatus(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
