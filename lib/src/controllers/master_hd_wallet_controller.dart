import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hark_wallet/src/models/master_hd_wallet.dart';
import 'dart:developer' as dev;
import 'package:bip39/bip39.dart' as bip39;

class MasterHDWalletController extends Notifier<MasterHDWallet?> {
  @override
  MasterHDWallet? build() {
    return null;
  }

  /// public functions
   Future<void> createNewMasterWallet() async {
    dev.log("creating new master wallet...");
    /// Step 1: Generate a new mnemonic
    final mnemonic = _generateNewMnemonic();

    /// Step 2: Generate a seed from the mnemonic
    final seed = generateSeed(mnemonic);
    if (seed == null) {
      return;
    }

    /// Step 3: Generate a master HD wallet from the seed & set the state
    _generateMasterHDWallet(mnemonic, seed);
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

  Seed? generateSeed(Mnemonic mnemonic) {
    dev.log("generating seed from mnemonic...");
    dev.log("checking validity of mnemonic...");
    if (!bip39.validateMnemonic(mnemonic)) {
      dev.log("Invalid mnemonic");
      return null;
    }

    final seedBytes = bip39.mnemonicToSeed(mnemonic);
    dev.log("seed generation successful");
   
    return seedBytes;
  }


  /// private functions
  /// _ underscore represents the private function to this file only.
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
