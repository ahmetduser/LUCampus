class Event {
  int id;
  String name;
  String subject;
  int slots;
  int attending;
  String roomNumber;

  Event({
    required this.id,
    required this.name,
    required this.subject,
    required this.slots,
    required this.attending,
    required this.roomNumber,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        name: json['name'],
        subject: json['subject'],
        slots: json['slots'],
        attending: json['attending'],
        roomNumber: json['roomNumber']);
  }

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'subject': subject,
      'slots': slots,
      'attending': attending,
      'roomNumber': roomNumber
    };
  }
}
