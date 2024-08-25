import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hark_wallet/src/controllers/master_hd_wallet_controller.dart';

class EthTextFieldWidget extends ConsumerStatefulWidget {
  const EthTextFieldWidget({super.key});

  @override
  ConsumerState<EthTextFieldWidget> createState() => _EthTextFieldWidgetState();
}

class _EthTextFieldWidgetState extends ConsumerState<EthTextFieldWidget> {
  bool _isCreatingWallet = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        left: size.width * 0.1,
        right: size.width * 0.1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Text(
            "Create Ethereum Wallets",
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "Keep the recovery phrase safe. It is the only way to recover your wallet. Never share it with anyone.",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.white54),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: TextField(
                  cursorColor: Colors.white,
                  obscureText: true,
                  autocorrect: false,
                  autofillHints: null,
                  enableSuggestions: false,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    hintText:
                        'Enter your seed phrase (or leave blank to generate)',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white54),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      disabledBackgroundColor: Colors.white54,
                    ),
                    onPressed: _isCreatingWallet
                        ? null
                        : () async {
                            setState(() {
                              _isCreatingWallet = true;
                            });

                            await ref
                                .read(masterHDWalletProvider.notifier)
                                .createNewMasterWallet();

                            setState(() {
                              _isCreatingWallet = false;
                            });
                          },
                    child: _isCreatingWallet
                        ? CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          )
                        : Text('Generate Wallet',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.black)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
