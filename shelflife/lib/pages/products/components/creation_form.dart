import 'package:flutter/material.dart';
import 'package:shelflife/components/text_field.dart';
import 'package:shelflife/main.dart';
import 'package:shelflife/pages/products/controller.dart';

class CreationFormWidget extends StatelessWidget {
  final ProductsController controller;
  final VoidCallback onActionPressed;

  const CreationFormWidget({
    super.key,
    required this.controller,
    required this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(8.0),
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
      child: _formFields(context),
    );
  }

  Widget _formFields(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        TextFieldWidget(
          controller: controller.categoryNameController,
          label: "Category name".tr,
          icon: Icons.category,
        ),
        SizedBox(height: 8),
        TextFieldWidget(
          controller: controller.categoryDescriptionController,
          label: "Description".tr,
          icon: Icons.description,

          maxLines: 2,
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: onActionPressed,
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
                "Create".tr,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
