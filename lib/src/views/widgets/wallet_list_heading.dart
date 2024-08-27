import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hark_wallet/src/controllers/ether_wallet_controller.dart';
import 'package:hark_wallet/src/core/constants/colors.dart';

class WalletListHeading extends ConsumerWidget {
  const WalletListHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text("Your Ethereum Wallets",
            style: Theme.of(context).textTheme.headlineLarge),
        const Spacer(),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            ref.read(etherWalletController.notifier).generateWallet();
          },
          child: Text(
            "Add Wallet",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: kErrorColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            ref.read(etherWalletController.notifier).reset();
          },
          child: Text("Clear Wallets",
              style: Theme.of(context).textTheme.titleLarge),
        ),
      ],
    );
  }
}
