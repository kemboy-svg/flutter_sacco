// ignore_for_file: unnecessary_null_comparison, import_of_legacy_library_into_null_safe, library_private_types_in_public_api, empty_catches, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sacco_2/balance/balance.dart';
import 'package:sacco_2/utils/loading.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:pinput/pinput.dart';

class VerifyBalance extends StatefulWidget {
  const VerifyBalance({Key? key}) : super(key: key);

  @override
  _VerifyBalanceState createState() => _VerifyBalanceState();
}

class _VerifyBalanceState extends State<VerifyBalance> {
  String? phoneNumber;
  String? phoneIsoCode;
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20.0, color: Colors.blue, fontWeight: FontWeight.bold),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(5)),
  );

  Future signIn(String phoneNumber) async {
    setState(() {
      loading = true;
    });
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (verificationId, [forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    title: const Text(
                      'Enter Verification Code Text',
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Pinput(
                            length: 6,
                            focusNode: _pinOTPCodeFocus,
                            controller: _pinOTPCodeController,
                            submittedPinTheme: defaultPinTheme.copyWith(
                                decoration: defaultPinTheme.decoration
                                    ?.copyWith(color: Colors.white10)),
                            focusedPinTheme: defaultPinTheme.copyDecorationWith(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(5)),
                            pinAnimationType: PinAnimationType.rotation,
                            onSubmitted: (pin) async {
                              var credential = PhoneAuthProvider.credential(
                                  verificationId: verificationId, smsCode: pin);
                              _auth
                                  .signInWithCredential(credential)
                                  .then((user) async => {
                                        if (user != null)
                                          {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const BalanceScreen())),
                                          }
                                        else
                                          {
                                            setState(() {
                                              loading = false;
                                            }),
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text('USER NOT FOUND'),
                                                duration: Duration(seconds: 3),
                                              ),
                                            ),
                                          }
                                      });
                            },
                          ),
                        )
                      ],
                    ),
                  ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {}
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(internationalizedPhoneNumber);
    setState(() {
      phoneNumber = internationalizedPhoneNumber;
      phoneIsoCode = isoCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text('ACCOUNT BALANCE'),
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
                    child: InternationalPhoneInput(
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Enter Phone Number'),
                        onPhoneNumberChange: onPhoneNumberChange,
                        initialPhoneNumber: phoneNumber,
                        initialSelection: 'Ke',
                        enabledCountries: const ['+254'],
                        showCountryCodes: true),
                  ),
                  GestureDetector(
                    onTap: () {
                      signIn(phoneNumber!);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              (Color(0xff2A87FF)),
                              Color(0xff00BFFF)
                            ],
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