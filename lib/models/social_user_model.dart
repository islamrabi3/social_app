class SocialUserModel {
  String? id, name, date, email, password, phone, image, bio, cover;
  bool? isConfirmed;

// Constructor
  SocialUserModel(
      {this.id,
      required this.name,
      required this.password,
      this.date,
      required this.email,
      required this.phone,
      this.isConfirmed,
      this.bio,
      this.cover,
      this.image});

  // named Constructor
  SocialUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    email = json['email'];
    bio = json['bio'];
    image = json['image'];
    cover = json['cover'];
    password = json['password'];
    phone = json['phone'];
    isConfirmed = json['isConfirmed'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'password': password,
      'email': email,
      'isConfirmed': isConfirmed,
      'phone': phone,
      'bio': bio,
      'image': image,
      'cover': cover
    };
  }
}
