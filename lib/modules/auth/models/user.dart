class User {
  final String fullName;
  final String image;
  final String birthday;
  final String fatherName;
  final String motherName;
  final String username;
  final String phoneNumber;
  final String familyPhoneNumber;
  final City? city;
  final Grade? grade;
  User({
    required this.fullName,
    required this.fatherName,
    required this.city,
    required this.username,
    required this.grade,
    required this.motherName,
    required this.image,
    required this.birthday,
    required this.phoneNumber,
    required this.familyPhoneNumber,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fatherName: json['father_name'] ?? "",
      motherName: json['mother_name'] ?? "",
      birthday: json['birth_date'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
      username: json['username'] ?? "",
      familyPhoneNumber: json['family_phone_number'] ?? "",
      fullName: json['full_name'],
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      grade: json['grade'] != null ? Grade.fromJson(json['grade']) : null,
      image: json['image'] ?? "",
    );
  }
}

class City {
  final String name;
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'],
    );
  }

  City({required this.name});
}

class Grade {
  final String name;
  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      name: json['name'],
    );
  }

  Grade({required this.name});
}
