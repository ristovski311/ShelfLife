import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelflife/components/separator.dart';
import 'package:shelflife/config/translation.dart';
import 'package:shelflife/main.dart';
import 'package:shelflife/pages/settings/components/reminder_time.dart';
import 'package:shelflife/pages/settings/controller.dart';

class SettingsMainPage extends StatefulWidget {
  const SettingsMainPage({super.key});

  @override
  State<SettingsMainPage> createState() => _SettingsMainPageState();
}

class _SettingsMainPageState extends State<SettingsMainPage> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsController>();
    return ListenableBuilder(
      listenable: TranslationService.instance,
      builder: (context, child) {
        return Scaffold(
          body: ListView(
            padding: EdgeInsets.all(16),
            children: [
              SizedBox(height: 8),
              Text(
                "Language".tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              SeparatorWidget(),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    top: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    right: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      child: SingleChildScrollView(
                        child: Column(
                          children: controller.languages.entries.map((entry) {
                            final code = entry.key;
                            final name = entry.value['name']!;
                            final flag = entry.value['flag']!;
                            return ListTile(
                              leading: Text(
                                flag,
                                style: const TextStyle(fontSize: 24),
                              ),
                              title: Text(name.tr),
                              trailing: controller.selectedLanguage == code
                                  ? Icon(
                                      Icons.check,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    )
                                  : null,
                              onTap: () {
                                setState(() {
                                  controller.selectLanguage(code);
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Reset expirations reminders".tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              SeparatorWidget(),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    top: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    right: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => {controller.resetAlarmsForExpirations()},
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.only(
                          top: 4,
                          bottom: 4,
                          left: 32,
                          right: 32,
                        ),
                        side: BorderSide(
                          width: 1,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.reset_tv,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Reset".tr,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                        ],
                      ),
                      //child: Text("Delete".tr, style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Reminder time".tr,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              SeparatorWidget(),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    top: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    right: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 12),
                          Text(
                            controller.reminderHour.toString(),
                            style: TextStyle(
                              fontSize: 32,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            ":",
                            style: TextStyle(
                              fontSize: 32,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            (controller.reminderMinute < 10 ? "0" : "") +
                                controller.reminderMinute.toString(),
                            style: TextStyle(
                              fontSize: 32,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                      SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () => {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context)
                                      .viewInsets
                                      .bottom,
                                ),
                                child: ReminderTimeWidget(),
                              );
                            },
                          ),
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.change_circle,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Change".tr,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
