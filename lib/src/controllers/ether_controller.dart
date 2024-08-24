import 'dart:math';
import 'dart:developer' as dev;

import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;

class EtherController {
  void createWallet() {
    var rng = Random.secure();
    EthPrivateKey priKey = EthPrivateKey.createRandom(rng);
    final privateKey = bytesToHex(priKey.privateKey);
    dev.log("public key: ${priKey.publicKey}");
    dev.log("address: ${priKey.address}");
    dev.log("address hex: ${priKey.address.hex}");
    dev.log('address hexeip55: ${priKey.address.hexEip55}');
    dev.log("private key hex: $privateKey");
    dev.log("private key: ${priKey.privateKey}");
    dev.log("private key int: ${priKey.privateKeyInt}");
  }

  Future<void> generateMnemonic() async {
    // var mnemonic = bip39.generateMnemonic();
    // var mnemonicArray = mnemonic.split(" ");
    // dev.log("--generateMnemonic--");
    // dev.log("mnemonic: $mnemonic");
    // dev.log("mnemonic array: $mnemonicArray");
    // dev.log('mnemominc joined as a string: ${mnemonicArray.join(" ")}');
    // dev.log("--end generateMnemonic--");
    await generateSeed("seed sock milk update focus rotate barely fade car face mechanic mercy");
  }

  Future<void> generateSeed(String mnemonic) async {
    if (!bip39.validateMnemonic(mnemonic)) {
      dev.log("Invalid mnemonic");
      return;
    }

    // var seed = bip39.mnemonicToSeedHex(mnemonic);
    var seedBytes = bip39.mnemonicToSeed(mnemonic);
    dev.log("--generateSeed--");
    dev.log("seed: $seedBytes");
    await generateWallets(seedBytes);
  }

  Future<void> generateWallets(Uint8List seed) async {
    dev.log("--generateWallets--");
    var withoutPath = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
    final withoutPathHex = bytesToHex(withoutPath.key);
    dev.log("private key without path: $withoutPathHex");
    getPublicKey(withoutPathHex);



    for (int i = 0; i < 4; i++) {
      /// Path 1 (m/44'/60'/$i'/0'): The derivation first varies the account ($i'), then selects the external address.
      /// Path 1 might be more suitable if you manage multiple accounts (e.g., for different users or purposes) and need external addresses within each account.
      /// 
      /// Path 2 (m/44'/60'/0'/$i'): The derivation first selects the external address under a fixed account, then varies the key or address index ($i').
      /// Path 2 is more appropriate if you have a single account and just need to generate multiple addresses or keys.
      final path = "m/44'/60'/0'/$i'"; // Path 2
      var hdKey = await ED25519_HD_KEY.derivePath(path, seed);
      
      final privateKey = bytesToHex(hdKey.key);
      dev.log("--wallet $i--");
      // dev.log("private key: ${hdKey.key}");
      dev.log("private key hex: $privateKey");
      getPublicKey(privateKey);
      dev.log("--end wallet $i--");

    }
  }

  void getPublicKey(String privateKey) {  
    final privateKeyObject = EthPrivateKey.fromHex(privateKey); // Create a private key object from the provided private key string
    final address =  privateKeyObject.address.hexEip55; // Get the address from the private key object
    dev.log("public key address: $address");


    // var privateKey = EthPrivateKey.fromHex("0x");
    // var publicKey = privateKey.publicKey;
    // dev.log("public key: $publicKey");
  }
}

final etherController = Provider<EtherController>((ref) {
  return EtherController();
});
