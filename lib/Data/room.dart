class Room {
  int? id;
  int? cid;
  String? name;
  String? type;
  int? occupied;

  Room({
    int? id,
    int? cid,
    String? name,
    String? type,
    int? occupied,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cid': cid,
      'name': name,
      'type': type,
      'occupied': occupied,
    };
  }

  Room.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    cid = map['cid'];
    name = map['name'];
    type = map['type'];
    occupied = map['occupied'];
  }
}
