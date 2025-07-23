import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fluttertoast/fluttertoast.dart';
import '../pages/bottomnav.dart';
import '../pages/check_item.dart';

class ResultService extends StatefulWidget {
  final File image;
  final String result;

  const ResultService({required this.image, required this.result});

  @override
  State<ResultService> createState() => _ResultServiceState();
}

class _ResultServiceState extends State<ResultService> {
  Map<String, dynamic>? wasteInfo;
  double confidence = 0.0;
  String label = "";

  @override
  void initState() {
    super.initState();
    _processResult(widget.result);
  }

  Future<void> _processResult(String result) async {
    try {
      // Extract label and confidence
      final parts = result.split(" with ");
      label = parts[0].trim().toLowerCase();
      confidence =
          double.tryParse(parts[1].replaceAll("% confidence", "").trim()) ??
              0.0;

      if (confidence < 65) {
        Fluttertoast.showToast(
          msg: "⚠️ Image is unclear or no waste detected. Try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNav()));
      }

      // Load waste info from JSON
      final jsonString = await rootBundle.loadString('asset/waste_info.json');
      final data = json.decode(jsonString) as Map<String, dynamic>;

      final lowerCaseMap = {
        for (var entry in data.entries) entry.key.toLowerCase(): entry.value
      };

      if (lowerCaseMap.containsKey(label)) {
        setState(() {
          wasteInfo = lowerCaseMap[label];
        });
      }
    } catch (e) {
      print("Error processing result: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 204, 218, 205),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                            onTap: (){Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => BottomNav()));
                  },
                            child: Container(
                                child: Icon(
                          Icons.arrow_circle_left_outlined,
                          color: Colors.black,
                          size: 40,
                        ))),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Waste Predicted ",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )),
              SizedBox(
                height: 30,
              ),
              Image.file(
                widget.image,
                height: 300,
                width: 700,
              ),
              SizedBox(height: 20),
              if (wasteInfo != null) ...[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xcbbfe8bf),
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Category: ${wasteInfo!["category"]}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Disposal Method:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 6),
                        ...List<Widget>.from(
                          (wasteInfo!["disposal"] as List).map(
                            (tip) => Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("• ", style: TextStyle(fontSize: 16)),
                                Expanded(
                                  child: Text(
                                    tip,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
