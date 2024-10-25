import 'package:flutter/material.dart';
import 'package:tic_tac_toe/constants/colors.dart';
import 'package:tic_tac_toe/widgets/tictactoe.dart';

void main() {
  runApp(const MyApp());
}

final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const TicTacToe(),
      scaffoldMessengerKey: _scaffoldKey,
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  bool isCross = false;
  String gameWinner = '';
  List<String> gameState = List.filled(9, 'empty');

  void resetState() {
    setState(() {
      isCross = false;
      gameWinner = '';
      gameState = List.filled(9, 'empty');
    });
  }

  void _makeMove(int index) {
    if (gameWinner != '') {
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text(
            "Game is already over! Please start a new game.",
            style: TextStyle(
              color: MyColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: MyColors.warning,
        ),
      );
    } else if (gameState[index] == 'empty') {
      setState(() {
        gameState[index] = isCross ? 'cross' : 'circle';
        isCross = !isCross;
      });
    } else {
      _scaffoldKey.currentState!.showSnackBar(
        const SnackBar(
          content: Text(
            "Cell is already filled!",
            style: TextStyle(
              color: MyColors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: MyColors.warning,
          duration: Durations.medium3,
        ),
      );
    }
    checkWinner();
  }

  void checkWinner() {
    if (gameState[0] == gameState[1] &&
        gameState[0] == gameState[2] &&
        gameState[0] != 'empty') {
      gameWinner = '${gameState[0]} won the game! 🥳';
    } else if (gameState[3] != 'empty' &&
        gameState[3] == gameState[4] &&
        gameState[4] == gameState[5]) {
      gameWinner = '${gameState[3]} won the game! 🥳';
    } else if (gameState[6] != 'empty' &&
        gameState[6] == gameState[7] &&
        gameState[7] == gameState[8]) {
      gameWinner = '${gameState[6]} won the game! 🥳';
    } else if (gameState[0] != 'empty' &&
        gameState[0] == gameState[3] &&
        gameState[3] == gameState[6]) {
      '${gameState[0]} won the game! 🥳';
    } else if (gameState[1] != 'empty' &&
        gameState[1] == gameState[4] &&
        gameState[4] == gameState[7]) {
      gameWinner = '${gameState[1]} won the game! 🥳';
    } else if (gameState[2] != 'empty' &&
        gameState[2] == gameState[5] &&
        gameState[5] == gameState[8]) {
      gameWinner = '${gameState[2]} won the game! 🥳';
    } else if (gameState[0] != 'empty' &&
        gameState[0] == gameState[4] &&
        gameState[4] == gameState[8]) {
      gameWinner = '${gameState[0]} won the game! 🥳';
    } else if (gameState[2] != 'empty' &&
        gameState[2] == gameState[4] &&
        gameState[4] == gameState[6]) {
      gameWinner = '${gameState[2]} won the game! 🥳';
    } else if (!gameState.contains('empty')) {
      gameWinner = 'Draw game... ⌛️';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tic Tac Toe",
            style: TicTacToeStyle.appBarTxt,
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Card(
                color: gameWinner.isNotEmpty
                    ? MyColors.success
                    : isCross
                        ? MyColors.success
                        : MyColors.orange,
                child: ListTile(
                  title: Center(
                    child: Text(
                      gameWinner.isNotEmpty
                          ? '${gameWinner[0].toUpperCase()}${gameWinner.substring(1)}'
                          : isCross
                              ? 'X\'s Turn'
                              : 'O\'s Turn',
                      style: TicTacToeStyle.playerTxt,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => _makeMove(index),
                    child: TicTacToeCell(
                      iconName: gameState[index],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: TicTacToeStyle.bntStyle,
                onPressed: resetState,
                child: Text(
                  gameWinner == '' ? "Reload Game" : "New Game",
                  style: TicTacToeStyle.btnText,
                ),
              ),
            )
          ],
        ));
  }
}

class TicTacToeStyle {
  static final bntStyle = ButtonStyle(
    backgroundColor: const WidgetStatePropertyAll(MyColors.buttonColor),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    fixedSize: const WidgetStatePropertyAll(Size(350, 50)),
  );
  static const btnText = TextStyle(
    color: MyColors.white,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  static const playerTxt = TextStyle(
    color: MyColors.white,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const appBarTxt = TextStyle(
    color: MyColors.white,
    fontWeight: FontWeight.bold,
  );
}
