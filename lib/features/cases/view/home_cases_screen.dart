import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../model/case_model.dart';
import 'case_card.dart';
import '../../settings/view/settings_screen.dart';

class HomeCasesScreen extends StatefulWidget {
  const HomeCasesScreen({super.key});

  @override
  State<HomeCasesScreen> createState() => _HomeCasesScreenState();
}

class _HomeCasesScreenState extends State<HomeCasesScreen> {
  final TextEditingController searchController = TextEditingController();
  String selectedType = 'الكل';

  final List<LegalCase> allCases = [
    LegalCase(
      id: '1',
      title: 'قضية نزاع عقاري',
      number: 'LY-2025-001',
      court: 'محكمة طرابلس',
      lawyer: 'أحمد الزروق',
      nextSession: '15/01/2026',
      type: 'مدني',
      status: 'مفتوحة',
    ),
    LegalCase(
      id: '2',
      title: 'قضية طلاق',
      number: 'LY-2025-003',
      court: 'محكمة مصراتة',
      lawyer: 'فاطمة السنوسي',
      nextSession: '18/01/2026',
      type: 'أسرة',
      status: 'مؤجلة',
    ),
    LegalCase(
      id: '3',
      title: 'قضية احتيال تجاري',
      number: 'LY-2025-010',
      court: 'محكمة بنغازي',
      lawyer: 'سالم عبدالسلام',
      nextSession: '22/02/2026',
      type: 'تجاري',
      status: 'مفتوحة',
    ),
    LegalCase( id: '4',
      title: 'قضية جنائية',
      number: 'LY-2025-020',
      court: 'محكمة سبها',
      lawyer: 'عبدالله الورفلي',
      nextSession: '10/03/2026',
      type: 'جنائي',
      status: 'مغلقة', ),
    LegalCase( id: '5',
      title: 'قضية نفقة',
      number: 'LY-2025-021',
      court: 'محكمة الزاوية',
      lawyer: 'منى العابد',
      nextSession: '05/02/2026',
      type: 'أسرة',
      status: 'مفتوحة', ),
    LegalCase( id: '6',
      title: 'قضية تعويض',
      number: 'LY-2025-030',
      court: 'محكمة الخمس',
      lawyer: 'خالد الشريف',
      nextSession: '28/02/2026',
      type: 'مدني',
      status: 'مؤجلة', ),
    LegalCase( id: '7',
      title: 'قضية إفلاس شركة',
      number: 'LY-2025-041',
      court: 'محكمة طرابلس التجارية',
      lawyer: 'إبراهيم قدور',
      nextSession: '12/03/2026',
      type: 'تجاري',
      status: 'مفتوحة', ),
    LegalCase( id: '8',
      title: 'قضية تزوير',
      number: 'LY-2025-050',
      court: 'محكمة بنغازي',
      lawyer: 'محمد الفيتوري',
      nextSession: '01/04/2026',
      type: 'جنائي',
      status: 'مغلقة', ),
    LegalCase( id: '9',
      title: 'قضية حضانة',
      number: 'LY-2025-061',
      court: 'محكمة تاجوراء',
      lawyer: 'سارة المبروك',
      nextSession: '20/02/2026',
      type: 'أسرة',
      status: 'مفتوحة', ),
    LegalCase( id: '10',
      title: 'قضية نزاع إداري',
      number: 'LY-2025-070',
      court: 'المحكمة الإدارية',
      lawyer: 'يوسف الدرسي',
      nextSession: '30/03/2026',
      type: 'إداري',
      status: 'مؤجلة', ),
  ];

  List<LegalCase> get filteredCases {
    return allCases.where((c) {
      final search = searchController.text;
      final matchesSearch =
          c.title.contains(search) ||
              c.number.contains(search) ||
              c.court.contains(search);

      final matchesType =
          selectedType == 'الكل' || c.type == selectedType;

      return matchesSearch && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // 🔝 AppBar
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 28,
              height: 28,
            ),
            const SizedBox(width: 8),
            const Text(
              'منصة القضايا الليبية',
              style: TextStyle(
                color: AppColors.gold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.gold),
            onPressed: () {
              // لاحقًا صفحة الإشعارات
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: AppColors.gold),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 16),

          // 🔍 SEARCH
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'ابحث برقم القضية أو المحكمة',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 🏷 FILTERS
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                for (final type
                in ['الكل', 'مدني', 'تجاري', 'جنائي', 'أسرة', 'إداري'])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(type),
                      selected: selectedType == type,
                      selectedColor: AppColors.primary,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: selectedType == type
                            ? Colors.white
                            : Colors.black87,
                      ),
                      onSelected: (_) {
                        setState(() => selectedType = type);
                      },
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 📋 CASES LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredCases.length,
              itemBuilder: (context, index) {
                return CaseCard(caseItem: filteredCases[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
