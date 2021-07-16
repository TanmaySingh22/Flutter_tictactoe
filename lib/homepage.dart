import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  var myTextStyle = TextStyle(color: Colors.white, fontSize: 30);
  int xScore = 0;
  int oScore = 0;
  int filledBoxes = 0;
  bool isWinner = false;
  static var myNewFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 3)
  );
  static var myNewFontWhite = GoogleFonts.pressStart2p(
      textStyle: (TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15))
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(children: [
        SizedBox(height: 15,),
        Expanded(flex: 1,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Player X',
                            style: myNewFontWhite,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            xScore.toString(),
                            style: myNewFontWhite,
                          )
                        ]),
                  ),
                  SizedBox(width: 2,height: 60, child:Center(child: Container(color: Colors.grey[300],)) ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Player O',
                            style: myNewFontWhite,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            oScore.toString(),
                            style: myNewFontWhite,
                          )
                        ]),
                  )
                ],
              ),
            )),
        Expanded(
          flex: 4,
          child: GridView.builder(
              itemCount: 9,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[700])),
                    child: Center(
                      child: Text(
                        displayXO[index],
                        style: myNewFontWhite.copyWith(fontSize: 40)
                      ),
                    ),
                  ),
                );
              }),
        ),
        Expanded(flex: 2,child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                _clearBoard();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(6),
                ///color: Colors.white,
                child: Text('RESET', style: myNewFont,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('Tic Tac Toe', style: myNewFontWhite,),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text('@CREATEDBYTANMAYA', style: myNewFontWhite.copyWith(fontSize: 12),),
            )
          ],
        ))
      ]),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn == true && displayXO[index] == '') {
        displayXO[index] = 'O';
        filledBoxes++;
        oTurn = !oTurn;
      } else if (!oTurn && displayXO[index] == '') {
        displayXO[index] = 'X';
        filledBoxes++;
        oTurn = !oTurn;
      }
      ///oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
        isWinner = true;
      _showWinDialog(displayXO[0]);
    }
    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
       isWinner = true;
      _showWinDialog(displayXO[3]);
    }
    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
       isWinner = true;
      _showWinDialog(displayXO[6]);
    }
    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
       isWinner = true;
      _showWinDialog(displayXO[0]);
    }
    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
       isWinner = true;
      _showWinDialog(displayXO[1]);
    }
    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
       isWinner = true;
      _showWinDialog(displayXO[2]);
    }
    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
       isWinner = true;
      _showWinDialog(displayXO[0]);
    }
    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
       isWinner = true;
      _showWinDialog(displayXO[2]);
    }else if( filledBoxes == 9 && isWinner == false){
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("It's a DRAW!"),
            actions: [
              TextButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text('Play Again'))
            ],
          );
        });

  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Winner is $winner!', ),
            actions: [
              TextButton(
                  onPressed: () {
                    isWinner = false;
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text('Play Again'))
            ],
          );
        });
    if (winner == 'O') {
      oScore++;
    } else if (winner == 'X') {
      xScore++;
    }
  }

  _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
    });
    filledBoxes = 0;
  }
}