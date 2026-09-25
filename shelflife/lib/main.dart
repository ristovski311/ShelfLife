import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelflife/config/notifications.dart';
import 'package:shelflife/config/translation.dart';
import 'package:shelflife/pages/calendar/controller.dart';
import 'package:shelflife/pages/navigation_bar/controller.dart';
import 'package:shelflife/pages/navigation_bar/main_page.dart';
import 'package:shelflife/config/theme.dart';
import 'package:shelflife/pages/products/controller.dart';
import 'package:shelflife/pages/settings/controller.dart';

extension Translation on String {
  String get tr => TranslationService.instance.translate(this);
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TranslationService.instance.init();
  await NotificationService.instance.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsController()..setup()),
        ChangeNotifierProvider(create: (_) => NavigationBarController()),
        ChangeNotifierProvider(create: (_) => SettingsController()..setup()),
        ChangeNotifierProvider(create: (_) => CalendarController()..setup()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: getBaseTheme,
        debugShowCheckedModeBanner: false,
        home: NavigationBarMainPage(),
      ),
    ),
  );
}
