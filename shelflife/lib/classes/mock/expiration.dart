import 'package:shelflife/classes/models/expiration.dart';

final List<Expiration> mockExpirations = [
  // expiration1,
  // expiration2,
  // expiration3,
  // expiration4,
  // expiration5,
  // expiration6,
  // expiration7,
  // expiration8,
  // expiration9,
  // expiration10,
  // expiration11,
  // expiration12,
];

List<Expiration> getSoonToExpireProducts() {
  return mockExpirations
      .where(
        (e) =>
            !e.noted &&
            (daysBetween(DateTime.now(), e.expirationDate) <= 20) &&
            (daysBetween(DateTime.now(), e.expirationDate) >= 0),
      )
      .toList();
}

List<Expiration> getExpirationsForGivenMonth(int month) {
  return mockExpirations.where((e) => e.expirationDate.month == month).toList();
}

void deleteExpiration(int id) {
  mockExpirations.remove(mockExpirations.where((e) => e.id == id).first);
}

void confirmExpirationById(int id) {
  mockExpirations.where((e) => e.id == id).first.noted = true;
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime.utc(from.year, from.month, from.day);
  to = DateTime.utc(to.year, to.month, to.day);
  return to.difference(from).inDays;
}

final expiration1 = Expiration(
  id: 0,
  productBrand: "Milka",
  productName: "Oreo cokolada",
  categoryId: 3,
  expirationDate: DateTime(2026, 10, 3),
  createdAt: DateTime(2026, 9, 18),
);
final expiration2 = Expiration(
  id: 1,
  productBrand: "Jelen",
  productName: "Pivo 0.33",
  categoryId: 5,
  expirationDate: DateTime(2026, 10, 4),
  createdAt: DateTime(2026, 9, 18),
);
final expiration3 = Expiration(
  id: 2,
  productBrand: "Milford",
  productName: "Caj kamilica",
  categoryId: 1,
  expirationDate: DateTime(2026, 9, 30),
  createdAt: DateTime(2026, 9, 18),
);
final expiration4 = Expiration(
  id: 3,
  productBrand: "Swisslion",
  productName: "Krem 0.5kg",
  categoryId: 4,
  expirationDate: DateTime(2026, 10, 5),
  createdAt: DateTime(2026, 9, 18),
);
final expiration5 = Expiration(
  id: 4,
  productBrand: "Rubin",
  productName: "Vino 2l",
  categoryId: 6,
  expirationDate: DateTime(2026, 8, 20),
  createdAt: DateTime(2026, 9, 18),
);
final expiration6 = Expiration(
  id: 5,
  productBrand: "Rubin",
  productName: "Vino 2l",
  categoryId: 6,
  expirationDate: DateTime(2026, 9, 21),
  createdAt: DateTime(2026, 9, 18),
);
final expiration7 = Expiration(
  id: 6,
  productBrand: "LaVita",
  productName: "Sok jabuka",
  categoryId: 7,
  expirationDate: DateTime(2026, 9, 20),
  createdAt: DateTime(2026, 9, 18),
);
final expiration8 = Expiration(
  id: 7,
  productBrand: "Milka",
  productName: "Lesnici",
  categoryId: 6,
  expirationDate: DateTime(2026, 9, 23),
  createdAt: DateTime(2026, 9, 18),
);
final expiration9 = Expiration(
  id: 8,
  productBrand: "Milka",
  productName: "Lesnici",
  categoryId: 6,
  expirationDate: DateTime(2026, 11, 23),
  createdAt: DateTime(2026, 9, 18),
);
final expiration10 = Expiration(
  id: 9,
  productBrand: "Milka",
  productName: "Lesnici",
  categoryId: 6,
  expirationDate: DateTime(2026, 12, 3),
  createdAt: DateTime(2026, 9, 18),
);
final expiration11 = Expiration(
  id: 10,
  productBrand: "Milka",
  productName: "Lesnici",
  categoryId: 6,
  expirationDate: DateTime(2026, 11, 17),
  createdAt: DateTime(2026, 9, 18),
);
final expiration12 = Expiration(
  id: 11,
  productBrand: "Milka",
  productName: "Lesnici",
  categoryId: 6,
  expirationDate: DateTime(2027, 1, 25),
  createdAt: DateTime(2026, 9, 18),
);
