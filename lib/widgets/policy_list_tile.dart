import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../models/financial_item.dart';
import '../theme/app_theme.dart';

class PolicyListTile extends StatelessWidget {
  final FinancialItem item;

  const PolicyListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            _buildIcon(),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(fontSize: 16),
                      ),
                      Text(
                        NumberFormat.currency(symbol: '\$').format(item.amount),
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.provider,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'Due ${DateFormat.yMd().format(item.nextDueDate)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  if (item.insightText != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: _getInsightColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _getInsightColor().withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.lightbulb,
                            size: 14,
                            color: _getInsightColor(),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item.insightText!,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: _getInsightColor()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    IconData icon;
    Color color;

    switch (item.type) {
      case ItemType.insurance:
        icon = FontAwesomeIcons.shieldHeart;
        color = AppTheme.primary;
        break;
      case ItemType.utility:
        icon = FontAwesomeIcons.bolt;
        color = AppTheme.warning;
        break;
      case ItemType.loan:
        icon = FontAwesomeIcons.house;
        color = AppTheme.accent;
        break;
      case ItemType.tax:
        icon = FontAwesomeIcons.fileInvoiceDollar;
        color = AppTheme.error;
        break;
      case ItemType.warranty:
        icon = FontAwesomeIcons.screwdriverWrench;
        color = AppTheme.textSecondary;
        break;
      case ItemType.subscription:
        icon = FontAwesomeIcons.rotate;
        color = AppTheme.secondary;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }

  Color _getInsightColor() {
    if (item.status == Status.critical || item.status == Status.warning) {
      return AppTheme.warning;
    }
    return AppTheme.secondary;
  }
}
