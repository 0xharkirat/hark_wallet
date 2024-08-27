import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hark_wallet/src/controllers/master_hd_wallet_controller.dart';
import 'package:hark_wallet/src/core/helpers/create_snack_bar.dart';
import 'package:pixelarticons/pixel.dart';

class SeedPhraseGrid extends ConsumerWidget {
  const SeedPhraseGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mnemomnicList =
        ref.watch(masterHDWalletProvider)?.mnemonic.split(" ");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 200,
          child: GridView.builder(
            padding: const EdgeInsets.only(top: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Number of columns
              crossAxisSpacing: 6, // Spacing between columns
              mainAxisSpacing: 6, // Spacing between rows
              childAspectRatio: 5, // Aspect ratio of each card
            ),
            itemCount: 12, // Total number of items (4 columns * 3 rows)
            itemBuilder: (context, index) {
              final word = mnemomnicList?[index];
              return ListTile(
                tileColor: Colors.white10,
                hoverColor: Colors.white24,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                mouseCursor: SystemMouseCursors.click,
                onTap: () {
                  final mnemonic = ref.read(masterHDWalletProvider)?.mnemonic;
                  if (mnemonic != null) {
                    _copyToClipboard(mnemonic, context);
                  }
                },
                leading: Text(
                  '${index + 1}. $word',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        ListTile(
          tileColor: Colors.transparent,
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
         
          onTap: () {
            final mnemonic = ref.read(masterHDWalletProvider)?.mnemonic;
            if (mnemonic != null) {
              _copyToClipboard(mnemonic, context);
            }
          },
          title: const Text('Copy All', textAlign: TextAlign.left,),
          leading: const Icon(Icons.copy_all),
        ),
      ],
    );
  }

  Future<void> _copyToClipboard(String text, BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        createSnackBar(
          "Recovery Phrase copied to clipboard", Pixel.check, false
        ),
      );
    }
  }
}
