import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sacco_2/withdraw/menu.dart';

class AccNumScreen extends StatefulWidget {
  const AccNumScreen({super.key});

  @override
  State<AccNumScreen> createState() => _AccNumScreenState();
}

class _AccNumScreenState extends State<AccNumScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Member Account'),
        ),
        body: SingleChildScrollView(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.only(left: 10, right: 10, top: 0),
          child: Column(
            children: [
              Image.asset(
                'assets/15.png',
                width: 200,
                height: 200,
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
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('register_members')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  List<QueryDocumentSnapshot<Map<String, dynamic>>> data =
                      snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data!.docs[index];
                      return  ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Colors.blue,
                        ),
                        title: Row(
                          children: [
                            Text('NAME: ${data['fname']}',
                            style: TextStyle(
                                fontSize: 15,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 0.5
                                  ..color = Colors.black,
                              ),),
                              Text('ID NO: ${data['Last_name']}',
                              style: TextStyle(
                                fontSize: 15,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 0.5
                                  ..color = Colors.black,
                              )),
                          ],
                        ),
                          subtitle: Column(
                            children: [                              
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
                          'PHONE NO: ${data['phoneNumber']}',
                          style: TextStyle(
                            fontSize: 15,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 0.5
                              ..color = Colors.black,
                          ),
                        ),
                            ],
                          ),
                          trailing:   Column(
                            children: [
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
                              'LOCATION: ${data['Location']}',
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
                        //  Text(
                        //   'ADDRESS${bookBalance.toStringAsFixed(2)}',
                        //   style: TextStyle(
                        //     fontSize: 15,
                        //     foreground: Paint()
                        //       ..style = PaintingStyle.stroke
                        //       ..strokeWidth = 0.5
                        //       ..color = Colors.black,
                        //   ),
                        // ),
                            ],
                          ),
                      );
                    },
                  );
                },
              ),
                    
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const menuScreen()));
                  },
                  child: const Text(
                    "BACK TO MAIN MENU",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
