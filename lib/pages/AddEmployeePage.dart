import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // استيراد Firestore

class AddEmployeePage extends StatefulWidget {
  @override
  _AddEmployeePageState createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final _employeeNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _employeeIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _companyIdController = TextEditingController();

  // Function to add an employee to Firestore
  Future<void> addEmployeeToFirestore() async {
    String employeeName = _employeeNameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String employeeId = _employeeIdController.text;
    String password = _passwordController.text;
    String companyId = _companyIdController.text;

    if (employeeName.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty &&
        employeeId.isNotEmpty &&
        password.isNotEmpty &&
        companyId.isNotEmpty) {
      try {
        // Add data to Firestore
        await FirebaseFirestore.instance.collection('employees').doc(employeeId).set({
          'employeeName': employeeName,
          'email': email,
          'phone': phone,
          'employeeId': employeeId,
          'password': password, // إذا كنت تخزن كلمات المرور، يُفضل تشفيرها
          'companyId': companyId,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Employee added successfully')),
        );

        // Navigate back to the previous page
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add employee: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  void dispose() {
    _employeeNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _employeeIdController.dispose();
    _passwordController.dispose();
    _companyIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading Section
              Text(
                '',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 20),

              // Employee Name Field
              _buildTextField('Employee Name', _employeeNameController),

              // Email Field
              _buildTextField('Email', _emailController),

              // Phone Number Field
              _buildTextField('Phone Number', _phoneController),

              // Company ID Field
              _buildTextField('Company ID', _companyIdController),

              // Employee ID Field
              _buildTextField('Employee ID', _employeeIdController),

              // Password Field
              _buildTextField('Password', _passwordController, obscureText: true),

              SizedBox(height: 40),

              // Add Employee Button
              Center(
                child: ElevatedButton(
                  onPressed: addEmployeeToFirestore, // Call the Firestore function
                  child: Text(
                    'Add Employee',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Use 'backgroundColor' instead of 'primary'
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    textStyle: TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build text fields with custom styling
  Widget _buildTextField(String labelText, TextEditingController controller, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.green, width: 2),
          ),
        ),
      ),
    );
  }
}