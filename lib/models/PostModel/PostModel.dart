class PostModel{
  String? name;
  String? uId;
  String? image;
  String? dataTime;
  String? text;
  String? postImage;
  PostModel({
    this.name,
    this.dataTime,
    this.text,
    this.uId,
    this.image,
    this.postImage,
  });

  PostModel.fromJson(Map<String,dynamic> json){
    dataTime = json['dataTime'];
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
      'dateTime' : dataTime,
      'text' :text,
      'postImage' : postImage,
      'image' : image,
    };
  }
}