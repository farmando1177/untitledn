import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // العنوان
            const Text(
              'Frequently Asked Questions (FAQ)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // الأسئلة والأجوبة
            _faqItem(
              question: 'How do I reset my password?',
              answer:
              'To reset your password, click on "Forgot Password" on the login page.',
            ),
            _faqItem(
              question: 'How can I update my profile?',
              answer:
              'Go to your profile page and click "Edit Profile" to update your information.',
            ),
            _faqItem(
              question: 'How do I contact support?',
              answer:
              'You can reach out to support via the contact form or email us at support@ecowize.com.',
            ),
            const SizedBox(height: 40),

            // نموذج التواصل
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _contactForm(context),
          ],
        ),
      ),
    );
  }

  // عنصر للسؤال والإجابة في الأسئلة الشائعة
  Widget _faqItem({required String question, required String answer}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              answer,
              style: const TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  // نموذج للتواصل مع الدعم
  Widget _contactForm(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your Name:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter your name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const Text('Email Address:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const Text('Message:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter your message',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // تنفيذ عملية إرسال النموذج
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Message Sent')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
              ),
              child: const Text('Send Message'),
            ),
          ],
        ),
      ),
    );
  }
}