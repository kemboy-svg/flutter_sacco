// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sacco_2/account/ver_Account.dart';
import 'package:sacco_2/balance/ver_balance.dart';
import 'package:sacco_2/deposit/ver_Deposit.dart';
import 'package:sacco_2/register/register.dart';
import 'package:sacco_2/withdraw/ver_withdraw.dart';

// ignore: camel_case_types
class menuScreen extends StatefulWidget {
  const menuScreen({super.key});

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<menuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MENU',
          style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Image.asset(
            "assets/15.png",
            height: 160,
            width: 160,
          ),
        ),
        GridView.count(
          primary: true,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          shrinkWrap: true,
          children: <Widget>[
            //account
            Material(
              color: Colors.white,
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerifyAccount()));
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Icons.person_outline,
                        size: 85,
                        color: Colors.blue,
                      ),
                      Text(
                        'Account',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blueAccent),
                      ),
                    ],
                  )),
            ),
            //Balance
            Material(
              color: Colors.white,
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerifyBalance()));
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Icons.account_balance,
                        size: 85,
                        color: Colors.blue,
                      ),
                      Text(
                        'Balance',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blueAccent),
                      ),
                    ],
                  )),
            ),

            //Deposit
            Material(
              color: Colors.white,
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerifyDeposit()));
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Icons.save_alt_outlined,
                        size: 85,
                        color: Colors.blue,
                      ),
                      Text(
                        'Deposit',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blueAccent),
                      ),
                    ],
                  )),
            ),

            //withdraw
            Material(
              color: Colors.white,
              child: InkWell(
                  onTap: () {
                    print('3 was clicked');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VerifyWithdraw()));
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Icons.file_upload_outlined,
                        size: 85,
                        color: Colors.blue,
                      ),
                      Text(
                        'Withdraw',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blueAccent),
                      ),
                    ],
                  )),
            ),

            //loans
            Material(
              color: Colors.white,
              child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: const [
                      Icon(
                        Icons.real_estate_agent_rounded,
                        size: 85,
                        color: Colors.blue,
                      ),
                      Text(
                        'Loans',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blueAccent),
                      ),
                    ],
                  )),
            ),

            //register
            Material(
              color: Colors.white,
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Icons.person_add_alt_outlined,
                        size: 85,
                        color: Colors.blue,
                      ),
                      Text(
                        'Register',
                        style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blueAccent),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ],
        ),
      ),
    );
  }
}
