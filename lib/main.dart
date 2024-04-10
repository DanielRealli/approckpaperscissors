import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const RockPaperScissorsGame());
}

class RockPaperScissorsGame extends StatefulWidget {
  const RockPaperScissorsGame({Key? key}) : super(key: key);

  @override
  State<RockPaperScissorsGame> createState() => RockPaperScissorsGameState();
}

class RockPaperScissorsGameState extends State<RockPaperScissorsGame> {
  String _imgUserPlayer = "images/indefinido.png";
  String _imgAppPlayer = "images/indefinido.png";

  int _userPoints = 0;
  int _appPoints = 0;
  int _tiePoints = 0;

  Color _borderUserColor = Colors.transparent;
  Color _borderAppColor = Colors.transparent;

  String _obtemEscolhaApp() {
    var opcoes = ['pedra', 'papel', 'tesoura'];

    String vlrEscolhido = opcoes[Random().nextInt(3)];

    return vlrEscolhido;
  }

  void _terminaJogada(String escolhaUser, String escolhaApp) {
    var resultado = "indefinido";

    switch (escolhaUser) {
      case "pedra":
        if (escolhaApp == "papel") {
          resultado = "app";
        } else if (escolhaApp == "tesoura") {
          resultado = "user";
        } else {
          resultado = "empate";
        }
        break;
      case "papel":
        if (escolhaApp == "pedra") {
          resultado = "user";
        } else if (escolhaApp == "tesoura") {
          resultado = "app";
        } else {
          resultado = "empate";
        }
        break;
      case "tesoura":
        if (escolhaApp == "papel") {
          resultado = "user";
        } else if (escolhaApp == "pedra") {
          resultado = "app";
        } else {
          resultado = "empate";
        }
        break;
    }

    setState(() {
      if (resultado == "user") {
        _userPoints++;
        _borderUserColor = Colors.green;
        _borderAppColor = Colors.transparent;
      } else if (resultado == "app") {
        _appPoints++;
        _borderUserColor = Colors.transparent;
        _borderAppColor = Colors.green;
      } else {
        _tiePoints++;
        _borderUserColor = Colors.orange;
        _borderAppColor = Colors.orange;
      }
    });
  }

  void _iniciaJogada(String opcao) {
    //Configura a opção escolhida pelo usuário:
    setState(() {
      _imgUserPlayer = "images/$opcao.png";
    });

    String escolhaApp = _obtemEscolhaApp();
    setState(() {
      _imgAppPlayer = "images/$escolhaApp.png";
    });

    _terminaJogada(opcao, escolhaApp);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pedra, Papel e Tesoura',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Game - Pedra Papel Tesoura"),
            ),
            body: Column(children: [
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  'Disputa',
                  style: TextStyle(fontSize: 26),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Badge(
                      borderColor: _borderUserColor, imgPlayer: _imgUserPlayer),
                  const Text('VS'),
                  Badge(borderColor: _borderAppColor, imgPlayer: _imgAppPlayer),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  'Placar',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Placar(playerName: 'Você', playerPoints: _userPoints),
                  Placar(playerName: 'Empate', playerPoints: _tiePoints),
                  Placar(playerName: 'App', playerPoints: _appPoints),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  'Opções',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _iniciaJogada("pedra"),
                    child: Image.asset(
                      'images/pedra.png',
                      height: 90,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _iniciaJogada("papel"),
                    child: Image.asset(
                      'images/papel.png',
                      height: 90,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _iniciaJogada("tesoura"),
                    child: Image.asset(
                      'images/tesoura.png',
                      height: 90,
                    ),
                  ),
                ],
              )
            ])));
  }
}

class Placar extends StatelessWidget {
  const Placar({
    Key? key,
    required String playerName,
    required int playerPoints,
  })  : _playerPoints = playerPoints,
        _playerName = playerName,
        super(key: key);

  final int _playerPoints;
  final String _playerName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_playerName),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black45, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(7))),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(35),
          child: Text('$_playerPoints', style: TextStyle(fontSize: 26)),
        )
      ],
    );
  }
}

class Badge extends StatelessWidget {
  const Badge({
    Key? key,
    required Color borderColor,
    required String imgPlayer,
  })  : _borderColor = borderColor,
        _imgPlayer = imgPlayer,
        super(key: key);

  final Color _borderColor;
  final String _imgPlayer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: _borderColor, width: 4),
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: Image.asset(
        _imgPlayer,
        height: 120,
      ),
    );
  }
}
