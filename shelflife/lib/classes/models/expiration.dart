class Expiration {
  int id;
  String productBrand;
  String productName;
  int categoryId;
  DateTime expirationDate;
  DateTime createdAt;
  bool noted;

  Expiration({
    required this.id,
    required this.productBrand,
    required this.productName,
    required this.categoryId,
    required this.expirationDate,
    required this.createdAt,
    this.noted = false,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'productBrand': productBrand,
    'productName': productName,
    'categoryId': categoryId,
    'expirationDate': expirationDate.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'noted': noted ? 1 : 0,
  };

  factory Expiration.fromMap(Map<String, dynamic> map) => Expiration(
    id: map['id'] as int,
    productBrand: map['productBrand'] as String,
    productName: map['productName'] as String,
    categoryId: map['categoryId'] as int,
    expirationDate: DateTime.parse(map['expirationDate'] as String),
    createdAt: DateTime.parse(map['createdAt'] as String),
    noted: (map['noted'] as int) == 1,
  );

  int daysUtilExpiration() {
    DateTime from = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    DateTime to = DateTime.utc(
      expirationDate.year,
      expirationDate.month,
      expirationDate.day,
    );
    return to.difference(from).inDays;
  }

  String prettyPrintExpirationDate() {
    return "${expirationDate.day}.${expirationDate.month}.${expirationDate.year}.";
  }

  bool hasExpired() {
    DateTime from = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    DateTime to = DateTime.utc(
      expirationDate.year,
      expirationDate.month,
      expirationDate.day,
    );
    return to.difference(from).inDays < 0;
  }
}
