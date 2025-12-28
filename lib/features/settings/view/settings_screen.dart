import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../notifications/view/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/locale_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context)
  {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'الإعدادات',
          style: TextStyle(color: AppColors.gold),
        ),
        iconTheme: const IconThemeData(color: AppColors.gold),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ====== الحساب ======
          _sectionCard(
            title: 'الحساب',
            icon: Icons.person_outline,
            child: Column(
              children: const [
                _InfoRow(title: 'الاسم', value: 'أحمد الزروق'),
                _InfoRow(title: 'البريد الإلكتروني', value: 'ahmed@example.com'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ====== المظهر ======
          _sectionCard(
            title: 'المظهر',
            icon: Icons.palette_outlined,
            child: SwitchListTile(
              title: const Text('الوضع الداكن'),
              value: themeProvider.isDark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),


          const SizedBox(height: 16),

          // ====== اللغة ======
          _sectionCard(
            title: 'اللغة',
            icon: Icons.language,
            child: Column(
              children: [
                RadioListTile<Locale>(
                  title: const Text('العربية'),
                  value: const Locale('ar'),
                  groupValue: context.watch<LocaleProvider>().locale,
                  onChanged: (value) {
                    context.read<LocaleProvider>().setLocale(value!);
                  },
                ),
                RadioListTile<Locale>(
                  title: const Text('English'),
                  value: const Locale('en'),
                  groupValue: context.watch<LocaleProvider>().locale,
                  onChanged: (value) {
                    context.read<LocaleProvider>().setLocale(value!);
                  },
                ),
              ],
            ),
          ),


          const SizedBox(height: 16),

          // ====== الإشعارات ======
          _sectionCard(
            child: _item(
              icon: Icons.notifications_none,
              title: 'الإشعارات',
              subtitle: 'إدارة الإشعارات',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const NotificationsScreen(),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // ====== الأمان ======
          _sectionCard(
            title: 'الأمان',
            icon: Icons.lock_outline,
            child: Column(
              children: [
                _securityButton(
                  context,
                  text: 'تغيير كلمة المرور',
                  color: Colors.white,
                  textColor: Colors.black87,
                  onTap: () {
                    // TODO: صفحة تغيير كلمة المرور
                  },
                ),
                const SizedBox(height: 8),
                _securityButton(
                  context,
                  text: 'تسجيل الخروج',
                  color: Colors.red.shade50,
                  textColor: Colors.red,
                  onTap: () {
                    // TODO: تسجيل الخروج
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ====== حفظ التغييرات ======
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3CD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'حفظ التغييرات',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'تأكد من حفظ إعداداتك قبل المغادرة',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gold,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    // TODO: حفظ الإعدادات
                  },
                  child: const Text('حفظ'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ====== عناصر ======

  Widget _item({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _sectionCard({
    String? title,
    IconData? icon,
    required Widget child,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    if (icon != null)
                      Icon(icon, size: 18, color: AppColors.primary),
                    if (icon != null) const SizedBox(width: 6),
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            child,
          ],
        ),
      ),
    );
  }

  Widget _securityButton(
      BuildContext context, {
        required String text,
        required Color color,
        required Color textColor,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// ====== عنصر معلومات الحساب ======
class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(title)),
          Text(
            value,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
