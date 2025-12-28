import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_color.dart';
import '../../profile/view/providers/theme_provider.dart';
import '../../profile/view/providers/locale_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../notifications/view/notifications_screen.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          t.settings,
          style: const TextStyle(color: AppColors.gold),
        ),
        iconTheme: const IconThemeData(color: AppColors.gold),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ====== الحساب ======
          _sectionCard(
            title: t.account ,
            icon: Icons.person_outline,
            child: Column(
              children: [
                InfoRow(title: t.name ?? '', value: 'أحمد الزروق'),
                InfoRow(title: t.email ?? '', value: 'ahmed@example.com'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ====== المظهر ======
          _sectionCard(
            title: t.appearance,
            icon: Icons.palette_outlined,
            child: SwitchListTile(
              title: Text(t.dark_mode),
              value: themeProvider.isDark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
              },
            ),
          ),

          const SizedBox(height: 16),

          // ====== اللغة ======
          _sectionCard(
            title: t.language,
            icon: Icons.language,
            child: Column(
              children: [
                RadioListTile<Locale>(
                  title: const Text('العربية'),
                  value: const Locale('ar'),
                  groupValue: localeProvider.locale,
                  onChanged: (value) {
                    localeProvider.setLocale(value!.languageCode);

                  },
                ),
                RadioListTile<Locale>(
                  title: const Text('English'),
                  value: const Locale('en'),
                  groupValue: localeProvider.locale,
                  onChanged: (value) {
                    localeProvider.setLocale(value!.languageCode);

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
              title: t.notifications,
              subtitle: t.manageNotifications,
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
            title: t.security,
            icon: Icons.lock_outline,
            child: Column(
              children: [
                _securityButton(
                  context,
                  text: t.changePassword,
                  color: Theme.of(context).cardColor,
                  textColor: Theme.of(context).textTheme.bodyLarge!.color!,
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                _securityButton(
                  context,
                  text: t.logout,
                  color: Colors.red.shade50,
                  textColor: Colors.red,
                  onTap: () {
                    // TODO: logout حقيقي
                  },
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
  }}

// ✅ لازم يكون في نفس الملف
class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({
    super.key,
    required this.title,
    required this.value,
  });

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