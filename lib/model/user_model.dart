class UserModel {
  String? uId, name, email, image, token, phone, password;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.image,
    required this.token,
    required this.phone,
    required this.password,
  });

  factory UserModel.fromMap(Map m1) {
    return UserModel(
      uId: m1['uId'],
      name: m1['name'],
      email: m1['email'],
      image: m1['image'],
      token: m1['token'],
      phone: m1['phone'],
      password: m1['password'],
    );
  }

  Map<String, dynamic> toMap(UserModel user) {
    return {
      'uId': user.uId,
      'name': user.name,
      'email': user.email,
      'image': user.image,
      'token': user.token,
      'phone': user.phone,
      'password': user.password,
    };
  }
}
