import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelflife/config/toast.dart';
import 'package:shelflife/main.dart';
import 'package:shelflife/pages/calendar/controller.dart';
import 'package:shelflife/pages/calendar/expiration_creation_page.dart';
import 'package:shelflife/pages/navigation_bar/controller.dart';
import 'package:shelflife/pages/products/category_creation_page.dart';
import 'package:shelflife/pages/products/controller.dart';

class NavBarFAB extends StatelessWidget {
  final NavigationBarController controller;
  const NavBarFAB({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        switch (controller.page) {
          case NavigationPages.products:
            return FloatingActionButton.extended(
              label: Text("Add product category".tr),
              icon: Icon(Icons.add),
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              onPressed: () {
                if (controller.page == NavigationPages.products) {
                  final productsController = Provider.of<ProductsController>(
                    context,
                    listen: false,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CategoryCreationPage(controller: productsController),
                    ),
                  );
                }
              },
            );
          case NavigationPages.calendar:
            return FloatingActionButton.extended(
              label: Text("Note an expiration".tr),
              icon: Icon(Icons.timer),
              onPressed: () {
                if (controller.page == NavigationPages.calendar) {
                  final calendarController = Provider.of<CalendarController>(
                    context,
                    listen: false,
                  );

                  calendarController.refreshCategories();

                  if (calendarController.categoryList.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExpirationCreationPage(
                          controller: calendarController,
                        ),
                      ),
                    );
                  } else {
                    ToastService.instance.failure(
                      "${"Create some categories first".tr}!",
                    );
                  }
                }
              },
              backgroundColor: Theme.of(context).colorScheme.tertiary,
            );
          case NavigationPages.home:
            return Container();
          case NavigationPages.about:
            return Container();
          case NavigationPages.settings:
            return Container();
        }
      },
    );
  }
}
