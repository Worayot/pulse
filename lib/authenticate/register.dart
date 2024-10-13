import 'package:Pulse/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers for each field
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _nurseIdController = TextEditingController();
  final _contactInfoController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _nurseIdController.dispose();
    _contactInfoController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Perform form submission logic, such as sending data to a server or saving locally
      print('Form Submitted!');
      print('Name: ${_nameController.text}');
      print('Last Name: ${_lastNameController.text}');
      print('Email: ${_emailController.text}');
      print('Nurse ID: ${_nurseIdController.text}');
      print('Contact Info: ${_contactInfoController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nurseIdController,
                decoration: InputDecoration(labelText: 'Nurse ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Nurse ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contactInfoController,
                decoration: InputDecoration(labelText: 'Contact Info'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact info';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 50,
              ),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signup(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xff0D6EFD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: const Size(double.infinity, 60),
        elevation: 0,
      ),
      onPressed: () async {
        await AuthService().signup(
            email: _emailController.text,
            nurseID: _nurseIdController.text,
            name: _nameController.text,
            lastname: _lastNameController.text,
            contactInfo: _contactInfoController.text,
            context: context);
      },
      child: const Text(
        "Sign Up",
        style: TextStyle(
          color: Colors.white, // Change the text color here
        ),
      ),
    );
  }
}
