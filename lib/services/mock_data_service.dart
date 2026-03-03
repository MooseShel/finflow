import '../models/financial_item.dart';

class MockDataService {
  static List<FinancialItem> getItems() {
    final now = DateTime.now();
    return [
      FinancialItem(
        id: '1',
        title: 'Homeowners Insurance',
        provider: 'State Farm',
        type: ItemType.insurance,
        status: Status.warning,
        nextDueDate: now.add(const Duration(days: 14)),
        amount: 2400.0,
        insightText: 'Premium increased by 12% YoY. Consider shopping rates.',
      ),
      FinancialItem(
        id: '2',
        title: 'Electricity Plan',
        provider: 'Reliant Energy',
        type: ItemType.utility,
        status: Status.active,
        nextDueDate: now.add(const Duration(days: 45)),
        amount: 125.50,
        insightText: 'Fixed rate expires soon. Switching early saves \$15/mo.',
      ),
      FinancialItem(
        id: '3',
        title: 'Primary Mortgage',
        provider: 'Chase Bank',
        type: ItemType.loan,
        status: Status.active,
        nextDueDate: now.add(const Duration(days: 5)),
        amount: 3200.0,
        insightText: 'Escrow analysis upcoming in October.',
      ),
      FinancialItem(
        id: '4',
        title: 'Property Taxes',
        provider: 'County Tax Office',
        type: ItemType.tax,
        status: Status.critical,
        nextDueDate: now.add(const Duration(days: 90)),
        amount: 8500.0,
        insightText: 'Protest deadline approaching. Estimated savings: \$450.',
      ),
      FinancialItem(
        id: '5',
        title: 'Auto Insurance',
        provider: 'Geico',
        type: ItemType.insurance,
        status: Status.active,
        nextDueDate: now.add(const Duration(days: 120)),
        amount: 850.0,
      ),
      FinancialItem(
        id: '6',
        title: 'HVAC Warranty',
        provider: 'Trane Heating & Cooling',
        type: ItemType.warranty,
        status: Status.active,
        nextDueDate: now.add(const Duration(days: 365)),
        amount: 0.0,
        insightText: 'Annual maintenance required to keep warranty valid.',
      ),
      FinancialItem(
        id: '7',
        title: 'Internet Service',
        provider: 'Xfinity',
        type: ItemType.utility,
        status: Status.active,
        nextDueDate: now.add(const Duration(days: 15)),
        amount: 85.0,
      ),
      FinancialItem(
        id: '8',
        title: 'Streaming Bundle',
        provider: 'Netflix & Hulu',
        type: ItemType.subscription,
        status: Status.active,
        nextDueDate: now.add(const Duration(days: 12)),
        amount: 25.98,
        insightText: 'Price increasing by \$2 next month.',
      ),
      FinancialItem(
        id: '9',
        title: 'Auto Loan',
        provider: 'Capital One Auto',
        type: ItemType.loan,
        status: Status.active,
        nextDueDate: now.add(const Duration(days: 20)),
        amount: 450.0,
        insightText: 'Refinance at current rates for \$35/mo savings.',
      ),
    ];
  }

  static double getTotalMonthlyObligations() {
    // Highly simplified mock logic
    return 3200.0 +
        125.50 +
        (2400 / 12) +
        (850 / 6) +
        (8500 / 12) +
        85.0 +
        25.98 +
        450.0;
  }

  static double getPotentialSavings() {
    return 450.0 + (15.0 * 12) + 288.0; // Mock annual savings
  }
}
