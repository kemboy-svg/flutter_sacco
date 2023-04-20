// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:sacco_2/utils/loading.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sacco_2/withdraw/menu.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';




class DepositScreen extends StatefulWidget {
  const DepositScreen({Key? key}) : super(key: key);

  @override
  _DepositScreenState createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TextEditingController _amount = TextEditingController();
  TextEditingController memNumber = TextEditingController();
  late String name;
  FirebaseAuth auth = FirebaseAuth.instance;
  late double amount;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool loading = false;

  Random random = Random();
  late int randomNumber;

  depositMoney(double amount) {
    setState(() {
      loading = true;
    });

    String numAmount = _amount.text.trim();
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    //var doubleAmount = double.parse('amount');
    final User? user = auth.currentUser;
    final uid = user!.uid;

    randomNumber = random.nextInt(200000);
    String transID = randomNumber.toString();
    String transName = 'Deposit';

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('users').doc(uid);

    return FirebaseFirestore.instance
        .runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(documentReference);

          if (!snapshot.exists) {
            setState(() {
              loading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('USER DOES NOT EXIST'),
            ));
            throw Exception("User does not exist!");
          }

          double newBalance;

          newBalance = snapshot['Balance'] + amount;
          transaction.update(documentReference, {'Balance': newBalance});

          String firstName = snapshot['First_name'];
          String lastName = snapshot['Last_name'];
          String idNumber = snapshot['idNum'];

          await _firestore.collection("Transactions").doc().set(
            {
              'First_name': firstName,
              'Last_name': lastName,
              'UID': uid,
              'idnum': idNumber,
              'date': formatted,
              'Amount_deposited': amount,
              'new_Balance': newBalance,
              'Transaction_Name': transName,
            },
          );

          _createPDF(firstName, lastName, idNumber, numAmount, formatted,
              transID, newBalance);
          setState(() {
            loading = false;
          });

          return newBalance;
        })
        .then((value) => print("Member count updated to $value"))
        .catchError(
            (error) => print("Failed to update user followers: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text('DEPOSIT MONEY'),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  //MEMBER NUMBER

                  Text(
                    'ENTER THE AMOUNT YOU WANT TO DEPOSIT',
                    style: TextStyle(
                      fontSize: 20,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.blue,
                    ),
                  ),

//AMOUNT

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
                    child: TextFormField(
                      cursorColor: Colors.blue,
                      decoration: const InputDecoration(
                        focusColor: Colors.blue,
                        icon: Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.blue,
                        ),
                        hintText: "Enter Amount",
                        labelText: 'Enter Amount',
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      keyboardType: TextInputType.number,
                      controller: _amount,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Enter Amount';
                        }
                        return null;
                      },
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      String numd = _amount.text.trim();
                      var der = double.parse(numd);
                      depositMoney(der);
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
                        "DEPOSIT",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const menuScreen()));
                      auth.signOut();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              (Color(0xFF185BB3)),
                              Color(0xFF7DD3F0),
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
                        "BACK TO MAIN MENU",
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

Future<void> _createPDF(String firstName, String lastName, String idnum,
    String amount, String date, String transID, double newAmount) async {
  //Create a new PDF document
  PdfDocument document = PdfDocument();

  //Add a new page and draw text
  PdfPage page = document.pages.add();

//Draw the image to the PDF page.
  page.graphics.drawImage(PdfBitmap(await _readImageData('15.png')),
      const Rect.fromLTWH(200, 10, 100, 100));

  document.form.fields.add(PdfTextBoxField(
    page,
    'Deposit',
    const Rect.fromLTWH(380, 0, 130, 20),
    text: 'Date: $date',
    borderColor: PdfColor(255, 255, 255),
    font: PdfStandardFont(PdfFontFamily.timesRoman, 14),
  ));

  document.form.fields.add(PdfTextBoxField(
    page,
    'Deposit',
    const Rect.fromLTWH(380, 20, 130, 20),
    text: 'Receipt NO: RC$transID',
    borderColor: PdfColor(255, 255, 255),
    font: PdfStandardFont(PdfFontFamily.timesRoman, 14),
  ));

  document.form.fields.add(PdfTextBoxField(
    page,
    'Names',
    const Rect.fromLTWH(200, 100, 100, 20),
    text: 'NACICO SOCIETY SACCO ',
    borderColor: PdfColor(255, 255, 255),
    font: PdfStandardFont(PdfFontFamily.timesRoman, 14),
  ));

  document.form.fields.add(PdfTextBoxField(
    page,
    'Date',
    const Rect.fromLTWH(200, 120, 100, 20),
    text: 'P.O BOX 1234,',
    borderColor: PdfColor(255, 255, 255),
    font: PdfStandardFont(PdfFontFamily.timesRoman, 14),
  ));

  document.form.fields.add(PdfTextBoxField(
    page,
    'Deposit',
    const Rect.fromLTWH(200, 140, 100, 20),
    text: 'NAIROBI',
    borderColor: PdfColor(255, 255, 255),
    font: PdfStandardFont(PdfFontFamily.timesRoman, 14),
  ));

  document.form.fields.add(PdfTextBoxField(
    page,
    'Balance',
    const Rect.fromLTWH(200, 160, 200, 20),
    text: 'DEPOSIT RECEIPT',
    borderColor: PdfColor(255, 255, 255),
    font: PdfStandardFont(PdfFontFamily.timesRoman, 14),
  ));

  document.form.fields.add(PdfTextBoxField(
    page,
    'Deposit',
    const Rect.fromLTWH(0, 180, 300, 20),
    text: 'NAME: $firstName $lastName',
    borderColor: PdfColor(255, 255, 255),
    font: PdfStandardFont(PdfFontFamily.timesRoman, 14),
  ));

  document.form.fields.add(PdfTextBoxField(
    page,
    'ID N0: ',
    const Rect.fromLTWH(0, 200, 130, 20),
    text: 'ID NO: $idnum',
    borderColor: PdfColor(255, 255, 255),
    font: PdfStandardFont(PdfFontFamily.timesRoman, 14),
  ));

  document.form.fields.add(PdfTextBoxField(
    page,
    'Deposit',
    const Rect.fromLTWH(0, 220, 200, 20),
    text: 'Money Deposited: $amount',
    borderColor: PdfColor(255, 255, 255),
    font: PdfStandardFont(PdfFontFamily.timesRoman, 14),
  ));

  document.form.fields.add(PdfTextBoxField(
    page,
    'Deposit',
    const Rect.fromLTWH(0, 240, 200, 20),
    text: 'New Balance: ${newAmount.toStringAsFixed(3)}',
    borderColor: PdfColor(255, 255, 255),
    font: PdfStandardFont(PdfFontFamily.timesRoman, 14),
  ));

  //Save the document
  Future<List<int>> bytes = document.save();

  //Dispose the document
  document.dispose();

  //Get external storage directory
  final directory = await getExternalStorageDirectory();

  //Get directory path
  final path = directory!.path;

  //Create an empty file to write PDF data
  File file = File('$path/Output.pdf');

  //Write PDF data
  await file.writeAsBytes(bytes as List<int>, flush: true);

  //Open the PDF document in mobile
  OpenFile.open('$path/Output.pdf');
}

Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('assets/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
