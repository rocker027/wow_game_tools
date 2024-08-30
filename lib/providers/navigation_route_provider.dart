import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wow_game_tools/models/AppRoutes.dart';

final navigationRouteProvider = StateProvider<String>((ref) {
  return AppRoute.home;
});

void navigateTo(BuildContext context, WidgetRef ref, String newRoute) {
  ref.read(navigationRouteProvider.notifier).state = newRoute;
  switch (newRoute) {
    case AppRoute.home:
      navigateToHome(context);
      break;
    case AppRoute.writeBugIssue:
      navigateToWriteBugIssue(context);
      break;
    case AppRoute.bigWin:
      navigateToBigWin(context);
      break;
  }
}

void navigateToHome(BuildContext context) {
  Navigator.pushNamed(context, AppRoute.home);
}

void navigateToWriteBugIssue(BuildContext context) {
  Navigator.pushNamed(context, AppRoute.writeBugIssue);
}

void navigateToBigWin(BuildContext context) {
  Navigator.pushNamed(context, AppRoute.bigWin);
}
