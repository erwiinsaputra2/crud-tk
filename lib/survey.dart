class Survey {
  int? id;
  String name;
  int age;
  String address;
  String description;

  Survey({this.id, required this.name, required this.age, required this.address, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'address': address,
      'description': description,
    };
  }

  factory Survey.fromMap(Map<String, dynamic> map) {
    return Survey(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      address: map['address'],
      description: map['description'],
    );
  }
}
