class Dish {
  int? id;
  String name = "";
  String photo = "";

  Dish({
    int? id,
    String? name,
    String? photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
    };
  }

  Dish.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    photo = map['photo'];
  }
}
