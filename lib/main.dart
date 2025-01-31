import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // تأكد من وجود هذا الملف
import 'pages/notification_service.dart'; // استيراد NotificationService
import 'notify.dart'; // استيراد ملف DarkMode
import 'package:provider/provider.dart';
import 'pages/SplashScreenPage.dart';
//import 'pages/HomePage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:intl/intl.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web, // خيارات Firebase
  );

  // معالجة الإشعارات عند تشغيل التطبيق في الخلفية
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await NotificationService.init(); // تهيئة الإشعارات

  // تهيئة الإشعارات المحلية
  await initLocalNotifications();

  runApp(
    ChangeNotifierProvider(
      create: (context) => DarkMode(),
      child: const MyApp(),
    ),
  );
}

// دالة لتلقي الإشعارات في الخلفية
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Received notification: ${message.notification?.title}");
}

// تهيئة الإشعارات المحلية
Future<void> initLocalNotifications() async {
  tz.initializeTimeZones();
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings settings =
  InitializationSettings(android: androidSettings);
  await flutterLocalNotificationsPlugin.initialize(settings);
}

Future<void> scheduleWasteCollectionNotification(
    String area, String day, String time) async {
  DateTime now = DateTime.now();
  DateTime scheduledTime = DateFormat('hh:mm a').parse(time);
  DateTime notificationTime = DateTime(
      now.year, now.month, now.day, scheduledTime.hour, scheduledTime.minute);

  if (notificationTime.isBefore(now)) {
    notificationTime = notificationTime.add(Duration(days: 1));
  }

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    "Waste Collection Reminder",
    "Trash collection for $area is scheduled at $time on $day.",
    tz.TZDateTime.from(notificationTime, tz.local),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'waste_channel',
        'Waste Collection',
        channelDescription: 'Reminds about waste collection',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // ✅ Fix
    uiLocalNotificationDateInterpretation:
    UILocalNotificationDateInterpretation.absoluteTime,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final thmode = Provider.of<DarkMode>(context);

    return MaterialApp(
      title: 'EcoWize',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: thmode.darkMode ? ThemeMode.dark : ThemeMode.light,


      //home: const HomePage(),
      home: const SplashScreen(),

    );
  }
}