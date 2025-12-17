import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle_flutter/services/database.dart';
import 'package:recycle_flutter/services/shared_pef.dart';
import 'package:recycle_flutter/services/widget_support.dart';
import 'package:recycle_flutter/pages/upload_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? id, name;
  Stream? pendingStream;

  getthesharedpref() async {
    id = await SharedPreferenceHepler().getUserId();
    name = await SharedPreferenceHepler().getUserName();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    pendingStream = await DatabaseMethods().getUserPendingRequest(id!);
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget allPendingRequest() {
    return StreamBuilder(
      stream: pendingStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black45, width: 2.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 30.0,
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            ds["Address"],
                            style: AppWidget.normaltextStyle(20.0),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black45),
                      Image.asset(
                        "images/chips.png",
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.layers, color: Colors.green, size: 30.0),
                          SizedBox(width: 10.0),
                          Text(
                            ds["Quantity"],
                            style: AppWidget.normaltextStyle(24.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                );
              },
            )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          name == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 5.0),
                          Image.asset(
                            "images/wave.png",
                            height: 40,
                            width: 40,
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              "Hello, ",
                              style: AppWidget.headlinetextStyle(26.0),
                            ),
                          ),
                          Text(name!, style: AppWidget.greentextStyle(20.0)),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                "images/boy.jpg",
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Image.asset("images/home.png"),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Categories",
                          style: AppWidget.headlinetextStyle(24.0),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Container(
                        padding: EdgeInsets.only(left: 20.0),
                        height: 120,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => UploadItem(
                                          category: "Plastic",
                                          id: id!,
                                        ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFececf8),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Colors.black45,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Image.asset(
                                      "images/plastic.png",
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    "Plastic",
                                    style: AppWidget.normaltextStyle(15.0),
                                  ),
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
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.black45,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Image.asset(
                                    "images/paper.png",
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  "Paper",
                                  style: AppWidget.normaltextStyle(15.0),
                                ),
                              ],
                            ),
                            SizedBox(width: 15.0),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFececf8),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.black45,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Image.asset(
                                    "images/battery.png",
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  "Battery",
                                  style: AppWidget.normaltextStyle(15.0),
                                ),
                              ],
                            ),
                            SizedBox(width: 15.0),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFececf8),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.black45,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Image.asset(
                                    "images/glass.png",
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  "Glass",
                                  style: AppWidget.normaltextStyle(15.0),
                                ),
                              ],
                            ),
                            SizedBox(width: 15.0),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFececf8),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.black45,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Image.asset(
                                    "images/clothing.png",
                                    height: 60,
                                    width: 60,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  "Clothes",
                                  style: AppWidget.normaltextStyle(15.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Pending Request",
                          style: AppWidget.headlinetextStyle(22.0),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: allPendingRequest(),
                      ),
                      SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ),
    );
  }
}
