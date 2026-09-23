import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelflife/components/separator.dart';
import 'package:shelflife/config/translation.dart';
import 'package:shelflife/main.dart';
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
            ],
          ),
        );
      },
    );
  }
}
