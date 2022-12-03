class Student {
  String studentAuthId;
  String name;
  String surname;
  String email;
  String major;
  String studentId;

  Student(
      {required this.studentAuthId,
      required this.name,
      required this.surname,
      required this.email,
      required this.major,
      required this.studentId});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        studentAuthId: json['studentAuthId'],
        name: json['name'],
        surname: json['surname'],
        email: json['email'],
        major: json['major'],
        studentId: json['studentId']);
  }

  Map toJson() {
    return {
      'studentAuthId': studentAuthId,
      'name': name,
      'surname': surname,
      'email': email,
      'major': major,
      'studentId': studentId
    };
  }
}
