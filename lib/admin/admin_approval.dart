import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // <<< ADD THIS LINE

import '../services/dabase.dart';
import '../services/widget_support.dart';

class AdminApproval extends StatefulWidget {
  const AdminApproval({super.key});

  @override
  State<AdminApproval> createState() => _AdminApprovalState();
}

class _AdminApprovalState extends State<AdminApproval> {
  Stream? approvalStream;
  getApprovalStream() async{
    approvalStream = await DatabaseMethods().getAdminApproval();
    setState(() {

    });
  }

  @override
  void initState() {
    getApprovalStream();
    // TODO: implement initState
    super.initState();
  }

  Future<String> getUserPoints(String docId) async{
    try{
      DocumentSnapshot docSnapShot = await FirebaseFirestore.instance.collection("users").doc(docId).get();
      if(docSnapShot.exists){
        var userPoints = docSnapShot.data() as Map<String, dynamic>;
        var points = userPoints['Points'];
        return points.toString();
      }else{
        return 'No documets';
      }
    }catch(e){
      print("Error Feteching the points");
      return 'Error';
    }
  }


  Widget allApproval(){
    return StreamBuilder(stream: approvalStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData? ListView.builder(
        padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index){
          DocumentSnapshot ds = snapshot.data.docs[index];
          return Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            width : MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
            child: Row(
              children: [
                Container(
                  child: Image.asset("images/coca.png", height: 120, width: 120,fit: BoxFit.contain,),
                  decoration: BoxDecoration(border: Border.all(color: Colors.black45, width: 2.0), borderRadius: BorderRadius.circular(20.0)),
                ),
                SizedBox(width: 20.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.green, size: 28,),
                        SizedBox(width: 5.0,),
                        Text(ds["Name"], style: AppWidget.normaltextstyle(14.0),),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.green, size: 28,),
                        SizedBox(width: 5.0,),
                        Container(
                            width: MediaQuery.of(context).size.width/3,
                            child: Text(ds["Address"], style: AppWidget.normaltextstyle(14.0),)),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.inventory_2, color: Colors.green, size: 28,),
                        SizedBox(width: 5.0,),
                        Container(
                            width: MediaQuery.of(context).size.width/3,
                            child: Text(ds["Quantity"], style: AppWidget.normaltextstyle(14.0),)),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: ()async{
                        String getuserpoints = await getUserPoints(ds["UserId"]);
                        int updatedpoints = int.parse(getuserpoints)+100;
                        await DatabaseMethods().updateUserPoints(ds["UserId"], updatedpoints.toString());
                        await DatabaseMethods().updateAdmingRequest(ds.id);
                        await DatabaseMethods().updateUserRequest(ds["UserId"], ds.id);
                      },
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(color:  Colors.black, borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text("Approve", style: AppWidget.whitetextstyle(16),),
                        ),
                      ),
                    )
                  ],
                )
              ],
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
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
          Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Row(
            children: [
              Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(60.0),
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,size: 25.0,),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width/9,),
              Text("Adming Approval", style: AppWidget.headlinetextstyle(25.0),),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SizedBox(height: 20.0,),
              Container(
                  height: MediaQuery.of(context).size.height/1.5,
                  child: allApproval()),
            ]
          )
        )
          ]
        )
      ),
    );
  }
}
