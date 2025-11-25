class UserModel {
  final String uid;
  final String name;
  final String email;
  final String imageUrl;
  final DateTime lastActive;
  final String token;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.lastActive,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      imageUrl: json["image"],
      lastActive: json["last_active"].toDate(),
      token: json["token"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "name": name,
      "image": imageUrl,
      "last_active": lastActive,
      "token":token,
    };
  }

  String lastDayActive() {
    return "${lastActive.month}/${lastActive.day}/${lastActive.year}";
  }

  bool wasRecentlyActive() {
    return DateTime.now().difference(lastActive).inHours < 2;
  }
}
