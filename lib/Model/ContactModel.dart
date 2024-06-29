class Contact {
  String name;
  String username;
  String phone;

  Contact({
    required this.name,
    required this.username,
    required this.phone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'],
      username: json['username'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'phone': phone,
    };
  }
}
