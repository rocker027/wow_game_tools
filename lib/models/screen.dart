import 'package:wow_game_tools/models/AppRoutes.dart';

class Screen {
  final String name;
  final String displayName;
  final String route;

  Screen(this.name, this.displayName, this.route);
}

List<Screen> screens = [
  // Screen('home', '首頁', AppRoute.home),
  Screen('writeBugIssue', '開Bug單', AppRoute.writeBugIssue),
  Screen('bigWin', '計算Big Win', AppRoute.bigWin),

];
