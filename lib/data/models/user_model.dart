class UserModel{  
  final String id;
  final String full_name;
  final String email;
  final String role;
  final String contact_no;
  final String created_at;

  const UserModel({
    required this.id,
    required this.email,
    required this.created_at,
    required this.full_name,
    required this.role,
    required this.contact_no
  });


  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      id: map['id'],
      email: map['email'],
      created_at: map['created_at'],
      full_name: map['full_name'],
      role: map['role'],
      contact_no: map['contact_no']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'email' : email,
      'created_at': created_at,
      'full_name':full_name,
      'role':role,
      'contact_no':contact_no
    };
  }
}