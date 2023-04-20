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
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

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
                child: FutureBuilder<DocumentSnapshot>(
                  future: users.doc(auth.currentUser!.uid).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text("Something went wrong");
                    }
                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return const Text("Document does not exist");
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
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
                    }
                    return const Text('Loading');
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const menuScreen()));
                  auth.signOut();
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      (Color(0xFF185BB3)),
                      Color(0xFF7DD3F0),
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
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
      ),
    );
  }
}
