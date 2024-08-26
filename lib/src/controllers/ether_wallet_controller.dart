import 'dart:developer' as dev;
import 'dart:isolate';

import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hark_wallet/src/controllers/master_hd_wallet_controller.dart';
import 'package:hark_wallet/src/models/ether_wallet.dart';
import 'package:hark_wallet/src/models/master_hd_wallet.dart';

import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class EtherWalletController extends Notifier<List<EtherWallet>> {
  @override
  List<EtherWallet> build() {
    return [];
  }

  Future<void> generateWalletFromSeed() async {
    MasterHDWallet? masterHDWallet = ref.read(masterHDWalletProvider);

    if (masterHDWallet == null) {
      dev.log("Master HD Wallet is null, creating a new one...");
      await ref.read(masterHDWalletProvider.notifier).createNewMasterWallet();

      // Fetch the updated masterHDWallet after creation
      masterHDWallet = ref.read(masterHDWalletProvider);
      if (masterHDWallet == null) {
        dev.log("Failed to create Master HD Wallet");
        return;
      }
    }

    final wallets = await _generateWalletFromSeed(masterHDWallet);


    
    state = [...state, ...wallets];
    ref.read(masterHDWalletProvider.notifier).increment();
  }

  Future<List<EtherWallet>> _generateWalletFromSeed(
      MasterHDWallet masterHDWallet) async {
    final accountIndex = masterHDWallet.accountIndex;
    final mnemonic = masterHDWallet.mnemonic;
    final seed = masterHDWallet.seed;

    final path = "m/44'/60'/0'/$accountIndex'";
    final hdKey = await ED25519_HD_KEY.derivePath(path, seed);

    final privateKey = bytesToHex(hdKey.key);
    final publicKey = _getPublicKey(privateKey);

    final wallet = EtherWallet(
      id: accountIndex,
      privateKey: privateKey,
      publicKey: publicKey,
      path: path,
      mnemonic: mnemonic,
    );
    dev.log("Wallet no. $accountIndex generated: $wallet");

    return [wallet];
  }

  /// _ underscore represents the private function to this file only.
  String _getPublicKey(String privateKey) {
    final privateKeyObject = EthPrivateKey.fromHex(
        privateKey); // Create a private key object from the provided private key string
    final address = privateKeyObject
        .address.hexEip55; // Get the address from the private key object
    dev.log("public key address: $address");

    return address;

    // var privateKey = EthPrivateKey.fromHex("0x");
    // var publicKey = privateKey.publicKey;
    // dev.log("public key: $publicKey");
  }
}

final etherWalletController =
    NotifierProvider<EtherWalletController, List<EtherWallet>>(() {
  return EtherWalletController();
});
