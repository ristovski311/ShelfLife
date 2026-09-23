import 'package:flutter/material.dart';
import 'package:shelflife/components/illustration.dart';
import 'package:shelflife/components/separator.dart';
import 'package:shelflife/main.dart';
import 'package:shelflife/pages/products/components/creation_form.dart';
import 'package:shelflife/pages/products/controller.dart';

class CategoryCreationPage extends StatefulWidget {
  final ProductsController controller;
  const CategoryCreationPage({super.key, required this.controller});

  @override
  State<CategoryCreationPage> createState() => _CategoryCreationPageState();
}

class _CategoryCreationPageState extends State<CategoryCreationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            margin: EdgeInsets.only(left: 12, right: 12),
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          SizedBox(height: 8),
          IllustrationWidget(
            imagePath: "assets/illustrations/CategoryCreationIllustration1.png",
            height: 180,
          ),
          SizedBox(height: 8),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Create a category".tr,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
            ),
          ),
          SizedBox(height: 8),
          SeparatorWidget(),
          SizedBox(height: 8),
          CreationFormWidget(
            controller: widget.controller,
            onActionPressed: () {
              widget.controller.addCategory();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
