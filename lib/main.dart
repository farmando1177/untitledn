import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/sign_up_page.dart';   // استيراد صفحة التسجيل
import 'pages/sign_in_page.dart';   // استيراد صفحة تسجيل الدخول
import 'pages/notification_service.dart'; // استيراد NotificationService

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // تأكد من أن Flutter جاهز
  await Firebase.initializeApp(); // تهيئة Firebase
  await NotificationService.init();  // تهيئة الإشعارات
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoWize',
      home: WelcomePage(), // تعيين صفحة الترحيب كصفحة البداية
    );
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logoo.png', height: 280, width: 280),
              SizedBox(height: 40),
              Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.green,
                ),
              ),
              Text(
                'EcoWize',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF43A047),
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Sign Up page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                  NotificationService.showNotification(); // عرض الإشعار بعد الانتقال
                },
                child: Text('SIGN UP', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Sign In page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                  NotificationService.showNotification(); // عرض الإشعار بعد الانتقال
                },
                child: Text('SIGN IN', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF66BB6A),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}