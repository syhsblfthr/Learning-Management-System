class Profile {
  final int id;
  final String name;
  final String email;
  final String? bio;

  Profile({required this.id, required this.name, required this.email, this.bio});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'bio': bio,
    };
  }
}
