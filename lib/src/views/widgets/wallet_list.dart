import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hark_wallet/src/controllers/ether_wallet_controller.dart';

import 'package:hark_wallet/src/views/widgets/seed_phrase_grid.dart';
import 'package:pixelarticons/pixel.dart';
import 'package:url_launcher/url_launcher.dart';

import 'wallet_list_heading.dart';
import 'wallet_widget.dart';

class WalletList extends ConsumerStatefulWidget {
  const WalletList({
    super.key,
  });

  @override
  ConsumerState<WalletList> createState() => _WalletListState();
}

class _WalletListState extends ConsumerState<WalletList> {
  bool _showMnemonic = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.1,
              right: size.width * 0.1,
              top: 40,
              bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
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
                      onTap: () {
                        setState(() {
                          _showMnemonic = !_showMnemonic;
                        });
                      },
                      trailing: IconButton(
                        icon: const Icon(Pixel.arrowdown),
                        onPressed: () {
                          setState(() {
                            _showMnemonic = !_showMnemonic;
                          });
                        },
                      ),
                      mouseCursor: SystemMouseCursors.click,

                      // subtitle: Text(masterHdWallet.mnemonic),
                    ),
                    if (_showMnemonic) const SeedPhraseGrid(),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const WalletListHeading(),
              const SizedBox(
                height: 16,
              ),
              Consumer(builder: (context, ref, child) {
                final wallets = ref.watch(etherWalletController);
                return ListView.separated(
                  shrinkWrap:
                      true, // Makes ListView take only the space it needs
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                  itemCount: wallets.length,
                  itemBuilder: (context, index) {
                    final wallet = wallets[index];
                    return WalletWidget(
                      index: wallet.id,
                      publicKey: wallet.publicKey,
                      privateKey: wallet.privateKey,
                    );
                  },
                );
              }),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.white24,
              ),
              const SizedBox(
                height: 20,
              ),
              Text.rich(
                TextSpan(
                  text: "Made With Flutter. Design inspired from ",
                  children: [
                    TextSpan(
                      style: const TextStyle(
                        color: Colors.white54,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          const url = 'https://wallet-kosh.vercel.app/';
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url),
                                webOnlyWindowName: '_blank');
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      text: "Keshav Bagaade's web app",
                    ),
                  ],
                ),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
