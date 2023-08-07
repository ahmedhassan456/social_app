class CommentModel{
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;

  CommentModel({
    this.name,
    this.dateTime,
    this.text,
    this.uId,
    this.image,
});

  CommentModel.fromJson(Map<String,dynamic> json){
    dateTime = json['dateTime'];
    name = json['name'];
    text = json['text'];
    uId = json['uId'];
    image = json['image'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'uId': uId,
      'dateTime' : dateTime,
      'text' :text,
      'image' : image,
    };
  }
}