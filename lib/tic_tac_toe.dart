import 'dart:io';
import 'dart:math';

class Game {
  List<List<String>> board = [
    [' ', ' ', ' '],
    [' ', ' ', ' '],
    [' ', ' ', ' '],
  ];
  List<String> player=['X','O'];
  late String currentPlayer = player[Random().nextInt(player.length)];
  void start() {
    print('Welcome to Tic-Tac-Toe!\n');

    while (true) {
      printBoard();
      getPlayerMove();

      if (checkWin()) {
        printBoard();
        print('\n🎉🎉 Player $currentPlayer wins! 🎉🎉');
        break;
      }

      if (isDraw()) {
        printBoard();
        print('\nIt\'s a draw!');
        break;
      }

      switchPlayer();
    }
  }

  void printBoard() {
    print('\n   0   1   2');
    for (int i = 0; i < 3; i++) {
      stdout.write('$i ');
      for (int j = 0; j < 3; j++) {
        stdout.write(board[i][j]);
        if (j < 2) stdout.write('  | ');
      }
      print('');
      if (i < 2) print('  ------------');
    }
    print('');
  }

  void getPlayerMove() {
    int row, col;

    while (true) {
      stdout.write('Player $currentPlayer - Enter row (0-2): ');
      row = int.tryParse(stdin.readLineSync() ?? '') ?? -1;
      stdout.write('Enter column (0-2): ');
      col = int.tryParse(stdin.readLineSync() ?? '') ?? -1;

      if (isValidMove(row, col)) {
        board[row][col] = currentPlayer;
        break;
      } else {
        print('Invalid move. Try again.');
      }
    }
  }

  bool isValidMove(int row, int col) {
    return row >= 0 && row < 3 && col >= 0 && col < 3 && board[row][col] == ' ';
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  bool checkWin() {
    for (int i = 0; i < 3; i++) {
      ///  الصفوف والاعمدة
      if ((board[i][0] == currentPlayer &&
          board[i][1] == currentPlayer &&
          board[i][2] == currentPlayer) ||
          (board[0][i] == currentPlayer &&
              board[1][i] == currentPlayer &&
              board[2][i] == currentPlayer)) {
        return true;
      }
    }

    /// الdiagonal
    if ((board[0][0] == currentPlayer &&
        board[1][1] == currentPlayer &&
        board[2][2] == currentPlayer) ||
        (board[0][2] == currentPlayer &&
            board[1][1] == currentPlayer &&
            board[2][0] == currentPlayer)) {
      return true;
    }

    return false;
  }
   /// التعادل
  bool isDraw() {
    for (var row in board) {
      if (row.contains(' ')) return false;
    }
    return true;
  }
}


