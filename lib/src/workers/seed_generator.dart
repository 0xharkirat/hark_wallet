

// This is a pure Dart function, no Flutter dependencies.
import 'dart:typed_data';
import 'package:bip39/bip39.dart' as bip39;

Uint8List? generateSeed(String mnemonic) {
  if (!bip39.validateMnemonic(mnemonic)) {
    return null;
  }
  return bip39.mnemonicToSeed(mnemonic);
}