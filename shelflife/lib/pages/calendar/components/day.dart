import 'package:flutter/material.dart';
import 'package:shelflife/main.dart';

class DayCardWidget extends StatelessWidget {
  final int dayNum;
  final String dayOfWeek;
  final Color color;
  final bool isToday;
  const DayCardWidget({
    super.key,
    required this.dayNum,
    required this.dayOfWeek,
    required this.color,
    this.isToday = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 4),
          Text(
            "$dayNum",
            style: TextStyle(
              fontSize: 26,
              color: isToday
                  ? Theme.of(context).colorScheme.primary
                  : Colors.black,
              fontWeight: isToday ? FontWeight.w400 : FontWeight.w300,
            ),
          ),
          SizedBox(width: 4),
          Container(width: 1.0, height: 30, color: color),
          SizedBox(width: 4),
          Text(
            "$dayOfWeek ${isToday ? '[${"Today".tr}]' : ""}",
            style: TextStyle(
              fontSize: 22,
              color: isToday
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.black,
              fontWeight: isToday ? FontWeight.w300 : FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }
}
