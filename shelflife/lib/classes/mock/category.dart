import 'package:shelflife/classes/models/category.dart';

//final List<Category> mockCategories = [];

final List<Category> mockCategories = [
  // fruitCategory,
  // teaCategory,
  // coffeeCategory,
  // chocolateCategory,
  // creamCategory,
  // beerCategory,
  // otherCategory,
];

Category getCategoryById(int id) {
  return mockCategories.where((c) => c.id == id).single;
}

final fruitCategory = Category(id: 0, name: "Fruit", description: "Apples...");
final teaCategory = Category(
  id: 1,
  name: "Tea",
  description: "This is the category for all kinds of teas. Camomile, Mint, Earl Gray and all the rest!",
);
final coffeeCategory = Category(id: 2, name: "Coffee");
final chocolateCategory = Category(
  id: 3,
  name: "Chocolate",
  description:
      "This is probably the favourite category! Everybody loves chocolate!",
);
final creamCategory = Category(id: 4, name: "Cream");
final beerCategory = Category(id: 5, name: "Beer");
final otherCategory = Category(id: 6, name: "Other");
