import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sacco_2/register/register_data.dart';

class Register2Screen extends StatefulWidget {
  const Register2Screen({super.key});

  @override
  State<Register2Screen> createState() => _Register2ScreenState();
}

class _Register2ScreenState extends State<Register2Screen> {
  TextEditingController fname = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController idnum = TextEditingController();
  TextEditingController lname = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  TextEditingController location = TextEditingController();
  final TextEditingController dateConroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fname.dispose();
    addressController.dispose();
    idnum.dispose();
    lname.dispose();
    location.dispose();
    dateConroller.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: fname,
                  cursorColor: Colors.blue,
                  decoration: const InputDecoration(
                      focusColor: Colors.blue,
                      icon: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      hintText: "First Name",
                      labelText: 'Enter Your First Name',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      'Please enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: lname,
                  cursorColor: Colors.blue,
                  decoration: const InputDecoration(
                      focusColor: Colors.blue,
                      icon: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      hintText: "Last Name",
                      labelText: 'Enter your last name',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // date field
                TextFormField(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2023),
                        lastDate: DateTime(2025));
                    if (pickedDate != null) {
                      setState(() {
                        dateConroller.text =
                            DateFormat('yy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                  controller: dateConroller,
                  decoration: const InputDecoration(
                    focusColor: Colors.blue,
                    icon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    hintText: "Date",
                    labelText: 'Enter date',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.calendar_month_outlined,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    focusColor: Colors.blue,
                    icon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    hintText: "Phone number",
                    labelText: 'Enter your phone number',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: idnum,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    focusColor: Colors.blue,
                    icon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    hintText: "ID number",
                    labelText: 'Enter your ID',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your ID number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: addressController,
                  keyboardType: TextInputType.streetAddress,
                  decoration: const InputDecoration(
                    focusColor: Colors.blue,
                    icon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    hintText: "Address",
                    labelText: 'Enter your address',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: location,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    focusColor: Colors.blue,
                    icon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    hintText: "Location",
                    labelText: 'Enter your location',
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter location';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
        
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        RegisterData registerData = RegisterData(
                            address: addressController.text,
                            date: dateConroller.text,
                            fname: fname.text,
                            idnum: idnum.text,
                            lname: lname.text,
                            location: location.text,
                            phoneNumber: phoneController.text);
                        FirebaseFirestore.instance
                            .collection('register_members')
                            .add(registerData.toJson())
                            .then((value) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Register Status'),
                                content: const Text(
                                  'Registration received successfully',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Ok'))
                                ],
                              );
                            },
                          );
                        }).catchError((e) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Register status'),
                                content: const Text('Regustration unsuccessful'),
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20))),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Ok'))
                                ],
                              );
                            },
                          );
                        });
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
