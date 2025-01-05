import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // استيراد Firebase Auth
import 'HomePage.dart'; // استيراد الصفحة الرئيسية

class CreateAccountPage extends StatefulWidget {
  final bool isMunicipality; // تحديد نوع المستخدم

  CreateAccountPage({required this.isMunicipality});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _municipalityController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an Account', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Enter your full name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Enter your Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _mobileNumberController,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                if (widget.isMunicipality) // يظهر الحقل فقط إذا كان المستخدم بلدية
                  TextField(
                    controller: _municipalityController,
                    decoration: InputDecoration(
                      labelText: 'Name of the municipality or company',
                      border: OutlineInputBorder(),
                    ),
                  ),
                SizedBox(height: 16),
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'Enter your City',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () async {
                    // الحصول على القيم من الحقول
                    String fullName = _fullNameController.text;
                    String email = _emailController.text;
                    String mobileNumber = _mobileNumberController.text;
                    String municipality = _municipalityController.text;
                    String city = _cityController.text;
                    String password = _passwordController.text;

                    // تحقق من أن جميع الحقول مليئة
                    if (fullName.isNotEmpty && email.isNotEmpty && mobileNumber.isNotEmpty &&
                        (widget.isMunicipality ? municipality.isNotEmpty : true) &&
                        city.isNotEmpty && password.isNotEmpty) {
                      try {
                        // إنشاء حساب جديد باستخدام Firebase
                        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        // يمكنك الآن استخدام userCredential لتخزين بيانات المستخدم في Firestore إذا لزم الأمر
                        print('Account created successfully! User ID: ${userCredential.user?.uid}');

                        // الانتقال إلى الصفحة الرئيسية
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } catch (e) {
                        // عرض رسالة خطأ إذا فشل إنشاء الحساب
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to create account: $e')),
                        );
                      }
                    } else {
                      // عرض رسالة خطأ إذا كانت الحقول فارغة
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please Fill All Fields')),
                      );
                    }
                  },
                  child: Text('SIGN UP'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
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