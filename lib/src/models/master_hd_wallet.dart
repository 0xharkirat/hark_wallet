import 'package:flutter/foundation.dart';

class MasterHDWallet {
  final Mnemonic mnemonic;
  final Seed seed;
  int accountIndex;

  MasterHDWallet({
    required this.mnemonic,
    required this.seed,
    required this.accountIndex,
  });

  void incrementAccountIndex() {
    accountIndex++;
  }

  void decrementAccountIndex() {
    accountIndex--;
  }

  factory MasterHDWallet.fromJson(Map<String, dynamic> json) {
    return MasterHDWallet(
      mnemonic: json['mnemonic'],
      seed: json['seed'],
      accountIndex: json['accountIndex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mnemonic': mnemonic,
      'seed': seed,
      'accountIndex': accountIndex,
    };
  }

 

  @override
  String toString() {
    return 'MasterHDWallet{mnemonic: $mnemonic, accountIndex: $accountIndex}';
  }
}

typedef Mnemonic = String;
typedef Seed = Uint8List;
