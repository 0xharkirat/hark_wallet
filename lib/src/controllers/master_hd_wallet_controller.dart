import 'dart:developer' as dev;
import 'package:flutter/foundation.dart'; // Import for compute
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hark_wallet/src/models/master_hd_wallet.dart';
import 'package:bip39/bip39.dart' as bip39;

// Top-level function for `compute`
Future<Seed?> _computeGenerateSeed(Mnemonic mnemonic) async {
  return compute(_generateSeed, mnemonic);
}

// Function to actually generate the seed
Seed? _generateSeed(Mnemonic mnemonic) {
  if (!bip39.validateMnemonic(mnemonic)) {
    return null;
  }
  return bip39.mnemonicToSeed(mnemonic);
}

class MasterHDWalletController extends Notifier<MasterHDWallet?> {
  @override
  MasterHDWallet? build() {
    return null;
  }

  /// public functions
  Future<void> createNewMasterWallet() async {
    dev.log("creating new master wallet...");
    try {
      // Step 1: Generate a new mnemonic
      final mnemonic = _generateNewMnemonic();

      // Step 2: Generate a seed from the mnemonic
      final seed = await _computeGenerateSeed(mnemonic);
      if (seed == null) {
        dev.log("Failed to generate seed");
        return;
      }

      // Step 3: Generate a master HD wallet from the seed & set the state
      _generateMasterHDWallet(mnemonic, seed);
    } catch (e) {
      dev.log("Error creating master wallet: $e");
    }
  }

  void increment() {
    state?.incrementAccountIndex();
  }

  void decrement() {
    state?.decrementAccountIndex();
  }

  void reset() {
    state = null;
  }

  /// private functions
  Mnemonic _generateNewMnemonic() {
    dev.log("generating new mnemonic...");
    final mnemonic = bip39.generateMnemonic();
    dev.log("mnemonic generation successful: $mnemonic");
    return mnemonic;
  }

  void _generateMasterHDWallet(Mnemonic mnemonic, Seed seed) {
    final masterHDWallet = MasterHDWallet(
      mnemonic: mnemonic,
      seed: seed,
      accountIndex: 0,
    );

    dev.log("master HD wallet generated successfully: $masterHDWallet");
    state = masterHDWallet;
  }
}

/// Provider for the [MasterHDWalletController]
final masterHDWalletProvider =
    NotifierProvider<MasterHDWalletController, MasterHDWallet?>(() {
  return MasterHDWalletController();
});
