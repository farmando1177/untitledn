import 'package:eco_wize/pages/WasteCollectionPlanPage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ControlPage.dart';
import 'ProfilePage.dart';
import 'SupportPage.dart';
import 'SettingsPage.dart';
import 'LogIn.dart';
import 'AddEmployeePage.dart';
import 'Home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController; // التحكم في التابات

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this); // تحديد عدد التابات
  }

  @override
  void dispose() {
    _tabController.dispose(); // التأكد من التخلص من التاب كونترولر عند الخروج
    super.dispose();
  }

  // دالة لفتح الرابط
  Future<void> _openLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'EcoWize',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              // عندما يتم الضغط على الأيقونة، نعرض نافذة منبثقة
              _showActionDialog(context);
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LogIn()),
            );
            print('Log out');
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController, // ربط التاب بار في الفيو
        children: const [
          Home(),
          ControlPage(),
          ProfilePage(),
          SupportPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index, // تعيين التاب الحالي
        onTap: (int index) {
          setState(() {
            _tabController.index = index; // تغيير التاب عند الضغط
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.control_camera),
            label: 'Control',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.support),
            label: 'Support',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: const Color.fromARGB(255, 21, 53, 22),
      ),
    );
  }

  // دالة لفتح نافذة منبثقة عند الضغط على الأيقونة
  void _showActionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  const url = 'http://esp32.local'; // الرابط الذي تود فتحه
                  final Uri uri = Uri.parse(url); // تحويل النص إلى URI
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);  // استخدام launchUrl بدلاً من launch
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: const Text('Waste Classification'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AddEmployeePage()),
                  );
                },
                child: const Text('Add Employee'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WasteCollectionPlanPage()),
                  );
                },
                child: const Text('WasteCollectionPlan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}