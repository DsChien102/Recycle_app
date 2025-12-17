import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:recycle_flutter/services/shared_pef.dart';
import 'package:recycle_flutter/services/widget_support.dart';
import 'package:recycle_flutter/services/database.dart';
import 'package:intl/intl.dart';

class Points extends StatefulWidget {
  const Points({super.key});

  @override
  State<Points> createState() => _PointsState();
}

class _PointsState extends State<Points> {
  String? id, mypoints, name;
  Stream? pointsStream;

  getthesharedpref() async {
    id = await SharedPreferenceHepler().getUserId();
    name = await SharedPreferenceHepler().getUserName();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    mypoints = await getUserPoint(id!);
    pointsStream = await DatabaseMethods().getUserTransactions(id!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    ontheload();
  }

  TextEditingController pointsController = new TextEditingController();
  TextEditingController stkController = new TextEditingController();
  TextEditingController banknameController = new TextEditingController();

  Future<String?> getUserPoint(String docID) async {
    try {
      DocumentSnapshot docSnapshot =
          await FirebaseFirestore.instance.collection("users").doc(docID).get();

      if (docSnapshot.exists) {
        var data = docSnapshot.data() as Map<String, dynamic>;
        var point = data['Points'];

        // ✅ Xử lý null an toàn
        if (point == null) {
          return '0'; // Trả về '0' thay vì 'null'
        }
        return point.toString();
      } else {
        return '0'; // ✅ Trả về '0' thay vì 'No document found'
      }
    } catch (e) {
      print("Error : $e");
      return '0'; // ✅ Trả về '0' thay vì 'error'
    }
  }

  Widget allApprovals() {
    return StreamBuilder(
      stream: pointsStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 233, 233, 249),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          ds["Date"],
                          textAlign: TextAlign.center,
                          style: AppWidget.whitetextStyle(22.0),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: [
                          Text(
                            "Redeem Points",
                            style: AppWidget.normaltextStyle(18),
                          ),
                          Text(
                            ds["Points"],
                            style: AppWidget.greentextStyle(25),
                          ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color:
                              ds["Status"] == "Approved"
                                  ? const Color.fromARGB(78, 76, 175, 79)
                                  : const Color.fromARGB(48, 241, 77, 66),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          ds["Status"],
                          style: TextStyle(
                            color:
                                ds["Status"] == "Approved"
                                    ? Colors.green
                                    : Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
      body:
          mypoints == null
              ? Center(child: CircularProgressIndicator())
              : Container(
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Points Page",
                        style: AppWidget.headlinetextStyle(25),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 228, 228, 243),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Container(
                              margin: EdgeInsets.only(left: 50, right: 50),
                              child: Material(
                                elevation: 3.0,
                                borderRadius: BorderRadius.circular(20),

                                child: Container(
                                  padding: EdgeInsets.all(15),

                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "images/coin.png",
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 20),
                                      Column(
                                        children: [
                                          Text(
                                            "Points Earned",
                                            style: AppWidget.normaltextStyle(
                                              20,
                                            ),
                                          ),
                                          Text(
                                            mypoints.toString(),
                                            style: AppWidget.greentextStyle(20),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            GestureDetector(
                              onTap: () {
                                openBox();
                              },
                              child: Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: Center(
                                    child: Text(
                                      "Redeem Points",
                                      style: AppWidget.whitetextStyle(23),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Text(
                                      "Last Transactions",
                                      style: AppWidget.normaltextStyle(20),
                                    ),
                                    SizedBox(height: 20),
                                    Expanded(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                            0.8,
                                        child: allApprovals(),
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
                ),
              ),
    );
  }

  Future openBox() => showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cancel),
                    ),
                    SizedBox(width: 30),
                    Text(
                      "Redeem Points",
                      style: AppWidget.greentextStyle(18.0),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text("Add Points", style: AppWidget.normaltextStyle(20.0)),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: pointsController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Points",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("Bank Name", style: AppWidget.normaltextStyle(20.0)),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: banknameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Bank Name",
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text("Add to Account", style: AppWidget.normaltextStyle(20.0)),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    controller: stkController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Account Number",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    if (pointsController.text != "" &&
                        banknameController.text != "" &&
                        stkController.text != "" &&
                        int.parse(mypoints!) >
                            int.parse(pointsController.text)) {
                      DateTime now = DateTime.now();
                      String formattedDate = DateFormat('d\nMMM').format(now);
                      int updatedpoints =
                          int.parse(mypoints!) -
                          int.parse(pointsController.text);
                      await DatabaseMethods().updateUserPoints(
                        id!,
                        updatedpoints.toString(),
                      );

                      Map<String, dynamic> userReedemMap = {
                        "Points": pointsController.text,
                        "BankName": banknameController.text,
                        "AccountNumber": stkController.text,
                        "Status": "Pending",
                        "Name": name,
                        "Date": formattedDate,
                        "UserId": id,
                      };
                      String reedemid = randomAlpha(10);
                      await DatabaseMethods().addUserReedemPoints(
                        userReedemMap,
                        id!,
                        reedemid,
                      );
                      await DatabaseMethods().addAdminReedemRequest(
                        userReedemMap,
                        reedemid,
                      );
                      mypoints = await getUserPoint(id!);
                      setState(() {});
                      Navigator.pop(context);
                    }
                  },
                  child: Center(
                    child: Container(
                      width: 120,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFF008000),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Redeem",
                          style: AppWidget.whitetextStyle(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
  );
}
