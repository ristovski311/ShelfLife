import 'package:flutter/material.dart';
import 'package:shelflife/classes/models/category.dart';
import 'package:shelflife/main.dart';

class CategoryCardWidget extends StatelessWidget {
  final Category category;
  const CategoryCardWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
          right: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 4),
          Icon(
            Icons.category,
            size: 32,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                category.description != null
                    ? SizedBox(height: 2)
                    : Container(),
                Text(
                  (category.description == null ||
                          category.description!.isEmpty)
                      ? "No description.".tr
                      : category.description!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
