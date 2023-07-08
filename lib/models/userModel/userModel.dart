class UserModel{
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? bio;
  String? coverImage;
  String? image;
  bool? isEmailVerified;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.image,
    this.coverImage,
    this.bio,
    this.isEmailVerified,
});

  UserModel.fromJson(Map<String,dynamic> json){
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    coverImage = json['coverImage'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'uId': uId,
      'phone' : phone,
      'email' :email,
      'isEmailVerified' : isEmailVerified,
      'image' : image,
      'bio' : bio,
      'coverImage' : coverImage,
    };
  }
}