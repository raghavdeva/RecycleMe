import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recycle_me/services/dabase.dart';
import '../services/widget_support.dart';

class AdminReedem extends StatefulWidget {
  const AdminReedem({super.key});

  @override
  State<AdminReedem> createState() => _AdminReedemState();
}

class _AdminReedemState extends State<AdminReedem> {
  Stream? reedemStream;

  getontheload()async{
    reedemStream = await DatabaseMethods().getAdminReedemApproval();
    setState(() {

    });
  }
  @override
  void initState() {
    getontheload();
    // TODO: implement initState
    super.initState();
  }

  Widget allApproval(){
    return StreamBuilder(stream: reedemStream, builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData? ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index){
            DocumentSnapshot ds = snapshot.data.docs[index];
            return Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(left: 20.0, right: 20.0),
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10.0),
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10.0)),
                  child: Text(ds["Date"], style: AppWidget.whitetextstyle(22),
                    textAlign: TextAlign.center,),
                ),
                SizedBox(width: 20.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.green, size: 25,),
                        SizedBox(width: 5.0,),
                        Text(ds["Name"], style: AppWidget.normaltextstyle(16),)
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.point_of_sale, color: Colors.green, size: 22,),
                        SizedBox(width: 5.0,),
                        Text("Points Reedem : "+ds["Points"], style: AppWidget.normaltextstyle(16),)
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.monetization_on, color: Colors.green, size: 22,),
                        SizedBox(width: 5.0,),
                        Text("UPI : "+ds["UPI"], style: AppWidget.normaltextstyle(16),)
                      ],
                    ),
                    GestureDetector(
                      onTap: ()async{
                        await DatabaseMethods().updateAdminReedemRequest(ds.id);
                        await DatabaseMethods().updateUserReedemRequest(ds["UserId"], ds.id);


                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 30.0),
                        width: 150,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text("Approve", style: AppWidget.whitetextstyle(20.0),),
                        ),
                      ),
                    )

                  ],
                )
              ],),
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
            child: Column(children: [
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
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 25.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 9,
                    ),
                    Text(
                      "Reedem Approval",
                      style: AppWidget.headlinetextstyle(25.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.0,),
                        Container(
                            height: MediaQuery.of(context).size.height/1.2,
                            child: allApproval()),

                      ]))
            ])));
  }
}
