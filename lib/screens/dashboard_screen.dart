import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'overview_tab.dart';
import 'policies_view.dart';
import 'finances_view.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const OverviewTab(),
    const PoliciesView(),
    const FinancesView(),
    const Center(child: Text('Settings (Coming Soon)')),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);

    return Scaffold(
      appBar: isDesktop
          ? null
          : AppBar(
              backgroundColor: AppTheme.surfaceDark,
              elevation: 0,
              title: Text(
                'FinFlow',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: AppTheme.primary,
                  child: Text('US', style: TextStyle(fontSize: 12)),
                ),
                const SizedBox(width: 16),
              ],
            ),
      drawer: isDesktop ? null : _buildSidebar(context),
      body: Row(
        children: [
          if (isDesktop) _buildSidebar(context),
          Expanded(
            child: Container(
              color: AppTheme.backgroundDark,
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.snackbar(
            'Connect Account',
            'Integration flow starting...',
            backgroundColor: AppTheme.surfaceDark,
            colorText: AppTheme.textPrimary,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(16),
          );
        },
        backgroundColor: AppTheme.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Add Account', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    final isDesktop = ResponsiveLayout.isDesktop(context);
    return Container(
      width: 250,
      color: AppTheme.surfaceDark,
      child: Column(
        children: [
          if (isDesktop)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  const Icon(FontAwesomeIcons.water, color: AppTheme.primary),
                  const SizedBox(width: 12),
                  Text(
                    'FinFlow',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          _buildNavItem(0, 'Overview', FontAwesomeIcons.chartPie),
          _buildNavItem(1, 'Policies', FontAwesomeIcons.shieldHalved),
          _buildNavItem(2, 'Finances', FontAwesomeIcons.buildingColumns),
          const Spacer(),
          const Divider(color: Color(0xFF334155)),
          _buildNavItem(3, 'Settings', FontAwesomeIcons.gear),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String title, IconData icon) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        if (!ResponsiveLayout.isDesktop(context)) {
          Navigator.pop(context); // Close drawer on mobile
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: AppTheme.primary.withOpacity(0.5))
              : Border.all(color: Colors.transparent),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
