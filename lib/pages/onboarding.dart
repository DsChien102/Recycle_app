import 'package:flutter/material.dart';
import 'package:recycle_flutter/pages/login.dart';
import 'package:recycle_flutter/services/widget_support.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Image.asset("images/onboard.png"),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Recycle your waste \n         products",
                style: AppWidget.headlinetextStyle(32.0),
              ),
            ),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                "Easily collect household waste and \n              generate less waste",
                style: AppWidget.normaltextStyle(18.0),
              ),
            ),
            SizedBox(height: 90.0),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Text(
                    "Get Started",
                    style: AppWidget.whitetextStyle(24.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
