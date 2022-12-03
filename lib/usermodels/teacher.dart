class Teacher {
  String teacherAuthId;
  String name;
  String surname;
  String office;
  String major;

  Teacher(
      {
      required this.teacherAuthId,
      required this.name,
      required this.surname,
      required this.office,
      required this.major});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
        teacherAuthId: json['teacherAuthId'],
        name: json['name'],
        surname: json['surname'],
        office: json['office'],
        major: json['major']);
  }

  Map toJson() {
    return {
      'teacherAuthId': teacherAuthId,
      'name': name,
      'surname': surname,
      'office': office,
      'major': major
    };
  }
}
