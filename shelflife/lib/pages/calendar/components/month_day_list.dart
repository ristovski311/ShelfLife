import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelflife/main.dart';
import 'package:shelflife/pages/calendar/components/day.dart';
import 'package:shelflife/pages/calendar/components/expiration.dart';
import 'package:shelflife/pages/calendar/controller.dart';

class MonthDaysList extends StatefulWidget {
  const MonthDaysList({super.key});

  @override
  State<MonthDaysList> createState() => _MonthDaysListState();
}

class _MonthDaysListState extends State<MonthDaysList> {
  final GlobalKey todayKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = todayKey.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(
          ctx,
          alignment: 0.1,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CalendarController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 64),
      child: Column(
        children: [
          for (int i = 1; i <= controller.getSelectedMonthDuration(); i++)
            Padding(
              key: controller.isDateToday(i) ? todayKey : null,
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                children: [
                  DayCardWidget(
                    dayNum: i,
                    dayOfWeek: controller.getWeekOfTheDay(i).tr,
                    color: controller.getCurrentMonthColor(),
                    isToday: controller.isDateToday(i),
                  ),
                  const SizedBox(height: 2),
                  for (final ex in controller.getExpirationsForGivenDay(i)) ...[
                    ExpirationCardWidget(
                      expiration: ex,
                      controller: controller,
                    ),
                    const SizedBox(height: 4),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }
}
