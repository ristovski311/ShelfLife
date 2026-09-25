import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelflife/components/illustration.dart';
import 'package:shelflife/components/separator.dart';
import 'package:shelflife/main.dart';
import 'package:shelflife/pages/home/components/expiration.dart';
import 'package:shelflife/pages/home/controller.dart';
import 'package:shelflife/pages/navigation_bar/controller.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  final controller = HomeController();

  @override
  void initState() {
    controller.setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navBarController = context.watch<NavigationBarController>();
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) {
        return Scaffold(
          body: ListView(
            padding: EdgeInsets.all(12),
            children: [
              SizedBox(height: 8),
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello!".tr,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${"Today is".tr} ${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              IllustrationWidget(
                imagePath: "assets/illustrations/HomeIllustration1.png",
              ),
              SizedBox(height: 8),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Soon to expire!".tr,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
              SeparatorWidget(),
              SizedBox(height: 16),
              if (controller.getSoonToExpireProductsHome().isNotEmpty)
                ...controller.getSoonToExpireProductsHome().map((e) {
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: InkWell(
                      onTap: () => navBarController.setPageIndexToCalendar(),
                      child: ExpirationCardWidget(
                        controller: controller,
                        expiration: e,
                      ),
                    ),
                  );
                })
              else ...[
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.check_box, color: Colors.grey, size: 28),
                      SizedBox(height: 8),
                      Text(
                        "No products!".tr,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "All is well.".tr,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
