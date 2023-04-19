import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:pinput/pinput.dart';

import 'package:flutter_apps/utils/loading.dart';
import 'package:flutter_apps/withdraw/withdraw.dart';

class VerifyWithdraw extends StatefulWidget {
  const VerifyWithdraw({Key? key}) : super(key: key);

  @override
  _VerifyWithdrawState createState() => _VerifyWithdrawState();
}

class _VerifyWithdrawState extends State<VerifyWithdraw> {
  String? phoneNumber;
  String? phoneIsoCode;
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _pinOTPCodeController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();

//pinput decoration constant
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
        fontSize: 20.0, color: Colors.blue, fontWeight: FontWeight.bold),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(5)),
  );

  Future signIn(String phoneNumber) async {
    try {
      setState(() {
        loading = true;
      });
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (verificationId, [forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                    title: Text(
                      'Enter Verification Code',
                      style: TextStyle(
                        fontSize: 15,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 0.5
                          ..color = Colors.blueAccent,
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
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
                                                        withdrawScreen())),
                                          }
                                        else
                                          {
                                            setState(() {
                                              loading = false;
                                            }),
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(''),
                                              duration: Duration(seconds: 3),
                                            ))
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
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'WITHDRAW MONEY',
                style: TextStyle(
                  fontSize: 35,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Colors.white,
                ),
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  Container(
                    child: Image.asset(
                      "assets/15.png",
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Container(
                    child: Text(
                      'ENTER MEMBER PHONE NUMBER',
                      style: TextStyle(
                        fontSize: 20,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2
                          ..color = Colors.blue,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffEEEEEE),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 20),
                            blurRadius: 100,
                            color: Color(0xffEEEEEE)),
                      ],
                    ),
                    child: InternationalPhoneInput(
                        decoration: InputDecoration.collapsed(
                            hintText: 'Enter Phone Number'),
                        onPhoneNumberChange: onPhoneNumberChange,
                        initialPhoneNumber: phoneNumber,
                        initialSelection: 'Ke',
                        enabledCountries: ['+254'],
                        showCountryCodes: true),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        loading = true;
                      });
                      signIn(phoneNumber!);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              (new Color(0xff2A87FF)),
                              new Color(0xff00BFFF)
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200],
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 50,
                              color: Color(0xffEEEEEE)),
                        ],
                      ),
                      child: Text(
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
