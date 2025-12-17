import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle_flutter/services/database.dart';
import 'package:recycle_flutter/services/widget_support.dart';

class AdminRedeem extends StatefulWidget {
  const AdminRedeem({super.key});

  @override
  State<AdminRedeem> createState() => _AdminRedeemState();
}

class _AdminRedeemState extends State<AdminRedeem> {
  Stream? redeemStream;

  getontheload() async {
    redeemStream = await DatabaseMethods().getAdminReedemApproval();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getontheload();
  }

  Widget allApprovals() {
    return StreamBuilder(
      stream: redeemStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          ds["Date"],
                          textAlign: TextAlign.center,
                          style: AppWidget.whitetextStyle(22),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person, color: Colors.green, size: 25),
                              SizedBox(width: 10),
                              Text(
                                ds["Name"],
                                style: AppWidget.normaltextStyle(17),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.point_of_sale,
                                color: Colors.green,
                                size: 25,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Points Redeem : " + ds["Points"],
                                style: AppWidget.normaltextStyle(17),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.monetization_on,
                                color: Colors.green,
                                size: 25,
                              ),
                              SizedBox(width: 10),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Account Number : " + ds["AccountNumber"],
                                  style: AppWidget.normaltextStyle(17),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.account_balance,
                                color: Colors.green,
                                size: 25,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Bank Name : " + ds["BankName"],
                                style: AppWidget.normaltextStyle(17),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () async {
                              await DatabaseMethods().updateAdminReedemRequest(
                                ds.id,
                              );
                              await DatabaseMethods().updateUserReedemRequest(
                                ds["UserId"],
                                ds.id,
                              );
                            },
                            child: Container(
                              height: 30,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Approved",
                                  style: AppWidget.whitetextStyle(16.0),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                  SizedBox(width: MediaQuery.of(context).size.width / 7),
                  Text(
                    'Redeem Approval',
                    style: AppWidget.headlinetextStyle(22.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 233, 233, 249),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: allApprovals(),
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
