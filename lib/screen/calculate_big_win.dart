import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wow_game_tools/widget/title_text_view.dart';

class BigWinScreen extends ConsumerWidget {
  const BigWinScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bigWin = ref.watch(_bigWinProvider);
    return Scaffold(
      appBar: AppBar(
        title: buildTitleTextView('計算Big Win'),
      ),
      body: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      final betAmount = double.parse(value);
                      updateBetAmount(betAmount, ref);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '請輸入投注金額',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      final winScore = double.parse(value);
                      updateWinScore(winScore, ref);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '請輸入總贏分',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: buildBigWinPreviewTitleView(),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: buildBigWinPreviewContentView(1, bigWin),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: buildBigWinPreviewContentView(2, bigWin),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: buildBigWinPreviewContentView(3, bigWin),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: buildBigWinPreviewContentView(4, bigWin),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void updateBetAmount(double betAmount, WidgetRef ref) {
    ref.read(_betAmountProvider.notifier).state = betAmount;
    _calculateBigWin(ref);
  }

  void updateWinScore(double winScore, WidgetRef ref) {
    ref.read(_winScoreProvider.notifier).state = winScore;
    _calculateBigWin(ref);
  }

  void _calculateBigWin(WidgetRef ref) {
    final betAmount = ref.watch(_betAmountProvider);
    final winScore = ref.watch(_winScoreProvider);
    final bigWin = winScore / betAmount;
    print('winScore: $winScore,betAmount: $betAmount,  bigWin: $bigWin');
    ref.read(_bigWinProvider.notifier).state =
        BigWinPreview(betAmount, winScore);
  }
}

final _betAmountProvider = StateProvider<double>((ref) => 0);

final _winScoreProvider = StateProvider<double>((ref) => 0);

final _bigWinProvider =
    StateProvider<BigWinPreview>((ref) => BigWinPreview(0, 0));

Widget buildBigWinPreviewTitleView() {
  return Container(
    child: Row(
      children: [
        buildLabelTextView('Big Win等級'),
        buildLabelTextView('倍率'),
        buildLabelTextView('總賠付要多少'),
        buildLabelTextView('是否符合'),
      ],
    ),
  );
}

Widget buildBigWinPreviewContentView(int level, BigWinPreview bigWin) {
  return Container(
    child: Row(
      children: [
        buildLabelTextView(bigWin._getBigWinLevelWith(level)),
        buildLabelTextView('${bigWin._getLevelOddsWith(level)}x'),
        buildLabelContentView(level),
        buildLabelTextView(bigWin.getIsMatchTextCompose(level),
            backgroundColor: bigWin.getIsMatchColorCompose(level),
            textColor: Colors.white),
      ],
    ),
  );
}

// 'Big Win等級'
Widget buildLabelTextView(String label,
    {Color backgroundColor = Colors.white, Color textColor = Colors.blue}) {
  return Expanded(
    child: Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        color: backgroundColor,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 24,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget buildLabelContentView(int level) {
  return Expanded(
    child: Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final bigWin = ref.watch(_bigWinProvider);
          final isMatch = bigWin._getIsMatchWith(level);
          return Text(
            '${bigWin._getLevelWinScoreWith(level)}',
            style: const TextStyle(
              fontSize: 24,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    ),
  );
}

class BigWinPreview {
  static const double _level1Odds = 8;
  static const double _level2Odds = 15;
  static const double _level3Odds = 30;
  static const double _level4Odds = 50;

  late final double level1WinScore;
  late final double level2WinScore;
  late final double level3WinScore;
  late final double level4WinScore;

  late final bool level1IsMatch;
  late final bool level2IsMatch;
  late final bool level3IsMatch;
  late final bool level4IsMatch;

  BigWinPreview(double betAmount, double winScore) {
    level1WinScore = betAmount * _level1Odds;
    level2WinScore = betAmount * _level2Odds;
    level3WinScore = betAmount * _level3Odds;
    level4WinScore = betAmount * _level4Odds;
    level1IsMatch = winScore >= level1WinScore;
    level2IsMatch = winScore >= level2WinScore;
    level3IsMatch = winScore >= level3WinScore;
    level4IsMatch = winScore >= level4WinScore;
  }

  String getIsMatchTextCompose(int level) {
    return _getIsMatchText(_getIsMatchWith(level));
  }

  Color getIsMatchColorCompose(int level) {
    return _getIsMatchColor(_getIsMatchWith(level));
  }

  String _getIsMatchText(bool isMatch) {
    return isMatch ? '符合' : '不符合';
  }

  Color _getIsMatchColor(bool isMatch) {
    return isMatch ? Colors.green : Colors.red;
  }

  bool _getIsMatchWith(int level) {
    switch (level) {
      case 1:
        return level1IsMatch;
      case 2:
        return level2IsMatch;
      case 3:
        return level3IsMatch;
      case 4:
        return level4IsMatch;
      default:
        return false;
    }
  }

  double _getLevelWinScoreWith(int level) {
    switch (level) {
      case 1:
        return level1WinScore;
      case 2:
        return level2WinScore;
      case 3:
        return level3WinScore;
      case 4:
        return level4WinScore;
      default:
        return 0;
    }
  }

  double _getLevelOddsWith(int level) {
    switch (level) {
      case 1:
        return _level1Odds;
      case 2:
        return _level2Odds;
      case 3:
        return _level3Odds;
      case 4:
        return _level4Odds;
      default:
        return 0;
    }
  }

  String _getBigWinLevelWith(int level) {
    switch (level) {
      case 1:
        return 'Big Win';
      case 2:
        return 'Mega';
      case 3:
        return 'Super';
      case 4:
        return 'WOW Epic';
      default:
        return '';
    }
  }
}
