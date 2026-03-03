enum ItemType { insurance, utility, loan, tax, warranty, subscription }

enum Status { active, warning, critical, pending }

class FinancialItem {
  final String id;
  final String title;
  final String provider;
  final ItemType type;
  final Status status;
  final DateTime nextDueDate;
  final double amount;
  final String? insightText;

  FinancialItem({
    required this.id,
    required this.title,
    required this.provider,
    required this.type,
    required this.status,
    required this.nextDueDate,
    required this.amount,
    this.insightText,
  });

  bool get isRenewalUpcoming {
    final difference = nextDueDate.difference(DateTime.now()).inDays;
    return difference <= 30 && difference >= 0;
  }
}
