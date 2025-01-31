import 'package:eco_wize/pages/notification_service.dart';
import 'package:eco_wize/pages/LogIn.dart';
import 'package:flutter/material.dart';
import 'package:eco_wize/pages/create_account_page.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
              const SizedBox(height: 40),
              const Text(
                'Welcome to',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.green,
                ),
              ),
              const Text(
                'EcoWize',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF43A047),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Sign Up page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateAccountPage(isMunicipality: true)),
                  );
                  NotificationService.showNotification(); // عرض الإشعار بعد الانتقال
                },
                child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Sign In page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogIn()),
                  );
                  NotificationService.showNotification();
                },
                child: const Text('LogIn', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF66BB6A),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

