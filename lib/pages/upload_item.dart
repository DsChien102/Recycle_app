import 'dart:io';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:recycle_flutter/services/widget_support.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recycle_flutter/services/shared_pef.dart';
import 'package:recycle_flutter/services/database.dart';

class UploadItem extends StatefulWidget {
  String category, id;

  UploadItem({required this.category, required this.id});

  @override
  State<UploadItem> createState() => _UploadItemState();
}

class _UploadItemState extends State<UploadItem> {
  TextEditingController addressController = new TextEditingController();
  TextEditingController quantityController = new TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  String? id, name;

  getthesharedpref() async {
    // Assuming you have a method to get shared preferences
    id = await SharedPreferenceHepler().getUserId();
    name = await SharedPreferenceHepler().getUserName();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getthesharedpref();
  }

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 26.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 5.5),
                  Text('Upload item', style: AppWidget.headlinetextStyle(25.0)),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 228, 228, 243),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.0),
                    selectedImage != null
                        ? Center(
                          child: Container(
                            height: 180,
                            width: 180,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        : GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: Center(
                            child: Container(
                              height: 180,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black45,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 30.0,
                              ),
                            ),
                          ),
                        ),
                    SizedBox(height: 40.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        "Enter your address you want to recycle",
                        style: AppWidget.normaltextStyle(16.0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(15.0),
                        elevation: 2.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.location_on,
                                color: Colors.green,
                              ),
                              hintText: "Enter your address ",
                              hintStyle: AppWidget.normaltextStyle(14.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        "Enter your quantity of items to recycle",
                        style: AppWidget.normaltextStyle(16.0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(15.0),
                        elevation: 2.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: TextField(
                            controller: quantityController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.inventory_2,
                                color: Colors.green,
                              ),
                              hintText: "Enter your quantity of items",
                              hintStyle: AppWidget.normaltextStyle(14.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 60.0),
                    GestureDetector(
                      onTap: () async {
                        if (addressController.text != "" &&
                            quantityController.text != "") {
                          String itemid = randomAlphaNumeric(10);
                          // Reference firebaseStorerageRef = FirebaseStorage
                          //     .instance
                          //     .ref()
                          //     .child("blogImages")
                          //     .child(itemid);
                          // final UploadTask task = firebaseStorerageRef.putFile(
                          //   selectedImage!,
                          // );
                          // var downloadUrl =
                          //     await (await task).ref.getDownloadURL();

                          Map<String, dynamic> addItem = {
                            "Image": "",
                            "Address": addressController.text,
                            "Quantity": quantityController.text,
                            "UserId": id,
                            "Name": name,
                            "Status": "Pending",
                          };
                          await DatabaseMethods().addUserUploadItem(
                            addItem,
                            id!,
                            itemid,
                          );
                          await DatabaseMethods().addAdminItem(addItem, itemid);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              "Item uploaded successfully!",
                              style: AppWidget.whitetextStyle(18.0),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        setState(() {
                          addressController.text = "";
                          quantityController.text = "";
                          selectedImage = null;
                        });
                      },
                      child: Center(
                        child: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Upload",
                                style: AppWidget.whitetextStyle(26.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
