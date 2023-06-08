class User {
  final String id;
  final String name;
  final String imageUrl;

  const User({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name'], imageUrl: json['imageUrl']);
  }

  @override
  bool operator ==(Object other) {
    return other is User && other.hashCode == hashCode;
  }

  @override
  int get hashCode => Object.hash(id, name, imageUrl);
}
