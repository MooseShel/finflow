import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/mock_data_service.dart';
import '../widgets/summary_card.dart';
import '../widgets/policy_list_tile.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

class OverviewTab extends StatefulWidget {
  const OverviewTab({super.key});

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  final items = MockDataService.getItems();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, Family',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Here is the latest on your household finances.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
              if (!ResponsiveLayout.isMobile(context))
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download),
                  label: const Text('Export Report'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.surfaceDark,
                    foregroundColor: AppTheme.textPrimary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 32),
          _buildSummaryCards(context),
          const SizedBox(height: 32),
          ResponsiveLayout(
            mobile: Column(
              children: [
                _buildUpcomingSection(),
                const SizedBox(height: 32),
                _buildInsightsSection(),
              ],
            ),
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2, child: _buildUpcomingSection()),
                const SizedBox(width: 32),
                Expanded(flex: 1, child: _buildInsightsSection()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: '\$');
    final totalObligations = MockDataService.getTotalMonthlyObligations();
    final potentialSavings = MockDataService.getPotentialSavings();

    final cards = [
      SummaryCard(
        title: 'Monthly Obligations',
        amount: currencyFormat.format(totalObligations),
        subtitle: 'Across 6 active accounts',
        icon: FontAwesomeIcons.wallet,
        iconColor: AppTheme.primary,
      ),
      SummaryCard(
        title: 'Potential Savings',
        amount: currencyFormat.format(potentialSavings),
        subtitle: 'Found in your policies',
        icon: FontAwesomeIcons.piggyBank,
        iconColor: AppTheme.secondary,
      ),
      SummaryCard(
        title: 'Upcoming Events',
        amount: '3',
        subtitle: 'Require attention in 30 days',
        icon: FontAwesomeIcons.calendarDay,
        iconColor: AppTheme.warning,
      ),
    ];

    if (ResponsiveLayout.isMobile(context)) {
      return Column(
        children: cards
            .map(
              (c) =>
                  Padding(padding: const EdgeInsets.only(bottom: 16), child: c),
            )
            .toList(),
      );
    }

    return Row(
      children: cards
          .map(
            (c) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: c,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildUpcomingSection() {
    items.sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));
    final upcomingItems = items.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming & Active',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        ...upcomingItems.map((item) => PolicyListTile(item: item)),
      ],
    );
  }

  Widget _buildInsightsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Savings & Risks', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        FontAwesomeIcons.triangleExclamation,
                        color: AppTheme.error,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Property Tax Protest Deadline',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'You have 90 days to file a protest. Based on neighborhood comps, FinFlow estimates a potential savings of \$450.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.error,
                    ),
                    child: const Text('Start Auto-Protest'),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Expense Breakdown',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: [
                        PieChartSectionData(
                          color: AppTheme.primary,
                          value: 45,
                          title: '45%',
                          radius: 40,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: AppTheme.secondary,
                          value: 25,
                          title: '25%',
                          radius: 40,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: AppTheme.accent,
                          value: 20,
                          title: '20%',
                          radius: 40,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: AppTheme.warning,
                          value: 10,
                          title: '10%',
                          radius: 40,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
