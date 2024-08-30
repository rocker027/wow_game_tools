import 'package:wow_game_tools/models/AppRoutes.dart';

class Screen {
  final String name;
  final String displayName;
  final String route;

  Screen(this.name, this.displayName, this.route);
}

List<Screen> screens = [
  Screen('home', '首頁', AppRoute.home),
  Screen('bigWin', '計算BigWin', AppRoute.bigWin),
  Screen('writeBugIssue', '開Bug單', AppRoute.writeBugIssue),
];
