import 'package:flutter/material.dart';
import 'package:ferrynav/styles/style.dart';
import 'package:ferrynav/user_firestore.dart';

class EditprofilePage extends StatefulWidget {
  static const String id = 'editProfile_page';

  @override
  State<EditprofilePage> createState() => _EditprofilePageState();
}

class _EditprofilePageState extends State<EditprofilePage> {
  @override
  void initState() {
    super.initState();
    _loadCurrentUserDetails();
  }

  String? userName;
  String? userPhone;
  String? userMail;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _mailController = TextEditingController();

  Future<void> _loadCurrentUserDetails() async {
    FirestoreService firestoreService = FirestoreService();
    String? name = await firestoreService.getCurrentUserName();
    String? phone = await firestoreService.getCurrentUserPhone();
    String? email = await firestoreService.getCurrentUserEmail();
    setState(() {
      userName = name;
      userMail = email;
      userPhone = phone;
      _nameController.text = name ?? '';
      _phoneController.text = phone ?? '';
      _mailController.text = email ?? '';
    });
  }

  Future<void> _updateCurrentUserDetails() async {
    FirestoreService firestoreService = FirestoreService();
    String newName = _nameController.text;
    String newPhone = _phoneController.text;
    String newEmail = _mailController.text;

    await firestoreService.updateUserName(newName);
    await firestoreService.updateUserPhone(newPhone);
    await firestoreService.updateUserEmail(newEmail);

    setState(() {
      userName = newName;
      userMail = newEmail;
      userPhone = newPhone;
    });
  }

  void _showEditNameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Name', style: h2StyleB,),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: "Enter new name"),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text('Cancel',style: h3Style.copyWith(color: Colors.red)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Save', style: h3Style.copyWith(color: Colors.green)),
                  onPressed: () async {
                    String newName = _nameController.text;
                    await FirestoreService().updateUserName(newName);
                    setState(() {
                      userName = newName;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showEditEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Email', style: h2StyleB,),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: _mailController,
              decoration: InputDecoration(hintText: "Enter new email"),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text('Cancel',style: h3Style.copyWith(color: Colors.red)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Save', style: h3Style.copyWith(color: Colors.green)),
                  onPressed: () async {
                    String newEmail = _mailController.text;
                    await FirestoreService().updateUserEmail(newEmail);
                    setState(() {
                      userMail = newEmail;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showEditPhoneDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Phone Number', style: h2StyleB,),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: _phoneController,
              decoration: InputDecoration(hintText: "Enter new phone number"),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text('Cancel',style: h3Style.copyWith(color: Colors.red)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Save', style: h3Style.copyWith(color: Colors.green)),
                  onPressed: () async {
                    String newPhone = _phoneController.text;
                    await FirestoreService().updateUserPhone(newPhone);
                    setState(() {
                      userPhone = newPhone;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: appBarColor,
          iconTheme: IconThemeData(
            color: containerColor,
          ),
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 65.0,
                ),
                Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: containerColor,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(3.0),
        margin: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 45.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        ),
        constraints: BoxConstraints(
          minWidth: double.infinity,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Full Name', style: h2StyleB),
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
              decoration: BoxDecoration(
                color: appBarColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              constraints: BoxConstraints(
                minWidth: double.infinity,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    userName ?? ' ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: _showEditNameDialog,
                  ),
                ],
              ),
            ),
            Text('Email', style: h2StyleB),
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
              decoration: BoxDecoration(
                color: appBarColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              constraints: BoxConstraints(
                minWidth: double.infinity,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    userMail ?? ' ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: _showEditEmailDialog,
                  ),
                ],
              ),
            ),
            Text('Phone Number', style: h2StyleB),
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
              decoration: BoxDecoration(
                color: appBarColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              constraints: BoxConstraints(
                minWidth: double.infinity,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    userPhone ?? ' ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.white),
                    onPressed: _showEditPhoneDialog,
                  ),
                ],
              ),
            ),
            Text('Password', style: h2StyleB),
            Container(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
              decoration: BoxDecoration(
                color: appBarColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              constraints: BoxConstraints(
                minWidth: double.infinity,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Reset Password',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Icon(Icons.lock, color: Colors.white),
                    onPressed: _showEditPhoneDialog,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}