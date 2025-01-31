import 'package:eco_wize/pages/WelcomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notify.dart'; // استيراد ملف DarkMode

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final thmode = Provider.of<DarkMode>(context); // الوصول إلى DarkMode
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // الوضع الداكن
            ListTile(
              title: const Text("Dark Mode"),
              trailing: Switch(
                value: thmode.darkMode, // الحصول على القيمة الحالية للوضع
                onChanged: (bool value) {
                  thmode.changemode(); // تغيير الوضع عند التبديل
                },
              ),
            ),

            const Divider(),

            // تسجيل الخروج
            ListTile(
              title: const Text("Log out"),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomePage()),
                );
              },
              textColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}