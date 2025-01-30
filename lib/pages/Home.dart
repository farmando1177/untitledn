import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class SystemStatus extends StatelessWidget {
  const SystemStatus({super.key});

  // الدالة التي تفتح الرابط
  Future<void> _openLink(String url) async {
    final Uri uri = Uri.parse(url); // تحويل النص إلى URI
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
        title: const Text("Home"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _openLink("https://app.arduino.cc/sketches/0208d1f5-dd43-4410-bdd5-69597e8335dd"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          ),
          child: const Text("Open Link"),
        ),
      ),
    );
  }
}
