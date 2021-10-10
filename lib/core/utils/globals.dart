import 'package:flutter/material.dart';

const Color TODO_COLOR = Color.fromRGBO(252, 202, 64, 1);
const Color PENDING_COLOR = Color.fromRGBO(78, 62, 200, 1);
const Color DONE_COLOR = Color.fromRGBO(241, 113, 5, 1);

const Color TRANSPARENT_TODO_COLOR = Color.fromRGBO(255, 237, 186, 1);
const Color TRANSPARENT_PENDING_COLOR = Color.fromRGBO(144, 138, 186, 1);
const Color TRANSPARENT_DONE_COLOR = Color.fromRGBO(240, 192, 151, 1);

const Color TEXT_TODO_COLOR = Color.fromRGBO(230, 169, 0, 1);
const Color TEXT_PENDING_COLOR = Color.fromRGBO(45, 24, 201, 1);
const Color TEXT_DONE_COLOR = Color.fromRGBO(241, 113, 5, 1);

const List<Map> statuses = [
  {'value': 'D', 'label': 'Done'},
  {'value': 'T', 'label': 'Todo'},
  {'value': 'P', 'label': 'Pending'}
];
const List<String> statusList = ['Todo', 'Pending', 'Done'];
const Map<String, String> statusValueMap = {
  'Todo': 'T',
  'Pending': 'P',
  'Done': 'D'
};
const Map<String, String> statusMap = {
  'T': 'Todo',
  'P': 'Pending',
  'D': 'Done'
};
const Map<String, Map<String, Color>> statusColorMap = {
  'Todo': {
    'backgroundColor': TRANSPARENT_TODO_COLOR,
    'textColor': TEXT_TODO_COLOR
  },
  'Pending': {
    'backgroundColor': TRANSPARENT_PENDING_COLOR,
    'textColor': TEXT_PENDING_COLOR
  },
  'Done': {
    'backgroundColor': TRANSPARENT_DONE_COLOR,
    'textColor': TEXT_DONE_COLOR
  },
};

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}