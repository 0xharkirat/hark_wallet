import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hark_wallet/src/controllers/master_hd_wallet_controller.dart';
import 'package:hark_wallet/src/core/helpers/create_snack_bar.dart';

class WalletListWidget extends ConsumerStatefulWidget {
  const WalletListWidget({
    super.key,
  });

  @override
  ConsumerState<WalletListWidget> createState() => _WalletListWidgetState();
}

class _WalletListWidgetState extends ConsumerState<WalletListWidget> {
  bool _showMnemonic = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mnemomnicList =
        ref.watch(masterHDWalletProvider)?.mnemonic.split(" ");
    return Padding(
      padding: EdgeInsets.only(
          left: size.width * 0.1, right: size.width * 0.1, top: 40),
      child: Column(
        children: [
          SeedPhrase(context, mnemomnicList),
        ],
      ),
    );
  }

  Container SeedPhrase(BuildContext context, List<String>? mnemomnicList) {
    return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white24, width: 0.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                enableFeedback: false,
                contentPadding: const EdgeInsets.all(0),
                textColor: Colors.white,
                iconColor: Colors.white,
                title: Text(
                  "Your Recovery Phrase",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                onTap: (){
                  
        
                },
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_drop_down),
                  onPressed: () {
                    
                  },
                ),
                mouseCursor: SystemMouseCursors.click,
        
                // subtitle: Text(masterHdWallet.mnemonic),
              ),
              if (_showMnemonic) ...[
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
                          final mnemonic =
                              ref.read(masterHDWalletProvider)?.mnemonic;
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
                TextButton.icon(
                    onPressed: () {
                      final mnemonic = ref.read(masterHDWalletProvider)?.mnemonic;
                      if (mnemonic != null) {
                        _copyToClipboard(mnemonic, context);
                      }
                    },
                    label: const Text('Copy All'),
                    icon: const Icon(Icons.copy_all)),
              ]
            ],
          ),
        );
  }

  Future<void> _copyToClipboard(String text, BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        createSnackBar(
          "Copied to Clipboard",
        ),
      );
    }
  }
}
