import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wow_game_tools/models/screen.dart';
import 'package:wow_game_tools/providers/navigation_route_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = ref.watch(navigationRouteProvider);
    return Scaffold(
      body: Container(
        // width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(screens.length, (idx) {
            return TextButton(
              onPressed: () {
                BotToast.showText(text: screens[idx].displayName);
                navigateTo(context, ref, screens[idx].route);
              },
              child: Text(
                screens[idx].displayName,
                textAlign: TextAlign.center,
              ),
            );
          }),
        ),
      ),
    );
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('這是一個SnackBar訊息！'),
      action: SnackBarAction(
        label: '撤銷',
        onPressed: () {
          // 撤銷操作
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
