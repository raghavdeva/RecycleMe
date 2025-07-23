import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recycle_me/services/widget_support.dart';
import 'dart:io';
import '../services/model_service.dart';
import '../services/result_service.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


class CheckItem extends StatefulWidget {
  const CheckItem({super.key});

  @override
  State<CheckItem> createState() => _CheckItemState();
}

class _CheckItemState extends State<CheckItem> {
  final ImagePicker picker = ImagePicker();

  Future<void> handleImage(BuildContext context, ImageSource source) async {
    final picked = await picker.pickImage(source: source);
    if (picked == null) return;

    final result = await ModelService.classifyImage(File(picked.path));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultService(
          image: File(picked.path),
          result: result,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(color: const Color.fromARGB(
              255, 209, 255, 212),),
          margin: EdgeInsets.only(top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(width: 20.0, height: 50.0),
                DefaultTextStyle(
                  style: AppWidget.greentextstyle(30),
                  child: Container(
                    height: 120,
                    width: 110,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        RotateAnimatedText('CLICK'),
                        RotateAnimatedText('DETECT'),
                        RotateAnimatedText('KNOW'),
                      ],
                      repeatForever: true,
                      pause: const Duration(milliseconds: 0),
                    ),
                  ),
                ),
                SizedBox(width: 5.0,),
                const Text(
                  'YOUR WASTE',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: Image.asset("images/recycleimage.jpg", fit: BoxFit.fill,),
              ),
              SizedBox(height: 20.0,),
              Row(
                children: [
                  SizedBox(width: 10.0,),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => handleImage(context, ImageSource.camera),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Color(0xcb01d300),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.black, width: 2, style: BorderStyle.solid),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera, color: Colors.black87,size: 40,),
                                SizedBox(height: 10,),
                                Text("Capture From Camera", style: AppWidget.headlinetextstyle(22),overflow: TextOverflow.ellipsis, maxLines: 2,textAlign: TextAlign.center,),
                              ],
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => handleImage(context, ImageSource.gallery),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        child: Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Color(0xcb01d300),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.black, width: 2, style: BorderStyle.solid),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.photo, color: Colors.black87,size: 40,),
                                SizedBox(height: 10,),
                                Text("Pick From Gallery", style: AppWidget.headlinetextstyle(22),overflow: TextOverflow.ellipsis, maxLines: 2,textAlign: TextAlign.center,),
                              ],
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,)
                ],
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
