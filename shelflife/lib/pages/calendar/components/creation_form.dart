import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shelflife/classes/models/category.dart';
import 'package:shelflife/components/text_field.dart';
import 'package:shelflife/main.dart';
import 'package:shelflife/pages/calendar/controller.dart';

class CreationFormWidget extends StatelessWidget {
  final CalendarController controller;
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
    List<Category> categories = controller.categoryList;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Container(
          alignment: Alignment.centerLeft,
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              labelText: "Category".tr,
              hintText: "${"Choose".tr}...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(width: 2, color: Colors.black),
              ),
              labelStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w200,
              ),
            ),
            isExpanded: true,
            alignment: AlignmentGeometry.topStart,
            items: categories
                .map(
                  (c) => DropdownMenuItem(
                    value: c.id,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.category,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          c.name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (newValue) {
              controller.expirationProductCategoryId = newValue ?? 0;
            },
          ),
        ),
        SizedBox(height: 12),
        TextFieldWidget(
          controller: controller.expirationProductBrandController,
          label: "Product brand".tr,
          icon: Icons.branding_watermark,
        ),
        SizedBox(height: 12),
        TextFieldWidget(
          controller: controller.expirationProductNameController,
          label: "Product name".tr,
          icon: Icons.article,
          maxLines: 1,
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            border: Border.all(width: 1, color: Colors.black),
          ),
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      size: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Expiration date".tr,
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
                  Expanded(
                    child: TextField(
                      controller: controller.expirationDayController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          top: 4,
                          bottom: 4,
                          left: 8,
                          right: 8,
                        ),
                        labelText: "Day".tr,
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
                    child: Text("/", textAlign: TextAlign.center),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: controller.expirationMonthController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          top: 4,
                          bottom: 4,
                          left: 8,
                          right: 8,
                        ),
                        labelText: "Month".tr,
                        alignLabelWithHint: true,
                        border: UnderlineInputBorder(),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        labelStyle: TextStyle(fontWeight: FontWeight.w200),
                        fillColor: Theme.of(context).colorScheme.surface
                            .withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Text("/", textAlign: TextAlign.center),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: controller.expirationYearController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          top: 4,
                          bottom: 4,
                          left: 8,
                          right: 8,
                        ),
                        labelText: "Year".tr,
                        labelStyle: TextStyle(fontWeight: FontWeight.w200),
                        fillColor: Theme.of(context).colorScheme.surface
                            .withValues(alpha: 0.3),
                        alignLabelWithHint: true,
                        border: UnderlineInputBorder(),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
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
      ],
    );
  }
}
