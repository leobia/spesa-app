import 'package:flutter/material.dart';

const Color TODO_COLOR = Color.fromRGBO(252, 202, 64, 1);
const Color PENDING_COLOR = Color.fromRGBO(78, 62, 200, 1);
const Color DONE_COLOR = Color.fromRGBO(241, 113, 5, 1);

const Color TRANSPARENT_TODO_COLOR = Color.fromRGBO(252, 202, 64, 0.55);
const Color TRANSPARENT_PENDING_COLOR = Color.fromRGBO(78, 62, 200, 0.55);
const Color TRANSPARENT_DONE_COLOR = Color.fromRGBO(241, 113, 5, 0.55);

const List<Map> statuses = [
  {"value": "D", "label": "Done"},
  {"value": "T", "label": "To do"},
  {"value": "P", "label": "Pending"}
];
const List<String> statusList = ["Todo", "Pending", "Done"];
const Map<String, String> statusValueMap = {
  "Todo": "T",
  "Pending": "P",
  "Done": "D"
};
const Map<String, String> statusMap = {
  "T": "Todo",
  "P": "Pending",
  "D": "Done"
};
const Map<String, Map<String, Color>> colorsMap = {
  "Todo": {"backgroundColor": TRANSPARENT_TODO_COLOR, "textColor": TODO_COLOR},
  "Pending": {
    "backgroundColor": TRANSPARENT_PENDING_COLOR,
    "textColor": PENDING_COLOR
  },
  "Done": {"backgroundColor": TRANSPARENT_DONE_COLOR, "textColor": DONE_COLOR},
};
