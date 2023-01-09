class Dish {
  int? id;
  String name = "";
  String type = "";
  String photo = "";
  int num = 0;

  Dish({
    int? id,
    int? num,
    String? name,
    String? type,
    String? photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'num': num,
      'name': name,
      'type': type,
      'photo': photo,
    };
  }

  Dish.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    num = map['num'];
    name = map['name'];
    type = map['type'];
    photo = map['photo'];
  }
}
