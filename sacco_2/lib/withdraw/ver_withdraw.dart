// ignore_for_file: unnecessary_null_comparison, import_of_legacy_library_into_null_safe, library_private_types_in_public_api, empty_catches, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:pinput/pinput.dart';

import 'package:sacco_2/utils/loading.dart';
import 'package:sacco_2/withdraw/withdraw.dart';

class VerifyWithdraw extends StatefulWidget {
  const VerifyWithdraw({Key? key}) : super(key: key);

  @override
  _VerifyWithdrawState createState() => _VerifyWithdrawState();
}

class _VerifyWithdrawState extends State<VerifyWithdraw> {
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
         child: SingleChildScrollView(
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
                builder: (context) => const WithdrawScreen()));
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
                        )
                        ),
                      );
                    }
}
