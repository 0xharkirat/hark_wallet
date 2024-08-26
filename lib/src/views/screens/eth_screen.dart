import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hark_wallet/src/controllers/master_hd_wallet_controller.dart';
import 'package:hark_wallet/src/controllers/theme_controller.dart';
import 'package:hark_wallet/src/views/widgets/eth_text_field_widget.dart';
import 'package:hark_wallet/src/views/widgets/wallet_list.dart';
import 'package:pixelarticons/pixel.dart';

class EthScreen extends ConsumerWidget {
  const EthScreen({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    // final etherWalletList = ref.watch(etherWalletController);
    final themeBool = ref.watch(themeController);
    final size = MediaQuery.of(context).size;

    // log("etherWalletList: $etherWalletList");
    return Scaffold(
      
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 76,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.only(
            left: size.width * 0.1,
            top: 40,
          ),
          child: InkWell(
            onTap: () {},
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Pixel.wallet,
                  size: 36,
                ),
                Text(
                  "Hark",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 36),
                ),
              ],
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: size.width * 0.1,
              top: 40,
            ),
            child: Row(
              children: [
                Icon(
                  Pixel.sun,
                  color: themeBool ? Colors.white54 : Colors.white,
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                      mouseCursor: SystemMouseCursors.click,
                      // activeColor: Colors.white,
                      activeTrackColor: Colors.white,
                      activeColor: Colors.white,
                      thumbColor: WidgetStateProperty.all(
                          themeBool ? Colors.black : Colors.white),
                      value: themeBool,
                      onChanged: (value) {
                        ref.read(themeController.notifier).toggleTheme(value);
                      }),
                ),
                Icon(
                  Pixel.moon,
                  color: !themeBool ? Colors.white54 : Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final masterHdWallet = ref.watch(masterHDWalletProvider);
          return masterHdWallet == null
              ? const EthTextFieldWidget()
              : const WalletList();
        },
      ),
    );
  }
}
