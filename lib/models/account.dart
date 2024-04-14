import 'package:flutter/material.dart';
import 'package:flutter_application_1/login_screen.dart';
import 'package:flutter_application_1/screens/resource_page.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Student Profile'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // Navigate to the login page when the button is pressed.
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: StudentProfile(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: AdminsOnlyButton(),
      ),
    );
  }
}

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  final _studentNameController = TextEditingController(text: '');
  final _courseController = TextEditingController(text: '');
  final _idNumberController = TextEditingController(text: '');

  @override
  void dispose() {
    _studentNameController.dispose();
    _courseController.dispose();
    _idNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool _isAdmin =
        true; // Set this to true if the user is an admin, or false if not.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Student Name:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: TextFormField(
            controller: _studentNameController,
            decoration: const InputDecoration(),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Course:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: TextFormField(
            controller: _courseController,
            decoration: const InputDecoration(),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'ID Number:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: TextFormField(
            controller: _idNumberController,
            decoration: const InputDecoration(),
          ),
        ),
      ],
    );
  }
}

class AdminsOnlyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Navigate to the admin page when the button is pressed.
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AdminPage()));
      },
      child: const Icon(Icons.admin_panel_settings),
    );
  }
}
