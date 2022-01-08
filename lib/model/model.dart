
class Model {
  // ignore: prefer_typing_uninitialized_variables
  var id;
  String? name;
  int? age;
  String? email;
  String? department;
  String? password;
  Model(
      {required this.id,
      required this.email,
      required this.password,
      required this.age,
      required this.department,
      required this.name});
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'department': department,
        'age': age,
      };
  static Model fromJson(Map<String, dynamic> json) => Model(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      age: json['age'],
      department: json['department'],
      name: json['name']);
}
