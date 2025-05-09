class User {
  final String fullName;
  final String image;
  final String birthday;
  final String education;
  final String address;
  final String fatherName;
  final String motherName;
  final String phoneNumber;
  final String familyPhoneNumber;

  User({
    required this.fullName,
    required this.fatherName,
    required this.motherName,
    required this.image,
    required this.education,
    required this.birthday,
    required this.address,
    required this.phoneNumber,
    required this.familyPhoneNumber,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fatherName: json['father_name'] ?? "father_name",
      motherName: json['mother_name'] ?? "mother_name",
      birthday: json['birth_date'] ?? "birthday",
      phoneNumber: json['phone_number'] ?? "phone_number",
      familyPhoneNumber: json['family_phone_number'] ?? "family_phone_number",
      fullName: json['full_name'],
      education: json['education'] ?? "education",
      address: json['address'] ?? "address",
      image: json['image'] ?? "",
    );
  }
}
