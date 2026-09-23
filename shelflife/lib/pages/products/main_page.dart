import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shelflife/components/illustration.dart';
import 'package:shelflife/components/separator.dart';
import 'package:shelflife/main.dart';
import 'package:shelflife/pages/products/components/category.dart';
import 'package:shelflife/pages/products/controller.dart';

class ProductsMainPage extends StatefulWidget {
  const ProductsMainPage({super.key});

  @override
  State<ProductsMainPage> createState() => _ProductsMainPageState();
}

class _ProductsMainPageState extends State<ProductsMainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProductsController>();

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          SizedBox(height: 8),
          IllustrationWidget(
            imagePath: "assets/illustrations/CategoryIllustration1.png",
          ),
          SizedBox(height: 8),
          Container(
            alignment: Alignment.center,
            child: Text(
              "Product categories".tr,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
            ),
          ),
          SeparatorWidget(),
          SizedBox(height: 16),
          if (controller.getCategoriesCount() == 0) ...[
            Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.cancel_sharp, color: Colors.grey, size: 28),
                  SizedBox(height: 8),
                  Text(
                    "No categories!".tr,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "You can create some categories.".tr,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ] else
            ...controller.getCategories().map((category) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CategoryCardWidget(category: category),
              );
            }),
          SizedBox(height: 64),
        ],
      ),
    );
  }
}
