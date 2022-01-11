class StudentModel {
  // ignore: prefer_typing_uninitialized_variables

  String? name;
  int? age;
  String? phoneno;
  String? department;
  String? schoolname;
  StudentModel(
      {required this.age,
      required this.department,
      required this.name,
      required this.schoolname,required this.phoneno});
  Map<String, dynamic> toJson() => {
        'name': name,
        'department': department,
        'age': age,
        'schoolname': schoolname,
        'phoneno':phoneno
      };
  static StudentModel fromJson(Map<String, dynamic> json) => StudentModel(
      age: json['age'],
      department: json['department'],
      name: json['name'],
      schoolname: json['schoolname'], phoneno: json['phoneno']);
}
