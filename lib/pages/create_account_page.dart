import 'package:eco_wize/pages/LogIn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // استيراد Firebase Auth
import 'HomePage.dart'; // استيراد الصفحة الرئيسية
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart'; // لاستيراد وظائف النسخ إلى الحافظة

class CreateAccountPage extends StatefulWidget {
  final bool isMunicipality; // تحديد نوع المستخدم

  CreateAccountPage({required this.isMunicipality});

  @override
  CreateAccountPageState createState() => CreateAccountPageState();
}

class CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _municipalityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController(); // حقل تأكيد كلمة المرور

  bool isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool isValidMobileNumber(String mobile) {
    String pattern = r'^[0-9]{10}$'; // تحقق من أن الرقم يتكون من 10 أرقام
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(mobile);
  }

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
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. الاسم الكامل
                TextField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Enter your full name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // 2. رقم الجوال
                TextField(
                  controller: _mobileNumberController,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // 3. اسم المدينة
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'Enter your City',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // 4. اسم الشركة يظهر فقط إذا كان المستخدم بلدية
                if (widget.isMunicipality)
                  TextField(
                    controller: _municipalityController,
                    decoration: InputDecoration(
                      labelText: 'Name of the company',
                      border: OutlineInputBorder(),
                    ),
                  ),
                SizedBox(height: 16),

                // 5. الإيميل
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Enter your Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // 6. كلمة المرور
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // 7. تأكيد كلمة المرور
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () async {
                    // الحصول على القيم من الحقول
                    String fullName = _fullNameController.text;
                    String mobileNumber = _mobileNumberController.text;
                    String city = _cityController.text;
                    String municipality = _municipalityController.text;
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    String confirmPassword = _confirmPasswordController.text;

                    // تحقق من أن جميع الحقول مليئة
                    if (fullName.isNotEmpty && mobileNumber.isNotEmpty && city.isNotEmpty &&
                        (widget.isMunicipality ? municipality.isNotEmpty : true) &&
                        email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {

                      // تحقق من صحة البريد الإلكتروني
                      if (!isValidEmail(email)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('The email format is incorrect')),
                        );
                        return;
                      }

                      if (!isValidMobileNumber(mobileNumber)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('The phone number must contain only numbers ')),
                        );
                        return;
                      }

                      // تحقق من تطابق كلمة المرور
                      if (password != confirmPassword) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('The passwords do not match ')),
                        );
                        return;
                      }

                      try {
                        // إنشاء حساب جديد باستخدام Firebase
                        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        String userId = userCredential.user?.uid ?? ''; // الحصول على UID


                        // عرض إشعار يحتوي على الـ UID
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            Future.delayed(Duration(seconds: 20), () {
                            Navigator.of(context);
                          });
                            return AlertDialog(
                              title: Text('Account Created Successfully!'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Your User ID is:'),
                                  SizedBox(height: 8),
                                  SelectableText( // لتمكين التحديد والنسخ
                                    userId,
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(text: userId)); // نسخ الـ UID إلى الحافظة
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('User ID copied to clipboard!')),
                                      );
                                    },
                                    icon: Icon(Icons.copy),
                                    label: Text('Copy to Clipboard'),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // إغلاق النافذة
                                  },
                                  child: Text('Close'),
                                ),
                              ],
                            );
                          },
                        );

                        // تخزين البيانات في Firestore
                        await FirebaseFirestore.instance.collection('users').doc(userId).set({
                          'fullName': fullName,
                          'mobileNumber': mobileNumber,
                          'municipality': municipality,
                          'city': city,
                          'email': email,  // البريد الإلكتروني
                          'userId': userId,  // إضافة الـ UID هنا
                        });

                        // بعد إنشاء الحساب بنجاح، تسجيل الدخول تلقائيًا
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        // الانتقال إلى الصفحة الرئيسية
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } catch (e) {
                        // عرض رسالة خطأ إذا فشل إنشاء الحساب
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('فشل في إنشاء الحساب: $e')),
                        );
                      }
                    } else {
                      // عرض رسالة خطأ إذا كانت الحقول فارغة
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('يرجى ملء جميع الحقول')),
                      );
                    }
                  },
                  child: Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),

                // إضافة رابط "لديك حساب؟ تسجيل الدخول هنا"
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // الانتقال إلى صفحة تسجيل الدخول
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  },
                  child: Text(
                    'Already have an account? Login here',
                    style: TextStyle(color: Colors.green),
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