import 'package:flutter/material.dart';
import 'package:shelflife/classes/database/category_rep.dart';
import 'package:shelflife/classes/models/category.dart';
import 'package:shelflife/config/toast.dart';
import 'package:shelflife/main.dart';

class ProductsController extends ChangeNotifier {
  final _categoryRepo = CategoryRep();

  List<Category> categories = [];

  void setup() {
    _refresh();
  }

  Future<void> _refresh() async {
    categories = await _categoryRepo.getAll();
    notifyListeners();
  }

  List<Category> getCategories() {
    return categories;
  }

  int getCategoriesCount() {
    return categories.length;
  }

  //
  // Creation form
  //

  final categoryNameController = TextEditingController(text: "");
  final categoryDescriptionController = TextEditingController(text: "");

  void addCategory() {
    String categoryName = categoryNameController.text;
    String categoryDesc = categoryDescriptionController.text;

    try {
      _categoryRepo.insert(
        Category(
          id: categories.length,
          name: categoryName,
          description: categoryDesc.isEmpty ? "" : categoryDesc,
        ),
      );
      ToastService.instance.success(
        "${"Category".tr} $categoryName ${"createdF".tr} ${"successfully".tr}.",
      );
    } catch (e) {
      ToastService.instance.error("${"An error has occurred".tr}.");
    } finally {
      _refresh();
      categoryNameController.text = "";
      categoryDescriptionController.text = "";
    }
  }
}
