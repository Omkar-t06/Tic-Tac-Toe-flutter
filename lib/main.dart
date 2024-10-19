import 'package:flutter/material.dart';

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
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.red,
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
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.red,
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
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Card(
                  child: ListTile(
                title: Center(
                  child: Text(
                    gameWinner.isNotEmpty
                        ? '${gameWinner[0].toUpperCase()}${gameWinner.substring(1)}'
                        : isCross
                            ? 'X\'s Turn'
                            : 'O\'s Turn',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )),
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
                style: ButtonStyle(
                  backgroundColor: const WidgetStatePropertyAll(Colors.blue),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  fixedSize: const WidgetStatePropertyAll(
                    Size(350, 50),
                  ),
                ),
                onPressed: resetState,
                child: Text(
                  gameWinner == '' ? "Reload Game" : "New Game",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class TicTacToeCell extends StatelessWidget {
  const TicTacToeCell({super.key, required this.iconName});
  final String iconName;

  @override
  Widget build(BuildContext context) {
    Icon icon;
    switch (iconName) {
      case 'cross':
        icon = const Icon(
          Icons.close_rounded,
          size: 38,
          color: Color(0xFF38CC77),
        );
      case 'circle':
        icon = const Icon(
          Icons.circle_outlined,
          size: 38,
          color: Color(0xFFF7CD2E),
        );
      default:
        icon = const Icon(
          Icons.edit,
          size: 38,
          color: Color(0xFF333945),
        );
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
