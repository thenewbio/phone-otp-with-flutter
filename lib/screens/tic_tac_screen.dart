import 'package:flutter/material.dart';

enum Player { x, o }

class TicTacToe extends StatefulWidget {
  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<Player?> _gameBoard = List.generate(9, (index) => null);
  Player _currentPlayer = Player.x;
  int moveCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                "Moves: $moveCount",
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            _buildGameBoard(),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Reset Game'),
              onPressed: _resetGame,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameBoard() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _handleGameBoardTap(index),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  right: _shouldShowRightBorder(index)
                      ? const BorderSide(color: Colors.black, width: 2)
                      : BorderSide.none,
                  bottom: _shouldShowBottomBorder(index)
                      ? const BorderSide(color: Colors.black, width: 2)
                      : BorderSide.none,
                ),
              ),
              child: Center(
                child: _getPlayerIcon(_gameBoard[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _getPlayerIcon(Player? player) {
    if (player == Player.x) {
      return const Icon(
        Icons.close,
        color: Colors.black,
        size: 50,
      );
    } else if (player == Player.o) {
      return const Icon(
        Icons.radio_button_unchecked,
        color: Colors.black,
        size: 50,
      );
    } else {
      return const SizedBox();
    }
  }

  bool _shouldShowBottomBorder(int index) {
    if (index >= 6) {
      return false;
    }
    return true;
  }

  void _showWinnerDialog(Player winner) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: moveCount == 9 ? const Text('Game Over') : const Text("Winner!"),
        content: SizedBox(
          height: 250,
          child: Column(
            children: [
              Text(
                moveCount == 9
                    ? "${winner.toString()} loss!"
                    : "${winner.toString()} wins!",
                style: const TextStyle(fontSize: 25, color: Colors.purple),
              ),
              moveCount == 9
                  ? Image.asset(
                      'assets/cry.gif',
                    )
                  : Image.asset(
                      'assets/happy.gif',
                    )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _resetGame();
              Navigator.of(context).pop();
            },
            child: moveCount == 9
                ? const Text("Try Again")
                : const Text("Play Again"),
          ),
        ],
      ),
    );
  }

  void _resetGame() {
    setState(() {
      _gameBoard = List.filled(9, null);
      _currentPlayer = Player.x;
      moveCount = 0;
    });
  }

  void _handleGameBoardTap(int index) {
    if (_gameBoard[index] == null) {
      setState(() {
        _gameBoard[index] = _currentPlayer;
        moveCount++;

        if (_checkForWinner()) {
          _showWinnerDialog(_currentPlayer);
          moveCount = 0;
        } else {
          _currentPlayer = _currentPlayer == Player.x ? Player.o : Player.x;
        }
        if (moveCount == 9) {
          _showWinnerDialog(_currentPlayer);
        }
      });
    }
  }

  bool _checkForWinner() {
    // Check rows
    for (int i = 0; i <= 6; i += 3) {
      if (_gameBoard[i] != null &&
          _gameBoard[i] == _gameBoard[i + 1] &&
          _gameBoard[i] == _gameBoard[i + 2]) {
        return true;
      }
    }

    // Check columns
    for (int i = 0; i <= 2; i++) {
      if (_gameBoard[i] != null &&
          _gameBoard[i] == _gameBoard[i + 3] &&
          _gameBoard[i] == _gameBoard[i + 6]) {
        return true;
      }
    }

    // Check diagonals
    if (_gameBoard[0] != null &&
        _gameBoard[0] == _gameBoard[4] &&
        _gameBoard[0] == _gameBoard[8]) {
      return true;
    }

    if (_gameBoard[2] != null &&
        _gameBoard[2] == _gameBoard[4] &&
        _gameBoard[2] == _gameBoard[6]) {
      return true;
    }

    return false;
  }

  bool _shouldShowRightBorder(int index) {
    if ((index + 1) % 3 == 0) {
      return false;
    }
    return true;
  }
}
