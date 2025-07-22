import 'package:flutter/material.dart';
import 'package:recycle_me/services/widget_support.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
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
            Text("Admin Login", style: AppWidget.headlinetextstyle(26),),
            SizedBox(height: 20.0,),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(96, 76, 175, 79),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.0,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("UserName", style: AppWidget.whitetextstyle(18),),
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration : BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
                            child: TextField(
                              decoration: InputDecoration(border: InputBorder.none, hintText: "Enter userName", prefixIcon: Icon(Icons.person, color: Colors.green,)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("Password", style: AppWidget.whitetextstyle(18),),
                    ),
                    SizedBox(height: 10.0,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 20.0, right: 20.0),
                            decoration : BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
                            child: TextField(textAlign: TextAlign.start,
                              decoration: InputDecoration(border: InputBorder.none, hintText: "Password", prefixIcon: Icon(Icons.person, color: Colors.green,)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Center(
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(20.0)),
                        child: Center(child: Text("Login", style: AppWidget.whitetextstyle(20),)),
                      ),
                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
