// ignore_for_file: unused_field, unnecessary_statements

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sacco_2/utils/loading.dart';
import 'package:sacco_2/withdraw/menu.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return initWidget();
  }

  initWidget() {
    formKey;
    return loading
        ? const Loading()
        : Scaffold(
           body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90)),
                  color: Color.fromRGBO(0, 191, 255, 1),
                  gradient: LinearGradient(
                    colors: [
                      (Color.fromRGBO(0, 191, 254, 1)),
                      Color(0xff1E90FF)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Image.asset(
                        "assets/15.png",
                        height: 140,
                        width: 140,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 20, top: 20),
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 25,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = Colors.white,
                        ),
                      ),
                    )
                  ],
                )),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[200],
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        color: Color(0xffEEEEEE)),
                  ],
                ),
                child: Text(
                  'MAKADARA',
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
                  obscureText: true,
                  cursorColor: Colors.blue,
                  decoration: const InputDecoration(
                    focusColor: Colors.blue,
                    icon: Icon(
                      Icons.vpn_key,
                      color: Colors.blue,
                    ),
                    hintText: "Pin",
                    labelText: 'Enter your Pin',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  controller: _password,
                  validator: (val) {
                    if (val!.length < 4) {
                      return 'Enter text';
                    } else {
                      return null;
                    }
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  String pass = _password.text.trim();

                  if (pass == '1234') {
                    setState(() {
                      loading = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Successfuly logged in'),
                      duration: Duration(seconds: 3),
                    ));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const menuScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Wrong password'),
                      duration: Duration(seconds: 3),
                    ));
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      (Color(0xff2A87FF)),
                      Color(0xff00BFFF)
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
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 25,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ))));
  }
}
