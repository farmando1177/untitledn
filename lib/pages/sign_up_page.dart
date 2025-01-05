import 'package:flutter/material.dart';
import 'create_account_page.dart'; // استيراد صفحة إنشاء الحساب

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Who is the user?',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Create Account page for municipalities or companies
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateAccountPage(isMunicipality: true)),
                  );
                },
                child: Text('MUNICIPALITIES OR COMPANIES'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
                  textStyle: TextStyle(fontSize: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Create Account page for citizen or resident
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateAccountPage(isMunicipality: false)),
                  );
                },
                child: Text('CITIZEN OR RESIDENT'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
                  textStyle: TextStyle(fontSize: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}