class User {
  final String id;
  final String? name;
  final String contact; // email or phone
  final String contactType; // 'email' or 'phone'
  final String? cpf;
  final String? age;
  final String? city;
  final String? description;
  final List<String>? activities;
  final bool isProfileComplete;

  User({
    required this.id,
    this.name,
    required this.contact,
    required this.contactType,
    this.cpf,
    this.age,
    this.city,
    this.description,
    this.activities,
    this.isProfileComplete = false,
  });

  User copyWith({
    String? id,
    String? name,
    String? contact,
    String? contactType,
    String? cpf,
    String? age,
    String? city,
    String? description,
    List<String>? activities,
    bool? isProfileComplete,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      contact: contact ?? this.contact,
      contactType: contactType ?? this.contactType,
      cpf: cpf ?? this.cpf,
      age: age ?? this.age,
      city: city ?? this.city,
      description: description ?? this.description,
      activities: activities ?? this.activities,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
    );
  }
}
