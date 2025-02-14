class RegisterModel {
  final String name;
  final String email;
  final String password;
  final String gender;
  final DateTime birthDate;
  String? id;

  RegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.birthDate,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'gender': gender,
      'birthDate': birthDate.toIso8601String(), // Ensure proper JSON format
      'id': id,
    };
  }

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    // Corrected factory constructor
    return RegisterModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      gender: json['gender'],
      id: json['id'],
      birthDate: DateTime.parse(json['birthDate']),
    );
  }
}
