import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hark_wallet/src/views/screens/eth_screen.dart';

enum AppRoutes {
  home,
  eth,
  sol,
}

const appRoutes = {
  AppRoutes.home: '/',
  AppRoutes.eth: '/eth',
  AppRoutes.sol: '/sol',
};

final appRouter = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: appRoutes[AppRoutes.eth]!,
    routes: [
    GoRoute(
        name: AppRoutes.eth.name,
        path: appRoutes[AppRoutes.eth]!,
        builder: (context, state) => const EthScreen()),
  ]);
});
