import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder rewards UI
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text('Your Rewards', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.star, size: 36, color: Colors.amber),
              title: const Text('Points Balance'),
              subtitle: const Text('You have 120 points'),
              trailing: ElevatedButton(onPressed: () {}, child: const Text('Redeem')),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Recent Rewards Activity'),
          const SizedBox(height: 8),
          const ListTile(leading: Icon(Icons.add), title: Text('Earned 20 points'), subtitle: Text('Payment - Today')),
        ],
      ),
    );
  }
}