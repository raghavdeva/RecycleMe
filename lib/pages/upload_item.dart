import 'dart:io';
import 'package:random_string/random_string.dart';
import 'package:flutter/material.dart';
import 'package:recycle_me/services/dabase.dart';
import 'package:recycle_me/services/widget_support.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../services/shared_pref.dart';


class UploadItem extends StatefulWidget {
  String category,id;
  UploadItem({required this.category, required this.id});

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {

  TextEditingController addresscontroller = new TextEditingController();
  TextEditingController quantitytcontroller = new TextEditingController();

  String? id, name;
  getthesharedpref() async{
    id = await SharedPrefHelper().getUserId();
    name = await SharedPrefHelper().getUserName();
  }

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage() async{
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {

    });
  }

@override
  void initState() {
    getthesharedpref();
    // TODO: implement initState
    super.initState();
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
                SizedBox(width: MediaQuery.of(context).size.width/5,),
                Text("Upload Item", style: AppWidget.headlinetextstyle(25.0),),
              ],
            ),
          ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.0),
                  selectedImage != null ? Center(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black45, width: 2.0), borderRadius: BorderRadius.circular(20.0)),
                      height: 180,
                      width: 180,
                      child: Image.file(selectedImage!, fit: BoxFit.cover),
                    ),
                  ) : GestureDetector(
                    onTap: (){
                      getImage();
                    },
                    child: Center(
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black45, width: 2.0), borderRadius: BorderRadius.circular(20.0)),
                        child: Icon(Icons.camera_alt_outlined, color: Colors.black, size: 50.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left:20.0, right: 20.0),
                    child: Text("Enter your Address from where you want item to be picked", style: AppWidget.normaltextstyle(16.0),),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0), border: Border.all(color: Colors.black45, width: 2.0)),
                    child: Center(
                      child: TextField(
                        controller: addresscontroller,
                        decoration: InputDecoration(border: InputBorder.none,prefixIcon: Icon(Icons.location_on_outlined), hintText: "Enter your address"),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.only(left:20.0, right: 20.0),
                    child: Text("Enter the quantity of item", style: AppWidget.normaltextstyle(16.0),),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0), border: Border.all(color: Colors.black45, width: 2.0)),
                    child: Center(
                      child: TextField(
                        controller: quantitytcontroller,
                        decoration: InputDecoration(border: InputBorder.none,prefixIcon: Icon(Icons.inventory_2_outlined), hintText: "Enter Quantity"),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0,),
                  GestureDetector(
                    onTap: () async{
                       if(addresscontroller.text != "" && quantitytcontroller.text != ""){
                      String itemid = randomAlphaNumeric(10);
                      //   Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("blogImage").child(itemid);
                      //   final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
                      //   var downloadUrl = await (await task).ref.getDownloadURL();

                        Map<String, dynamic> addItem= {
                          "Image" : "",
                          "Address" : addresscontroller.text,
                          "Quantity" : quantitytcontroller.text,
                          "UserId" : id,
                          "Name" : name,
                          "Status" : "Pending",
                        };
                        await DatabaseMethods().addUserUploadItem(addItem, id!, itemid);
                        await DatabaseMethods().addAdminItem(addItem, itemid);
                        ScaffoldMessenger.of(context).showSnackBar(

                            SnackBar(
                              backgroundColor: Colors.green,
                                content: Text(
                                  "Item has been uploaded succesfully",
                                  style: AppWidget.whitetextstyle(20),
                                )
                            )
                        );
                        setState(() {
                          addresscontroller.text = "";
                          quantitytcontroller.text = "";
                          selectedImage = null;
                        });
                      }
                    },
                    child: Center(
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width/1.5,
                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(30.0)),
                          child: Center(child: Text("Upload", style: AppWidget.whitetextstyle(25.0),),),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
            ]
        )
      )
    );
  }
}
