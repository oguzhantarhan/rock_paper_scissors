import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int _playerScore = 0;
  int _cpuScore = 0;
  int _playerChoice = 3;
  int _cpuChoice = 3;
  String _gameResult = "Seçimini yap:";

  static const List<String> _playList = ["rock", "paper", "scissors", ""];
  final _randGen = Random.secure();

  void newGame() {
    setState(() {
      _cpuChoice = 3;
      _playerChoice = 3;
      _cpuScore = 0;
      _playerScore = 0;
      _gameResult = "Seçimini yap:";
    });
  }

  void onTabTapped(int userChoice) {
    setState(() {
      _playerChoice = userChoice;
      _cpuChoice = _randGen.nextInt(3);
      if (_playerChoice == _cpuChoice) {
        setState(() {
          _gameResult = "Berabere";
        });
      } else if ((_playerChoice == 0 && _cpuChoice == 2) ||
          (_playerChoice == 1 && _cpuChoice == 0) ||
          (_playerChoice == 2 && _cpuChoice == 1)) {
        setState(() {
          _gameResult = "Kazandınız";
          ++_playerScore;
        });
      } else {
        setState(() {
          _gameResult = "Kaybettiniz";
          ++_cpuScore;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.blue),
          backgroundColor: Colors.transparent,
          title: const Text("Taş Kağıt Makas"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: newGame,
          child: const Text(
            "Yeni Oyun",
            textAlign: TextAlign.center,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("OYUNCU", style: _textStyle(Colors.red)),
                          SizedBox(width: 175, height: 150, child: _ImageUtility(image: _playList[_playerChoice])),
                          Text("Skor:$_playerScore", style: _textStyle(Colors.red)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("BİLGİSAYAR", style: _textStyle(Colors.green)),
                          SizedBox(
                              width: 175, height: 150, child: _ImageUtility(image: "cpu.${_playList[_cpuChoice]}")),
                          Text(
                            "Skor:$_cpuScore",
                            style: _textStyle(Colors.green),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            Expanded(
                flex: 1,
                child: Text(
                  _gameResult,
                  style: _textStyle(Colors.cyan),
                )),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      onTabTapped(0);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
                    child: _ImageUtility(image: _GameImages().rock),
                  )),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      onTabTapped(1);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
                    child: _ImageUtility(image: _GameImages().paper),
                  )),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        onTabTapped(2);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
                      child: _ImageUtility(image: _GameImages().scissors),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  TextStyle _textStyle(Color color) => TextStyle(color: color, fontSize: 17);
}

class _ImageUtility extends StatelessWidget {
  const _ImageUtility({
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return (image != "") && (image != "cpu.")
        ? Image.asset(
            "assets/images/$image.png",
            fit: BoxFit.cover,
          )
        : const Card(
            child: Text("Seçim bekleniyor"),
          );
  }
}

class _GameImages {
  final String rock = "rock";
  final String paper = "paper";
  final String scissors = "scissors";
  final String cpuRock = "cpu.rock";
  final String cpuPaper = "cpu.paper";
  final String cpuScissors = "cpu.scissors";
}
