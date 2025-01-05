// ignore: file_names
import 'package:flutter/material.dart';
import 'sign_in_page.dart';
import 'ControlPage.dart';
import 'ProfilePage.dart';
import 'SupportPage.dart';
import 'SettingsPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // لمؤشر الأيقونة المحددة

// دالة لتغيير الأيقونة المحددة
  void _onItemTapped(int index) {
// إذا كانت الصفحة التي تم النقر عليها هي نفس الصفحة الحالية، لا تفعل شيئًا
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

// التنقل إلى الصفحة المناسبة بناءً على الفهرس
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SystemStatus()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ControlPage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SupportPage()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsPage()),
        );
        break;
    }
  }

  final List<Widget> _widgetOptions = <Widget>[
    const SystemStatus(),
    const ControlPage(),
    const ProfilePage(),
    const SupportPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'EcoWize',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WasteClassificationPage()),
              );
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
            print('تسجيل الخروج');
          },
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: const Color.fromARGB(255, 21, 53, 22),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap:
        _onItemTapped, // عند النقر على الأيقونة يتم الانتقال إلى الصفحة المناسبة
      ),
    );
  }
}

class SystemStatus extends StatelessWidget {
  const SystemStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'System Status',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _statusCard(context, '25', 'Number of full waste bins'),
              _statusCard(context, '39', 'Number of drones'),
              _statusCard(context, '8', 'Number of complaints'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusCard(BuildContext context, String number, String label) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width *
            0.25, // عرض البطاقة كنسبة من عرض الشاشة
        height: 170, // ارتفاع البطاقة
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WasteClassificationPage extends StatelessWidget {
  const WasteClassificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Waste Classification',
          style: TextStyle(
            color: Colors.white, // تعيين لون النص إلى الأبيض
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'Welcome to Waste Classification',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}