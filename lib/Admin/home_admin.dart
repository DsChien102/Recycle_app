import 'package:flutter/material.dart';
import 'package:recycle_flutter/Admin/admin_approval.dart';
import 'package:recycle_flutter/Admin/admin_redeem.dart';
import 'package:recycle_flutter/services/widget_support.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width / 4),
                  Text('Home Admin', style: AppWidget.headlinetextStyle(25.0)),
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
                    SizedBox(height: 20.0),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminApproval(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Image.asset(
                                "images/approval.png",
                                height: 100,
                                width: 120,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Admin Approval",
                                  style: AppWidget.headlinetextStyle(20.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    // Container thứ hai - y hệt container đầu tiên
                    GestureDetector(
                      onTap: () {
                        print("Tapped Admin Redeem"); // ✅ Debug log
                        Navigator.push(
                          context, // ✅ Đảm bảo có context
                          MaterialPageRoute(
                            builder: (context) => AdminRedeem(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(left: 20.0, right: 20.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Image.asset(
                                "images/reedem.png",
                                height: 100,
                                width: 120,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "Redeem Request",
                                  style: AppWidget.headlinetextStyle(20.0),
                                ),
                              ],
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
}
