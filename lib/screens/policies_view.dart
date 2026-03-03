import 'package:flutter/material.dart';
import '../models/financial_item.dart';
import '../services/mock_data_service.dart';
import '../widgets/policy_list_tile.dart';

class PoliciesView extends StatelessWidget {
  const PoliciesView({super.key});

  @override
  Widget build(BuildContext context) {
    final items = MockDataService.getItems()
        .where(
          (item) =>
              item.type == ItemType.insurance ||
              item.type == ItemType.utility ||
              item.type == ItemType.warranty,
        )
        .toList();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Policies & Utilities',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return PolicyListTile(item: items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
