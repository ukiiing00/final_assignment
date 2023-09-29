class UserProfileModel {
  final String uid;
  final String email;
  final String bio;
  final String name;
  final String link;
  final bool hasAvatar;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.bio,
    required this.name,
    required this.link,
    required this.hasAvatar,
  });

  UserProfileModel.empty()
      : uid = "",
        email = "",
        name = "",
        bio = "",
        link = "",
        hasAvatar = false;

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "bio": bio,
      "link": link,
      "hasAvatar": hasAvatar,
    };
  }

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        email = json['email'],
        name = json['name'],
        bio = json['bio'],
        link = json['link'],
        hasAvatar = json['hasAvatar'];

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? bio,
    String? name,
    String? link,
    bool? hasAvatar,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      name: name ?? this.name,
      link: link ?? this.link,
      hasAvatar: hasAvatar ?? this.hasAvatar,
    );
  }
}
