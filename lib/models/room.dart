class Room {
  int id;
  String roomNumber;
  int capacity;
  int floor;

  Room(
      {required this.id,
      required this.roomNumber,
      required this.capacity,
      required this.floor});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
        id: json['id'],
        roomNumber: json['roomNumber'],
        capacity: json['capacity'],
        floor: json['floor']);
  }

  Map toJson() {
    return {
      'id': id,
      'roomNumber': roomNumber,
      'capacity': capacity,
      'floor': floor
    };
  }
}
