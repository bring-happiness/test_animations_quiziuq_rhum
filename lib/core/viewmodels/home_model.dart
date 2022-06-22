import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_animations_quiziuq_rhum/ui/shared/globals.dart';

import '../../ui/shared/globals.dart';

enum HomeModelStatus {
  listPlayers,
  category,
  question,
  success,
  error,
  observer,
  winSet,
  ranking,
  endGame
}

class HomeModel with ChangeNotifier {
  int _index = 0;
  get index => _index;
  set index(value) {
    _index = value;
    notifyListeners();
  }

  bool _isHalfWay = false;
  get isHalfWay => _isHalfWay;
  set isHalfWay(value) {
    _isHalfWay = value;
    notifyListeners();
  }

  bool _isCompleted = false;
  get isCompleted => _isCompleted;
  set isCompleted(value) {
    _isCompleted = value;
    notifyListeners();
  }

  HomeModelStatus _status = HomeModelStatus.listPlayers;
  get status => _status;
  set status(value) {
    _status = value;
    _foreGroundColor = Global.palette[_status.name];
    notifyListeners();
  }

  void swapColors() {
    Color? oldForeGroundColor = _foreGroundColor;
    Color? oldBackGroundColor = _backGroundColor;
    _backGroundColor = oldForeGroundColor;
    _foreGroundColor = oldBackGroundColor;
    notifyListeners();
  }

  Color? _backGroundColor = Global.palette[HomeModelStatus.listPlayers.name];
  get backGroundColor => _backGroundColor;
  set backGroundColor(value) {
    _backGroundColor = value;
    notifyListeners();
  }

  Color? _foreGroundColor = Global.palette[HomeModelStatus.category.name];
  get foreGroundColor => _foreGroundColor;
  set foreGroundColor(value) {
    _foreGroundColor = value;
    notifyListeners();
  }
}