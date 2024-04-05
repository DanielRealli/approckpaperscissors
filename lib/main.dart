import 'package:flutter/material.dart';

void main() {
  runApp(const RockPaperScissorsGame());
}

class RockPaperScissorsGame extends StatefulWidget {
  const RockPaperScissorsGame({Key? key}) : super(key: key);

  @override
  State<RockPaperScissorsGame> createState() => RockPaperScissorsGameState();
}

class RockPaperScissorsGameState extends State<RockPaperScissorsGame> {
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
            body: Column(children: <Widget>[
              Text(""),
              Row(
                children: [
                  Image.asset('images/pedra.png', height: 120),
                  Text('vs'),
                  Image.asset('images/papel.png', height: 120)
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(""),
                      Container(
                        width: 50,
                        height: 50,
                      )
                    ],
                  ),
                ],
              )
            ])));
  }
}
