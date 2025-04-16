class UserModel{
  String id;
  String email;
  String created_at;

  UserModel({
    required this.id,
    required this.email,
    required this.created_at
  });


  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      id: map['id'],
      email: map['email'],
      created_at: map['created_at']
    );
  }
}