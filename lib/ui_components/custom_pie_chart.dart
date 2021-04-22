import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:spesa_app/core/models/lists_model.dart';
import 'package:spesa_app/core/utils/double-utils.dart';
import 'package:spesa_app/core/utils/globals.dart';
import 'package:spesa_app/ui_components/indicator.dart';

class CustomPieChart extends StatefulWidget {
  final List<ListsModel> lists;

  const CustomPieChart({Key key, this.lists}) : super(key: key);

  @override
  _CustomPieChartState createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return widget.lists.isEmpty
        ? AspectRatio(
            aspectRatio: 1.3,
            child: Image(
              image: AssetImage('assets/new_item.png'),
            ),
          )
        : AspectRatio(
            aspectRatio: 1.3,
            child: Card(
              elevation: 0,
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                          pieTouchData:
                              PieTouchData(touchCallback: (pieTouchResponse) {
                            setState(() {
                              final desiredTouch = pieTouchResponse.touchInput
                                      is! PointerExitEvent &&
                                  pieTouchResponse.touchInput
                                      is! PointerUpEvent;
                              if (desiredTouch &&
                                  pieTouchResponse.touchedSection != null) {
                                touchedIndex = pieTouchResponse
                                    .touchedSection.touchedSectionIndex;
                              } else {
                                touchedIndex = -1;
                              }
                            });
                          }),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 3,
                          centerSpaceRadius: 18,
                          sections: showingSections(widget.lists),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Indicator(
                        color: DONE_COLOR,
                        text: 'Done',
                        isSquare: false,
                      ),
                      Indicator(
                        color: TODO_COLOR,
                        text: 'To do',
                        isSquare: false,
                      ),
                      Indicator(
                        color: PENDING_COLOR,
                        text: 'Pending',
                        isSquare: false,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  List<PieChartSectionData> showingSections(List<ListsModel> lists) {
    var done = 0.0;
    var todo = 0.0;
    var pending = 0.0;

    if (lists != null && lists.isNotEmpty) {
      for (var value in lists) {
        if ('D' == value.status) {
          done += 1;
        } else if ('T' == value.status) {
          todo += 1;
        } else {
          pending += 1;
        }
      }

      done = roundDouble(done / lists.length * 100, 1);
      todo = roundDouble(todo / lists.length * 100, 1);
      pending = roundDouble(pending / lists.length * 100, 1);
    }

    var output = <PieChartSectionData>[];

    if (done > 0) {
      output.add(PieChartSectionData(
        color: DONE_COLOR,
        value: done,
        title: '$done%',
        radius: 80,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      ));
    }

    if (todo > 0) {
      output.add(PieChartSectionData(
        color: TODO_COLOR,
        value: todo,
        title: '$todo%',
        radius: 80,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      ));
    }

    if (pending > 0) {
      output.add(PieChartSectionData(
        color: PENDING_COLOR,
        value: pending,
        title: '$pending%',
        radius: 80,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      ));
    }

    return output;
  }
}
