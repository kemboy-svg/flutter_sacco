class RegisterData {
  String fname;
  String address;
  String idnum;
  String lname;
  String phoneNumber;
  String location;
  String date;

  RegisterData(
      {required this.address,
      required this.date,
      required this.fname,
      required this.idnum,
      required this.lname,
      required this.location,
      required this.phoneNumber});
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'address': address,
      'fname': fname,
      'idnum': idnum,
      'lname': lname,
      'location': location,
      'phoneNumber': phoneNumber
    };
  }
}
