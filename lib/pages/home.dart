import 'package:flutter/material.dart';
import 'package:recycle_me/pages/upload_item.dart';
import 'package:recycle_me/services/dabase.dart';
import 'package:recycle_me/services/shared_pref.dart';
import 'package:recycle_me/services/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // <<< ADD THIS LINE


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? id, name;
  Stream? pendingApprovalStream;



  Widget allApproval(){
    return StreamBuilder(stream: pendingApprovalStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData? ListView.builder(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index){
            DocumentSnapshot ds = snapshot.data.docs[index];
            return Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black45, width: 2.0), borderRadius: BorderRadius.circular(20.0)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.green,
                        size: 30.0,
                      ),
                      Text(
                        ds["Address"],
                        style: AppWidget.normaltextstyle(20.0),
                      )
                    ],
                  ),
                  Divider(),
                  Image.asset(
                    "images/chips.png",
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            );
          }
      )
          :Container();
    });
  }

  getthesharedpref() async{
    id = await SharedPrefHelper().getUserId();
    name = await SharedPrefHelper().getUserName();
    setState(() {

    });
  }

  ontheload() async{
    await getthesharedpref();
    pendingApprovalStream = await DatabaseMethods().getUserPendingRequest(id!);
    setState(() {

    });
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: name == null ? Center(child: CircularProgressIndicator()):SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 5.0,
                    ),
                    Image.asset(
                      "images/wave.png",
                      height: 40,
                      width: 40,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "Hello, ",
                      style: AppWidget.normaltextstyle(25.0),
                    ),
                    Text(
                      name!,
                      style: AppWidget.greentextstyle(25.0),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.asset(
                            "images/boy.jpg",
                            height: 40,
                            width: 40,
                            fit: BoxFit.fill,
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Image.asset("images/home.png"),
                )),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Categories",
                    style: AppWidget.headlinetextstyle(22),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadItem(category: "Plastic", id: id!,)));
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Color(0xFFececf8),
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Image.asset(
                                "images/plastic.png",
                                height: 60,
                                width: 60,
                              ),
                            ),
                            Text(
                              "Plastic",
                              style: AppWidget.normaltextstyle(16.0),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 15.0),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFececf8),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Image.asset(
                              "images/paper.png",
                              height: 60,
                              width: 60,
                            ),
                          ),
                          Text(
                            "Paper",
                            style: AppWidget.normaltextstyle(16.0),
                          )
                        ],
                      ),
                      SizedBox(width: 15.0),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFececf8),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Image.asset(
                              "images/glass.png",
                              height: 60,
                              width: 60,
                            ),
                          ),
                          Text(
                            "Glass",
                            style: AppWidget.normaltextstyle(16.0),
                          )
                        ],
                      ),
                      SizedBox(width: 15.0),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Color(0xFFececf8),
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Image.asset(
                              "images/battery.png",
                              height: 60,
                              width: 60,
                            ),
                          ),
                          Text(
                            "Battery",
                            style: AppWidget.normaltextstyle(16.0),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Pending Transaction",
                    style: AppWidget.headlinetextstyle(22),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                    height: MediaQuery.of(context).size.height/3,
                    child: allApproval()
                ),

                SizedBox(height: 30.0,)
              ],
            )),
      ),
    );
  }
}
