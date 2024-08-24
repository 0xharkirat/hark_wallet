import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hark_wallet/src/controllers/ether_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(etherController).createWallet();
              },
              child: const Text('Create Wallet'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(etherController).generateMnemonic();
              },
              child: const Text('Generate Mnemonic'),
            ),
          ],
        ),
      ),
    );
  }
}
