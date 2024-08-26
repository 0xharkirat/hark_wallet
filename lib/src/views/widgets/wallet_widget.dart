import 'package:flutter/material.dart';
import 'package:hark_wallet/src/core/constants/obscure_text.dart';
import 'package:pixelarticons/pixel.dart';

class WalletWidget extends StatefulWidget {
  const WalletWidget({
    super.key,
    required this.publicKey,
    required this.privateKey,
    required this.index,
  });
  final String publicKey;
  final String privateKey;
  final int index;

  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> {
  bool _showPrivateKey = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24, width: 0.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text.rich(
              TextSpan(
                text: "Wallet ${widget.index + 1}",
              ),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.white10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    "Public Key",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  subtitle: Text(
                    widget.publicKey,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ListTile(
                  title: Text(
                    "Private Key",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  subtitle: Text(
                    _showPrivateKey
                        ? widget.privateKey
                        : kPrivateKeyObscureText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  trailing: IconButton(
                    icon: Icon(!_showPrivateKey ? Pixel.eye : Pixel.eyeclosed),
                    onPressed: () {
                      setState(() {
                        _showPrivateKey = !_showPrivateKey;
                      });
                    },
                  ),
                ),
              ],
            ),

            // subtitle: Text(masterHdWallet.mnemonic),
          ),
        ],
      ),
    );
  }
}
