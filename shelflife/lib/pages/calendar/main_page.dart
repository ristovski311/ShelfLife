import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelflife/main.dart';
import 'package:shelflife/pages/calendar/components/month_day_list.dart';
import 'package:shelflife/pages/calendar/controller.dart';

class CalendarMainPage extends StatefulWidget {
  const CalendarMainPage({super.key});

  @override
  State<CalendarMainPage> createState() => _CalendarMainPageState();
}

class _CalendarMainPageState extends State<CalendarMainPage> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CalendarController>();
    final monthKey = ValueKey<int>(
      controller.selectedYear * 12 + controller.selectedMonth.index,
    );

    Widget slide(Widget child, Animation<double> animation) {
      final isIncoming = child.key == monthKey;
      final double dir = controller.isGoingForward ? 1.0 : -1.0;

      final offsetAnimation = Tween<Offset>(
        begin: Offset(isIncoming ? dir : -dir, 0),
        end: Offset.zero,
      ).animate(animation);

      return ClipRect(
        child: SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(opacity: animation, child: child),
        ),
      );
    }

    Widget topLayout(Widget? current, List<Widget> previous) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [...previous, ?current],
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const SizedBox(height: 8),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 4),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 12,
                    ),
                    side: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onPressed: () => controller.changeMonth(true),
                  child: const Icon(Icons.arrow_back_ios),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        controller.selectedYear.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                      ),
                      if (!controller.isTodaySelected())
                        InkWell(
                          onTap: () => controller.setToToday(),
                          child: Text(
                            "Return to today".tr,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 12,
                    ),
                    side: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onPressed: () => controller.changeMonth(false),
                  child: const Icon(Icons.arrow_forward_ios),
                ),
                const SizedBox(width: 4),
              ],
            ),
            const SizedBox(height: 4),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              layoutBuilder: topLayout,
              transitionBuilder: slide,
              child: Container(
                key: monthKey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 4),
                    Expanded(
                      child: Container(
                        height: 1.0,
                        color: controller.getCurrentMonthColor(),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      controller.selectedMonth.name.tr,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Container(
                        height: 1.0,
                        color: controller.getCurrentMonthColor(),
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                layoutBuilder: topLayout,
                transitionBuilder: slide,
                child: MonthDaysList(key: monthKey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
