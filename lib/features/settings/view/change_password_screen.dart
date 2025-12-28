import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final oldPass = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();

  String? error;

  Future<void> _changePassword() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPass = prefs.getString('password');

    if (oldPass.text != savedPass) {
      setState(() => error = 'كلمة المرور الحالية غير صحيحة');
      return;
    }

    if (newPass.text.length < 6) {
      setState(() => error = 'كلمة المرور الجديدة قصيرة');
      return;
    }

    if (newPass.text != confirmPass.text) {
      setState(() => error = 'كلمتا المرور غير متطابقتين');
      return;
    }

    await prefs.setString('password', newPass.text);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تغيير كلمة المرور')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: oldPass,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'كلمة المرور الحالية'),
            ),
            TextField(
              controller: newPass,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'كلمة المرور الجديدة'),
            ),
            TextField(
              controller: confirmPass,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'تأكيد كلمة المرور'),
            ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(error!, style: const TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePassword,
              child: const Text('حفظ'),
            ),
          ],
        ),
      ),
    );
  }
}
