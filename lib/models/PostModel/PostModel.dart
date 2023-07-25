class PostModel{
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  PostModel({
    this.name,
    this.dateTime,
    this.text,
    this.uId,
    this.image,
    this.postImage,
  });

  PostModel.fromJson(Map<String,dynamic> json){
    dateTime = json['dateTime'];
    name = json['name'];
    text = json['text'];
    uId = json['uId'];
    image = json['image'];
    postImage = json['postImage'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'uId': uId,
      'dateTime' : dateTime,
      'text' :text,
      'postImage' : postImage,
      'image' : image,
    };
  }
}