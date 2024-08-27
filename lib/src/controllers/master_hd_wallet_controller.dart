import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:typed_data';
// Import for compute
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hark_wallet/src/models/master_hd_wallet.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:hark_wallet/src/workers/seed_isolate.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefsKeys {
  masterHDWallet,
  etherWalletsList,
}

class MasterHDWalletController extends Notifier<MasterHDWallet?> {
  @override
  MasterHDWallet? build() {
    _loadWallet();
    return null;
  }

  Future<void> _loadWallet() async {
    final wallet = await getLocalStorage();
    state = wallet;
  }

  /// public functions
  Future<void> createNewMasterWallet() async {
    dev.log("creating new master wallet...");
    try {
      // Step 1: Generate a new mnemonic
      final mnemonic = _generateNewMnemonic();

      // Step 2: Generate a seed from the mnemonic
      final seed = await isolateGenerateSeed(mnemonic);
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

  Future<bool> getUserMasterWalletFromMnemonic(Mnemonic mnemonic) async {
    dev.log("creating new master wallet...");
    try {
      // Step 2: Generate a seed from the mnemonic
      final seed = await isolateGenerateSeed(mnemonic);
      if (seed == null) {
        dev.log("Failed to generate seed");
        return false;
      }

      // Step 3: Generate a master HD wallet from the seed & set the state
      _generateMasterHDWallet(mnemonic, seed);
      return true;
    } catch (e) {
      dev.log("Error creating master wallet: $e");
      return false;
    }
  }

  void increment() {
    state?.incrementAccountIndex();
  }

  void decrement() {
    state?.decrementAccountIndex();
  }

  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(PrefsKeys.masterHDWallet.name);
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
    setLocalStorage(masterHDWallet);
    state = masterHDWallet;
  }

  Future<void> setLocalStorage(MasterHDWallet masterHdWallet) async {
    final prefs = await SharedPreferences.getInstance();
    final masterHDWalletJson = jsonEncode(masterHdWallet.toJson());

    await prefs.setString(
        PrefsKeys.masterHDWallet.name, masterHDWalletJson.toString());
  }

  Future<MasterHDWallet?> getLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final masterHDWalletJson = prefs.getString(PrefsKeys.masterHDWallet.name);

    if (masterHDWalletJson == null) {
      dev.log("No master HD wallet found in local storage");
      return null;
    }

    final masterHDWalletMap = jsonDecode(masterHDWalletJson);
    final map = {
      "mnemonic": masterHDWalletMap["mnemonic"],
      "seed": Uint8List.fromList(
          (masterHDWalletMap['seed'] as List<dynamic>).cast<int>()),
      "accountIndex": masterHDWalletMap["accountIndex"],
    };
    final masterHDWallet = MasterHDWallet.fromJson(map);

    return masterHDWallet;
  }
}

/// Provider for the [MasterHDWalletController]
final masterHDWalletProvider =
    NotifierProvider<MasterHDWalletController, MasterHDWallet?>(() {
  return MasterHDWalletController();
});
