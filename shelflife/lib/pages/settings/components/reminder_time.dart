import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shelflife/components/separator.dart';
import 'package:shelflife/main.dart';
import 'package:shelflife/pages/settings/controller.dart';

class ReminderTimeWidget extends StatelessWidget {
  const ReminderTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsController>();
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 12),
          Container(
            alignment: Alignment.topCenter,
            child: Text(
              "Change reminder time".tr,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8),
          SeparatorWidget(),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                top: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Time".tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(width: 24),
                    Expanded(
                      child: TextField(
                        controller: controller.hoursController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            top: 4,
                            bottom: 4,
                            left: 8,
                            right: 8,
                          ),
                          labelText: "Hours".tr,
                          labelStyle: TextStyle(fontWeight: FontWeight.w200),
                          fillColor: Theme.of(context).colorScheme.surface
                              .withValues(alpha: 0.3),
                          alignLabelWithHint: true,
                          border: UnderlineInputBorder(),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      alignment: Alignment.topCenter,
                      child: Text(":", textAlign: TextAlign.center),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: controller.minutesController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            top: 4,
                            bottom: 4,
                            left: 8,
                            right: 8,
                          ),
                          alignLabelWithHint: true,
                          labelText: "Minutes".tr,
                          border: UnderlineInputBorder(),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          labelStyle: TextStyle(fontWeight: FontWeight.w200),
                          fillColor: Theme.of(context).colorScheme.surface
                              .withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                    SizedBox(width: 24),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => {
                        controller.changeAlarmTime(),
                        Navigator.pop(context),
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.only(
                          top: 4,
                          bottom: 4,
                          left: 32,
                          right: 32,
                        ),
                        side: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      child: Text(
                        "Confirm".tr,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 64),
        ],
      ),
    );
  }
}
