import 'dart:async';

import 'package:flutter/foundation.dart';

class TimerState with ChangeNotifier {
  final bool countDown;
  final int initialTime;
  TimerState({this.initialTime = 0, this.countDown = true}) {
    time = initialTime;
  }

  int time = 0;
  Timer timer;

  void tick() {
    time += countDown ? -1 : 1;
    notifyListeners();
  }

  void stop() {
    if (timer != null && timer.isActive) timer.cancel();
  }

  void start() {
    stop();
    timer = Timer.periodic(Duration(seconds: 1), (_) => tick());
  }

  void reset() {
    time = initialTime;
    notifyListeners();
  }

  void dipose() {
    stop();
    super.dispose();
  }
}
