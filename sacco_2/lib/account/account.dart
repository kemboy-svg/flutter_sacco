import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sacco_2/withdraw/menu.dart';


class AccNumScreen extends StatefulWidget {
  const AccNumScreen({super.key});

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<AccNumScreen> {
  // FirebaseAuth auth = FirebaseAuth.instance;
  // CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('MEMBER ACCOUNT'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.only(left: 10, right: 10, top: 0),
          child: Column(
            children: [
              Image.asset(
                "assets/15.png",
                height: 200,
                width: 200,
              ),
              Text(
                'MEMBER DETAILS',
                style: TextStyle(
                  fontSize: 20,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Colors.blue,
                ),
              ),
              Container(
                height: 250,
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('register_members').snapshots(),
                  builder:(context, snapshot){
                    if (!snapshot.hasData){
                      return  const CircularProgressIndicator();
                    }
                    DocumentSnapshot<Map<String, dynamic>> data = snapshot.data!.docs[index];
                  } 
                     

                      String balance = '${data['Balance']}';
                      var doubleBalance = double.parse(balance);
                      double bookBalance = doubleBalance - 500;
                      String imageUrl = '${data['IDCardPath']}';
                      return Column(
                        children: [
                          Text(
                            'NAME: ${data['First_name']}',
                            style: TextStyle(
                              fontSize: 15,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 0.5
                                ..color = Colors.black,
                            ),
                          ),
                          Text(
                            'ID NO: ${data['Last_name']}',
                            style: TextStyle(
                              fontSize: 15,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 0.5
                                ..color = Colors.black,
                            ),
                          ),
                          Text(
                            'PHONE NO: ${data['phoneNumber']}',
                            style: TextStyle(
                              fontSize: 15,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 0.5
                                ..color = Colors.black,
                            ),
                          ),
                          Text(
                            'DOB: ${data['DOB']}',
                            style: TextStyle(
                              fontSize: 15,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 0.5
                                ..color = Colors.black,
                            ),
                          ),
                          Text(
                            'BALANCE: ${data['Balance']}',
                            style: TextStyle(
                              fontSize: 15,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 0.5
                                ..color = Colors.black,
                            ),
                          ),
                          Text(
                            'ADDRESS${bookBalance.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 15,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 0.5
                                ..color = Colors.black,
                            ),
                          ),
                          Text(
                            'LOCATION: ${data['Location']}',
                            style: TextStyle(
                              fontSize: 15,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 0.5
                                ..color = Colors.black,
                            ),
                          ),
                          Container(
                            height: 99,
                            width: 150,
                            margin: const EdgeInsets.only(left: 0, right: 0, top: 20),
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      );
                    
                    return const Text('Loading');
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const menuScreen()));
                  
                },
                child: const Text(
                 "BACK TO MAIN MENU",
                 style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
