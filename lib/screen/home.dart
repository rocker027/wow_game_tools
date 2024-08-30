import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wow_game_tools/models/screen.dart';
import 'package:wow_game_tools/providers/navigation_route_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: List.generate(screens.length, (idx) {
          return buildMenuButton(context, ref, idx);
        }),
      ),
    );
  }

  Widget buildMenuButton(BuildContext context, WidgetRef ref, int index) {
    final screen = screens[index];
    return Container(
      margin: _getMarginWith(index),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: () {
          BotToast.showText(text: screen.displayName);
          navigateTo(context, ref, screen.route);
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            screen.displayName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
          ),
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

  EdgeInsets _getMarginWith(int index) {
    if (index % 2 == 0) {
      // left
      return const EdgeInsets.only(
          left: 16.0, top: 8.0, right: 8.0, bottom: 8.0);
    } else {
      // right
      return const EdgeInsets.only(
          left: 8.0, top: 8.0, right: 16.0, bottom: 8.0);
    }
  }
}
