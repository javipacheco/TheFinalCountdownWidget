import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_final_countdown_widget/the_final_countdown.dart';

enum GameStatus { COUNTDOWN, PLAYING, IDLE }

const int maxTime = 20;

void main() => runApp(TheFinalCountdownApp());

class TheFinalCountdownApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Final Countdown Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Trench',
      ),
      home: TheFinalCountdownScreen(title: 'The Final Countdown Widget'),
    );
  }
}

class TheFinalCountdownScreen extends StatefulWidget {
  TheFinalCountdownScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TheFinalCountdownScreenState createState() =>
      _TheFinalCountdownScreenState();
}

class _TheFinalCountdownScreenState extends State<TheFinalCountdownScreen> {
  Timer _timerGame;

  GameStatus gameStatus;

  int seconds;

  @override
  void initState() {
    gameStatus = GameStatus.IDLE;
    seconds = maxTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: buildCompleteWidget(),
    );
  }

  Center buildCompleteWidget() {
    return Center(
      child: TheFinalCountdownWidget(
        status: gameStatus,
        seconds: seconds,
        onCountdownStart: () {
          setState(() {
            seconds = maxTime;
            gameStatus = GameStatus.COUNTDOWN;
          });
        },
        onTimeEnd: () {
          stopTimeGame();
          setState(() {
            gameStatus = GameStatus.PLAYING;
            _timerGame = startTimeGame();
          });
        },
      ),
    );
  }

  Timer startTimeGame() {
    return Timer.periodic(Duration(seconds: 1), (timer) {
      if (gameStatus == GameStatus.PLAYING) {
        setState(() {
          seconds = seconds - 1;
        });
        if (seconds <= 0) {
          timer.cancel();
          gameStatus = GameStatus.IDLE;
        }
      }
    });
  }

  void stopTimeGame() {
    if (_timerGame != null) {
      _timerGame.cancel();
      _timerGame = null;
    }
  }
}


