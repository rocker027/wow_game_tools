import '../screen/calculate_big_win.dart';
import '../screen/home.dart';
import '../screen/write_bug_issue.dart';

class AppRoute {
  static const String home = '/';
  static const String bigWin = '/big-win';
  static const String writeBugIssue = '/write-bug-issue';

  static final routes = {
    home: (context) => const HomeScreen(),
    bigWin: (context) => const BigWinScreen(),
    writeBugIssue: (context) => const WriteBugIssueScreen(),
  };
}
