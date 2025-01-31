import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // استيراد Firebase Auth
import 'HomePage.dart'; // استيراد الصفحة الرئيسية

class LogIn extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<LogIn> {
  final TextEditingController _idController = TextEditingController(); // معرف المستخدم (ID)
  final TextEditingController _emailController = TextEditingController(); // البريد الإلكتروني
  final TextEditingController _passwordController = TextEditingController(); // كلمة المرور

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogIn', style: TextStyle(color: Colors.white)),
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
                // 1. إدخال معرف المستخدم (ID)
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: 'Enter your ID',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number, // السماح بإدخال الأرقام فقط
                ),
                SizedBox(height: 16),

                // 2. إدخال البريد الإلكتروني
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Enter your Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // 3. إدخال كلمة المرور
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
                    String id = _idController.text.trim();
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();

                    // تحقق من أن الحقول ليست فارغة
                    if (id.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
                      try {
                        // محاولة تسجيل الدخول باستخدام Firebase Auth
                        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        // التحقق إذا كان المستخدم قد تم تسجيل دخوله بنجاح
                        if (userCredential.user != null) {
                          print('Login successful!');

                          // الانتقال إلى الصفحة الرئيسية بعد تسجيل الدخول
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      } catch (e) {
                        // عرض رسالة خطأ إذا فشل تسجيل الدخول
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login failed: $e')),
                        );
                      }
                    } else {
                      // عرض رسالة خطأ إذا كانت الحقول فارغة
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please fill in all the fields')),
                      );
                    }
                  },
                  child: Text('LogIn'),
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