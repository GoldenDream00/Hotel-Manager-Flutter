class Employee {
  int? id;
  String name = "";
  String phone = "";
  int present = 0;

  Employee({
    int? id,
    String? name,
    String? type,
    int? present,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'present': present,
      'name': name,
      'phone': phone,
    };
  }

  Employee.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    present = map['present'];
    name = map['name'];
    phone = map['phone'];
  }
}
