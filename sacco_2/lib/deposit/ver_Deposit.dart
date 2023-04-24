// ignore_for_file: unnecessary_null_comparison, import_of_legacy_library_into_null_safe, file_names, library_private_types_in_public_api, empty_catches, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sacco_2/deposit/deposit.dart';
class VerifyDeposit extends StatefulWidget {
  const VerifyDeposit({Key? key}) : super(key: key);

  @override
  _VerifyDepositState createState() => _VerifyDepositState();
}

class _VerifyDepositState extends State<VerifyDeposit> {
  String? phoneNumber;
  var isLoading = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MEMBER ACCOUNT'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            Image.asset(
              "assets/15.png",
              height: 200,
              width: 200,
            ),
            Text(
              'ENTER MEMBER PHONE NUMBER',
              style: TextStyle(
                fontSize: 20,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 2
                  ..color = Colors.blue,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffEEEEEE),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 20),
                      blurRadius: 100,
                      color: Color(0xffEEEEEE)),
                ],
              ),
              child: TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration:
                    const InputDecoration.collapsed(hintText: 'Enter Phone Number'),
              ),
            ),
            GestureDetector(
  onTap: () {
    _auth.signInWithPhoneNumber(_phoneNumberController.text).then((user) {
      if (user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const DepositScreen()));
      }
    });
  },
  child: Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
    padding: const EdgeInsets.only(left: 20, right: 20),
    height: 54,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
          colors: [(Color(0xff2A87FF)), Color(0xff00BFFF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight),
      borderRadius: BorderRadius.circular(20),
      color: Colors.grey[200],
      boxShadow: const [
        BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 50,
            color: Color(0xffEEEEEE)),
      ],
    ),
    child: const Text(
      "NEXT",
      style: TextStyle(color: Colors.white, fontSize: 20),
    ),
  ),
),
],
),
),
);
}
  
}
