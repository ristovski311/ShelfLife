import 'package:provider/provider.dart';
import 'package:shelflife/config/translation.dart';
import 'package:shelflife/main.dart';
import 'package:shelflife/pages/navigation_bar/components/navbar_fab.dart';
import 'package:shelflife/pages/products/main_page.dart';
import 'package:shelflife/pages/about/main_page.dart';
import 'package:shelflife/pages/settings/main_page.dart';
import 'package:shelflife/pages/calendar/main_page.dart';
import 'package:shelflife/pages/home/main_page.dart';

import 'controller.dart';

import 'package:flutter/material.dart';

class NavigationBarMainPage extends StatefulWidget {
  const NavigationBarMainPage({super.key});

  @override
  State<NavigationBarMainPage> createState() => _NavigationBarMainPageState();
}

class _NavigationBarMainPageState extends State<NavigationBarMainPage> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NavigationBarController>();
    return Builder(
      builder: (context) {
        return ListenableBuilder(
          listenable: Listenable.merge([
            controller,
            TranslationService.instance,
          ]),
          builder: (context, child) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: false,
                title: Text(
                  {
                    NavigationPages.products: "Products".tr,
                    NavigationPages.calendar: "Calendar".tr,
                    NavigationPages.home: "Home".tr,
                    NavigationPages.about: "About".tr,
                    NavigationPages.settings: "Settings".tr,
                  }[controller.page]!,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w100),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(1.0),
                  child: Container(
                    margin: EdgeInsets.only(left: 12, right: 12),
                    color: Colors.grey,
                    height: 1.0,
                  ),
                ),
              ),
              floatingActionButton: NavBarFAB(controller: controller),
              body: AnimatedSwitcher(
                duration: const Duration(milliseconds: 150),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.04),
                      end: Offset.zero,
                    ).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                child: Container(
                  key: ValueKey<NavigationPages>(controller.page),
                  child: {
                    NavigationPages.products: const ProductsMainPage(),
                    NavigationPages.calendar: const CalendarMainPage(),
                    NavigationPages.home: const HomeMainPage(),
                    NavigationPages.about: const AboutMainPage(),
                    NavigationPages.settings: const SettingsMainPage(),
                  }[controller.page]!,
                ),
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: BottomNavigationBar(
                    onTap: controller.setPageIndex,
                    currentIndex: controller.pageIndex,
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    elevation: 0,
                    selectedItemColor: Theme.of(context).colorScheme.secondary,
                    unselectedItemColor: Theme.of(context).colorScheme.tertiary,
                    items: [
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.add_shopping_cart),
                        label: "Products".tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.calendar_month),
                        label: "Calendar".tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.home),
                        label: "Home".tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.book),
                        label: "About".tr,
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.settings),
                        label: "Settings".tr,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
