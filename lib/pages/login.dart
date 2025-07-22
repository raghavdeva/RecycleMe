import 'package:flutter/material.dart';
import 'package:recycle_me/services/widget_support.dart';

import '../services/auth.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                "images/login.png",
              height: 300,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20.0,),
            Image.asset("images/recycle1.png", height: 120, width: 120, fit: BoxFit.cover,),
            SizedBox(height: 20.0,),
            Text("Reduce. Reuse. Recycle.", style: AppWidget.headlinetextstyle(25.0),),
            Text("Repeat ! ", style: AppWidget.greentextstyle(32.0),),
            Text("Your every action\n makes a difference !", textAlign: TextAlign.center, style: AppWidget.normaltextstyle(15.0),),
            SizedBox(height: 30.0,),
            GestureDetector(
              onTap: () {
                AuthMethod().signInWithGoogle(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 20.0),
                    height: 60,
                    width: MediaQuery.of(context).size.width/1.2,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(60)),
                            child: Image.asset("images/google.png", height: 30, width: 30, fit: BoxFit.cover,)),
                        SizedBox(width: 20,),
                        Text("Sign in wiht Google", style: AppWidget.whitetextstyle(22.0),)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
