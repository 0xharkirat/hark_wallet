import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hark_wallet/src/controllers/ether_wallet_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final etherWalletList = ref.watch(etherWalletController);
    
    log("etherWalletList: $etherWalletList");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            
            ElevatedButton(
              onPressed: () {
                ref.read(etherWalletController.notifier).generateWalletFromSeed();
                
              },
              child: const Text('Generate Mnemonic'),
            ),
          ],
        ),
      ),
    );
  }
}
