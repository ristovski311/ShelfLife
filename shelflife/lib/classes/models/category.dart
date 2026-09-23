class Category {
  int id;
  String name;
  String? description;

  Category({required this.id, required this.name, this.description});

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'description': description,
  };

  factory Category.fromMap(Map<String, dynamic> map) => Category(
    id: map['id'] as int,
    name: map['name'] as String,
    description: map['description'] as String?,
  );
}
