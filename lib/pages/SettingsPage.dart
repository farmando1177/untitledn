import 'package:EcoWize/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'notification_service.dart'; // استيراد خدمة الإشعارات الخاصة بك

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // قسم إعدادات الملف الشخصي
            Text(
              "Account",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text("Profile Settings"),
              onTap: () {
                // Navigate to profile settings
              },
            ),
            ListTile(
              title: const Text("Notifications"),
              onTap: () {
                // تفعيل الإشعار عند الضغط على Notifications
                NotificationService.showNotification();
              },
            ),

            const Divider(), // فاصل بين الأقسام

            // قسم الخصوصية
            Text(
              "Privacy",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text("Privacy Settings"),
              onTap: () {
                // Navigate to privacy settings
              },
            ),
            ListTile(
              title: const Text("Language"),
              onTap: () {
                // Navigate to language settings
              },
            ),

            const Divider(), // فاصل بين الأقسام

            // قسم الوضع الداكن
            ListTile(
              title: const Text("Dark Mode"),
              trailing: Switch(
                value: true, // Set the actual value here
                onChanged: (bool value) {
                  // Handle dark mode toggle
                },
              ),
            ),

            const Divider(), // فاصل بين الأقسام

            // قسم تسجيل الخروج
            ListTile(
              title: const Text("Log out"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              textColor: Colors.red, // لون نص تسجيل الخروج
            ),
          ],
        ),
      ),
    );
  }
}