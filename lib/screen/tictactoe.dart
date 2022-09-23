import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Tictactoe extends StatefulWidget {
  final int? number;

  const Tictactoe({this.number});

  @override
  State<Tictactoe> createState() => _TictactoeState();
}

class Player {
  static const empty = '';
  static const X = 'X';
  static const O = 'O';
}

class _TictactoeState extends State<Tictactoe> {
  late final countMatrix = widget.number;

  late List<List<String>> matrix;
  String lastValue = Player.empty;

  @override
  void initState() {
    super.initState();

    setEmptyFields();
  }

  void setEmptyFields() => setState(() => matrix = List.generate(
      countMatrix!, (_) => List.generate(countMatrix!, (_) => Player.empty)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: Utils.modelBuilder(matrix, (x, value) => buildRow(x)),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Exit'))
          ],
        ),
      ),
    );
  }

  Widget buildRow(int x) {
    final values = matrix[x];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Utils.modelBuilder(values, (y, values) => buildField(x, y)),
    );
  }

  Widget buildField(int x, int y) {
    final value = matrix[x][y];

    return Expanded(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 68,
          minWidth: 68,
        ),
        margin: EdgeInsets.all(4.0),
        child: ElevatedButton(
            onPressed: () => selectField(value, x, y),
            child: AutoSizeText(
              value,
              style: TextStyle(
                color: Colors.white,
              ),
              minFontSize: 16,
            ),
            style: ElevatedButton.styleFrom(primary: Colors.black)),
      ),
    );
  }

  void selectField(String value, int x, int y) {
    if (value == Player.empty) {
      final newValue = lastValue == Player.X ? Player.O : Player.X;

      setState(() {
        lastValue = newValue;
        matrix[x][y] = newValue;
      });

      if (isWinner(x, y)) {
        showEndDialog('Player $newValue Won');
      } else if (isEnd()) {
        showEndDialog('Undecided Game');
      }
    }
  }

  bool isWinner(int x, int y) {
    var col = 0, row = 0, diag = 0, rdiag = 0;
    final player = matrix[x][y];
    final n = countMatrix!;

    for (int i = 0; i < n; i++) {
      if (matrix[x][i] == player) col++;
      if (matrix[i][y] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i - 1] == player) rdiag++;
    }

    return row == n || col == n || diag == n || rdiag == n;
  }

  bool isEnd() =>
      matrix.every((values) => values.every((value) => value != Player.empty));

  Future showEndDialog(String title) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text('Press to Restart the Game'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    setEmptyFields();
                    Navigator.of(context).pop();
                  },
                  child: Text('Restart'))
            ],
          ));
}

class Utils {
  static List<Widget> modelBuilder<M>(
          List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();
}
