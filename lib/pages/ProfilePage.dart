import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات الشركة أو البلدية المدخلة عند التسجيل
    const String companyName = 'EcoWize Municipality';
    const String companyLogoUrl = 'https://example.com/logo.png'; // صورة الشعار
    const String companyAddress = '123 Green Street, EcoCity';
    const String companyPhone = '+123 456 789';
    const String companyEmail = 'contact@ecowize.com';
    const String companyDescription =
        'An eco-friendly municipality focused on sustainability.';
    const String foundationDate = 'January 1, 1990';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // عرض الشعار
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/logoo.png'), // الصورة المحلية
              ),
              const SizedBox(height: 20),

              // عرض اسم الشركة أو البلدية
              Text(
                companyName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),

              // عرض الوصف
              Text(
                companyDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),

              // عرض معلومات الاتصال
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Contact Information:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.green),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              companyAddress,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.phone, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(
                            companyPhone,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.email, color: Colors.green),
                          const SizedBox(width: 8),
                          Text(
                            companyEmail,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // عرض تاريخ التأسيس
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(Icons.date_range, color: Colors.green),
                  title: const Text('Established'),
                  subtitle: Text(foundationDate),
                ),
              ),
              const SizedBox(height: 20),

              // أزرار لتعديل البيانات
              ElevatedButton.icon(
                onPressed: () {
                  // الانتقال إلى صفحة تعديل البيانات
                },
                icon: const Icon(Icons.edit, color: Colors.white),
                label: const Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // الانتقال إلى صفحة تعديل كلمة المرور
                },
                icon: const Icon(Icons.lock, color: Colors.white),
                label: const Text('Change Password'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}