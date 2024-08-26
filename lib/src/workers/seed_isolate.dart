// file: src/workers/seed_isolate.dart

import 'dart:typed_data';
import 'package:isolate_manager/isolate_manager.dart';
import 'seed_generator.dart';

@isolateManagerWorker
Uint8List? generateSeedWorker(String mnemonic) {
  return generateSeed(mnemonic);
}

// Create the isolate manager for the seed generation function.
final isolateGenerateSeed = IsolateManager.create(generateSeedWorker, workerName: "generateSeedWorker", concurrent: 2);
