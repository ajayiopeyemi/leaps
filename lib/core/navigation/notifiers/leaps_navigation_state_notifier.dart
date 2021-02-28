import 'package:flutter/material.dart';

class LeapsNavigationStateNotifier with ChangeNotifier {
  int _currentStudentIndex = 0;
  int _currentTeacherIndex = 0;

  get currentStudentIndex => _currentStudentIndex;
  get currentTeacherIndex => _currentTeacherIndex;

  set currentStudentIndex(int index) {
    _currentStudentIndex = index;
    notifyListeners();
  }

  set currentTeacherIndex(int index) {
    _currentTeacherIndex = index;
    notifyListeners();
  }
}
