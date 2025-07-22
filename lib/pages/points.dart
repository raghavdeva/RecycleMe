import 'package:flutter/material.dart';
import 'package:recycle_me/services/dabase.dart';
import 'package:recycle_me/services/shared_pref.dart';
import 'package:random_string/random_string.dart';
import '../services/widget_support.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Points extends StatefulWidget {
  const Points({super.key});

  @override
  State<Points> createState() => _PointsState();
}

class _PointsState extends State<Points> {
  String? id, mypoints, name;

  getthesharedpref() async {
    id = await SharedPrefHelper().getUserId();
    name = await SharedPrefHelper().getUserName();
    setState(() {});
  }
  Stream? pointStream;
  ontheload() async {
    await getthesharedpref();
    mypoints = await getUserPoints(id!);
    pointStream = await DatabaseMethods().getUserTransactions(id!);
    setState(() {});
  }


  @override
  void initState() {
    ontheload();
    // TODO: implement initState
    super.initState();
  }

  Future<String> getUserPoints(String docId) async {
    try {
      DocumentSnapshot docSnapShot =
          await FirebaseFirestore.instance.collection("users").doc(docId).get();
      if (docSnapShot.exists) {
        var userPoints = docSnapShot.data() as Map<String, dynamic>;
        var points = userPoints['Points'];
        return points.toString();
      } else {
        return 'No documets';
      }
    } catch (e) {
      print("Error Feteching the points");
      return 'Error';
    }
  }

  TextEditingController pointController = new TextEditingController();
  TextEditingController upiController = new TextEditingController();
  Widget allApproval(){
    return StreamBuilder(stream: pointStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData? ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index){
            DocumentSnapshot ds = snapshot.data.docs[index];
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color.fromARGB(
                        255, 221, 244, 217)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        ds["Date"],
                        textAlign: TextAlign.center,
                        style:
                        AppWidget.whitetextstyle(22.0),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Column(
                      children: [
                        Text("Reedem Points", style: AppWidget.normaltextstyle(20.0),),
                        Text(ds["Points"], style: AppWidget.greentextstyle(20.0),)
                      ],
                    ),
                    SizedBox(width: 20.0,),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: ds["Status"] == "Approved"?  Color.fromARGB(
                              129, 110, 239, 108) :const Color.fromARGB(62, 241, 77, 66),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(ds["Status"], style: TextStyle(color: ds["Status"] == "Approved"? Colors.green : Colors.red, fontSize: 12.0, fontWeight: FontWeight.bold),),
                    )
              
                  ],
                ),
              ),
            );
          }
      )
          :Container();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mypoints == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.only(top: 40.0),
              child: Column(
                children: [
                  Center(
                      child: Text(
                    "Points Page",
                    style: AppWidget.headlinetextstyle(22.0),
                  )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 221, 244, 217),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            padding: EdgeInsets.all(15),
                            margin: EdgeInsets.only(left: 20.0, right: 20.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Row(
                              children: [
                                Image.asset(
                                  "images/coin.png",
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  width: 30.0,
                                ),
                                Column(
                                  children: [
                                    Text("Points Earned",
                                        style: AppWidget.normaltextstyle(20.0)),
                                    Text(
                                      mypoints.toString(),
                                      style: AppWidget.greentextstyle(30.0),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              openBox();
                            },
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(20.0)),
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Center(
                                    child: Text("Redeem Points",
                                        style: AppWidget.whitetextstyle(20.0))),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0))),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Last Transactions",
                                    style: AppWidget.normaltextstyle(20),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height/2.5,
                                      child: allApproval()
                                  ),

                                ],
                              ),
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

  Future openBox() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text("Redeem Points",
                            style: AppWidget.greentextstyle(20.0))
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Add Points",
                      style: AppWidget.normaltextstyle(20.0),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.0),
                      ),
                      child: TextField(
                        controller: pointController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Points",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Add UPI ID",
                      style: AppWidget.normaltextstyle(20.0),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.0),
                      ),
                      child: TextField(
                        controller: upiController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter UPI",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (pointController.text != "" &&
                            upiController != "" &&
                            int.parse(pointController.text) <
                                int.parse(mypoints!)) {
                          DateTime now = DateTime.now();
                          String formattedDate =
                              DateFormat('d\nMMM').format(now);
                          int updatedpoints = int.parse(mypoints!) -
                              int.parse(pointController.text);
                          await DatabaseMethods()
                              .updateUserPoints(id!, updatedpoints.toString());
                          Map<String, dynamic> userReedemMap = {
                            "Name": name,
                            "Points": pointController.text,
                            "UPI": upiController.text,
                            "Status": "Pending",
                            "Date": formattedDate,
                            "UserId" : id,
                          };
                          String reedemId = randomAlphaNumeric(10);
                          await DatabaseMethods().addUserReedemPoints(
                              userReedemMap, id!, reedemId);
                          await DatabaseMethods()
                              .addAdminReedemRequest(userReedemMap, reedemId);
                          mypoints = await getUserPoints(id!);
                          setState(() {});
                          Navigator.pop(context);
                        }
                      },
                      child: Center(
                        child: Container(
                          width: 100,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Center(
                              child: Text(
                            "Redeem",
                            style: AppWidget.whitetextstyle(20.0),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
}
