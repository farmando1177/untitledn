import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // بيانات قابلة للتعديل
  String companyName = 'EcoWize Municipality';
  String companyAddress = '123 Green Street, EcoCity';
  String companyPhone = '+123 456 789';
  String companyEmail = 'contact@ecowize.com';
  String companyDescription = 'An eco-friendly municipality focused on sustainability.';
  String foundationDate = 'January 1, 2025';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 📌 **تحميل البيانات من Firebase**
  Future<void> _loadData() async {
    DocumentSnapshot snapshot = await _firestore.collection('companies').doc('eco_wize').get();
    if (snapshot.exists) {
      setState(() {
        companyName = snapshot['name'];
        companyAddress = snapshot['address'];
        companyPhone = snapshot['phone'];
        companyEmail = snapshot['email'];
        companyDescription = snapshot['description'];
        foundationDate = snapshot['foundationDate'];
      });
    }
  }

  // 📌 **حفظ البيانات إلى Firebase**
  Future<void> _saveData() async {
    await _firestore.collection('companies').doc('eco_wize').set({
      'name': companyName,
      'address': companyAddress,
      'phone': companyPhone,
      'email': companyEmail,
      'description': companyDescription,
      'foundationDate': foundationDate,
    });
  }

  // 📌 **حوار تعديل البيانات**
  void _editField(String title, String currentValue, Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $title'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter new $title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
              _saveData(); // حفظ البيانات بعد التعديل
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadData(); // تحميل البيانات عند بدء التطبيق
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/logoo.png'),
              ),
              const SizedBox(height: 20),

              // ✅ **إمكانية تعديل الاسم**
              _buildEditableField('Company Name', companyName, (value) {
                setState(() {
                  companyName = value;
                });
              }),

              // ✅ **إمكانية تعديل الوصف**
              _buildEditableField('Description', companyDescription, (value) {
                setState(() {
                  companyDescription = value;
                });
              }),

              const SizedBox(height: 20),

              // ✅ **معلومات الاتصال القابلة للتعديل**
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildEditableField('Address', companyAddress, (value) {
                        setState(() {
                          companyAddress = value;
                        });
                      }),
                      const Divider(),
                      _buildEditableField('Phone', companyPhone, (value) {
                        setState(() {
                          companyPhone = value;
                        });
                      }),
                      const Divider(),
                      _buildEditableField('Email', companyEmail, (value) {
                        setState(() {
                          companyEmail = value;
                        });
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ✅ **عرض تاريخ التأسيس**
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: const Icon(Icons.date_range, color: Colors.green),
                  title: const Text('Established'),
                  subtitle: Text(foundationDate),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.grey),
                    onPressed: () => _editField('Foundation Date', foundationDate, (value) {
                      setState(() {
                        foundationDate = value;
                      });
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// 📌 **ودجت قابلة للتعديل**
  Widget _buildEditableField(String title, String value, Function(String) onSave) {
    return ListTile(
      leading: const Icon(Icons.edit, color: Colors.green),
      title: Text(title),
      subtitle: Text(value),
      trailing: const Icon(Icons.edit, color: Colors.grey),
      onTap: () => _editField(title, value, onSave),
    );
  }
}